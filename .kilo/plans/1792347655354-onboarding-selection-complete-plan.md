# Onboarding Selection + Complete Workout Plan

## Goal

1. Onboarding selection is a non-null model owned by `OnboardingSelectionCubit`; no callbacks and no `setState` for selection.
2. The plan data layer (`plans.json` + `exercises.json`) and `BuildCompleteWorkoutPlan` use case produce one `CompleteWorkoutPlan`.
3. Continue builds the plan only when pressed, then navigates to a placeholder screen that reads the built plan from a shared Cubit. No raw IDs and no `extra`.

## Decisions

- **Data models direct:** no entities, no mappers, matching onboarding.
- **Plan orchestration:** one use case, `BuildCompleteWorkoutPlan`, fetches plans + exercises and merges them.
- **Plan state:** dedicated sealed `BuildCompleteWorkoutPlanState` (Initial / Loading / Success / Failure). Remove `lib/core/state/view_state.dart`; it has no consumers.
- **Selection state:** `OnboardingSelection` with non-null `goalId` and `availabilityId`, initialized from `GoalsConfig` defaults. No null checks in widgets.
- **Config preload:** `initDependencies()` loads `GoalsConfig` once through `OnboardingRepository` and registers it. `GetGoalsConfigCubit` starts in `Success`; `fetch()` remains for retry.
- **Selection Cubit:** `OnboardingSelectionCubit` is constructed with the preloaded `GoalsConfig`; no `applyDefaults`, no screen listener.
- **Providers:** `main.dart` keeps a single `BlocProvider` for `LanguageCubit`. `OnboardingScreen` uses `MultiBlocProvider` for `GetGoalsConfigCubit` + `OnboardingSelectionCubit`. No provider is created for `BuildCompleteWorkoutPlanCubit`.
- **Plan Cubit:** registered as a DI `lazySingleton` and accessed directly with `BlocConsumer(bloc: sl<...>())` / `BlocBuilder(bloc: sl<...>())`. This is intentional app-scoped state so the built plan survives navigation; it is the one exception to the factory-only Cubit rule.
- **Consumers:** `BlocConsumer` handles plan building/navigation. Selection `BlocBuilder`s live inside `GoalOptionsList` and `AvailabilityOptionsList`, not in sections. Sections currently have a builder but no listener, so no section needs `BlocConsumer`; if a section later adds both, use `BlocConsumer` there.
- **Navigation:** `/workout-plan` has no path parameters and no `extra`. `WorkoutPlanScreen` reads the same DI-singleton Cubit. Deep links show its Initial state; there is no fallback route.
- **Boundaries:** plan data layer + plan Cubit live in `feature/workout_plan`; onboarding selection model/Cubit live in `feature/onboarding`; the onboarding screen contains no data-layer logic.

## Out of scope

- Full workout-plan UI, schedule rendering, or editing.
- Persisting the plan or selection.
- Deep-link handling beyond the placeholder's Initial state.
- Prefetching the plan before Continue.

---

## Task 1 — Workout plan data layer

New feature: `lib/feature/workout_plan/`.

### Models (`data/models/`)

Each model has `fromJson` and final fields. Match JSON keys exactly.

1. `exercise.dart` — `Exercise`: `id`, `name`, `muscleGroupLabel`, `category`, `mechanic`, `primaryMuscles`, `secondaryMuscles`, `equipment`, `instructions`, `tips`, `difficulty`, `measurement`, `icon`, `thumbnailUrl`, `videoUrl`.
2. `plan_banner.dart` — `PlanBanner`: `isRecommended`, `badge`, `caption`, `imageKey`, `imageUrl`.
3. `plan_schedule_day.dart` — `PlanScheduleDay`: `dayOfWeek`, `dayKey`, `dayLabel`, `isTrainingDay`, `sessionId` (`String?`).
4. `plan_exercise_prescription.dart` — `PlanExercisePrescription`: `order`, `exerciseId`, `sets`, `repsMin` (`int?`), `repsMax` (`int?`), `durationSeconds` (`int?`), `restSeconds`.
5. `plan_session.dart` — `PlanSession`: `id`, `order`, `name`, `type`, `focus`, `durationMinutes`, `estimatedKcal`, `exerciseCount`, `exercises`.
6. `workout_plan.dart` — `WorkoutPlan`: all plan fields, `banner`, `schedule`, `sessions`.
7. `plan_catalog.dart` — `PlanCatalog`: `version`, `planLookup`, `plans`, plus the mapping methods:

```dart
String? planIdFor({
  required String goalId,
  required String availabilityId,
}) => planLookup['$goalId|$availabilityId'];

WorkoutPlan? planById(String id) { ... }
```

8. `complete_workout_plan.dart`:
   - `CompleteExercise`: `PlanExercisePrescription prescription`, `Exercise exercise`.
   - `CompleteSession`: `PlanSession session`, `List<CompleteExercise> exercises`.
   - `CompleteWorkoutPlan`: `WorkoutPlan plan`, `List<CompleteSession> sessions`, plus `CompleteSession? sessionById(String? id)`.

### Service (`data/services/workout_plan_local_service.dart`)

- Mirror `OnboardingLocalService` with injectable `AssetBundle`.
- `Future<PlanCatalog> loadPlanCatalog()` → `data/plans.json`.
- `Future<List<Exercise>> loadExercises()` → `data/exercises.json` (`json['exercises']`).
- Throw `CacheException` on load/parse failure.

### Repository

`domain/repositories/workout_plan_repository.dart`

```dart
abstract interface class WorkoutPlanRepository {
  ResultFuture<PlanCatalog> getPlans();
  ResultFuture<List<Exercise>> getExercises();
}
```

`data/repositories/workout_plan_repository_impl.dart`

- Depends on `WorkoutPlanLocalService` and `ErrorHandler`.
- Both methods use `errorHandler.guard(...)`.

---

## Task 2 — Use case + plan Cubit

### Use case — `domain/usecases/build_complete_workout_plan.dart`

Keep the requested simple shape:

```dart
class BuildCompleteWorkoutPlanParams extends Equatable {
  const BuildCompleteWorkoutPlanParams({
    required this.goalId,
    required this.availabilityId,
  });

  final String goalId;
  final String availabilityId;

  @override
  List<Object?> get props => [goalId, availabilityId];
}

class BuildCompleteWorkoutPlan {
  const BuildCompleteWorkoutPlan(this._repository);

  final WorkoutPlanRepository _repository;

  ResultFuture<CompleteWorkoutPlan> call(
    BuildCompleteWorkoutPlanParams params,
  ) async {
    final plansResult = await _repository.getPlans();
    final exercisesResult = await _repository.getExercises();

    return plansResult.flatMap(
      (catalog) => exercisesResult.flatMap(
        (exercises) => _compose(catalog, exercises, params),
      ),
    );
  }

  Either<Failure, CompleteWorkoutPlan> _compose(
    PlanCatalog catalog,
    List<Exercise> exercises,
    BuildCompleteWorkoutPlanParams params,
  ) {
    final planId = catalog.planIdFor(
      goalId: params.goalId,
      availabilityId: params.availabilityId,
    );
    if (planId == null) {
      return Left(CacheFailure(
        'No workout plan for ${params.goalId} / ${params.availabilityId}',
      ));
    }

    final plan = catalog.planById(planId);
    if (plan == null) {
      return Left(CacheFailure('Workout plan $planId not found'));
    }

    final exercisesById = {
      for (final exercise in exercises) exercise.id: exercise,
    };
    final sessions = <CompleteSession>[];

    for (final session in plan.sessions) {
      final completeExercises = <CompleteExercise>[];
      for (final prescription in session.exercises) {
        final exercise = exercisesById[prescription.exerciseId];
        if (exercise == null) {
          return Left(CacheFailure(
            'Exercise ${prescription.exerciseId} not found',
          ));
        }
        completeExercises.add(
          CompleteExercise(prescription: prescription, exercise: exercise),
        );
      }
      sessions.add(
        CompleteSession(session: session, exercises: completeExercises),
      );
    }

    return Right(CompleteWorkoutPlan(plan: plan, sessions: sessions));
  }
}
```

### State — `presentation/cubits/build_complete_workout_plan/build_complete_workout_plan_state.dart`

```dart
sealed class BuildCompleteWorkoutPlanState extends Equatable {
  const BuildCompleteWorkoutPlanState();

  @override
  List<Object?> get props => [];
}

final class BuildCompleteWorkoutPlanInitial extends BuildCompleteWorkoutPlanState {
  const BuildCompleteWorkoutPlanInitial();
}

final class BuildCompleteWorkoutPlanLoading extends BuildCompleteWorkoutPlanState {
  const BuildCompleteWorkoutPlanLoading();
}

final class BuildCompleteWorkoutPlanSuccess extends BuildCompleteWorkoutPlanState {
  const BuildCompleteWorkoutPlanSuccess(this.plan);

  final CompleteWorkoutPlan plan;

  @override
  List<Object?> get props => [plan];
}

final class BuildCompleteWorkoutPlanFailure extends BuildCompleteWorkoutPlanState {
  const BuildCompleteWorkoutPlanFailure(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
```

### Cubit — `.../build_complete_workout_plan_cubit.dart`

```dart
class BuildCompleteWorkoutPlanCubit
    extends Cubit<BuildCompleteWorkoutPlanState> {
  BuildCompleteWorkoutPlanCubit(this._build)
      : super(const BuildCompleteWorkoutPlanInitial());

  final BuildCompleteWorkoutPlan _build;

  Future<void> fetchPlan({
    required String goalId,
    required String availabilityId,
  }) async {
    emit(const BuildCompleteWorkoutPlanLoading());
    final result = await _build(
      BuildCompleteWorkoutPlanParams(
        goalId: goalId,
        availabilityId: availabilityId,
      ),
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(BuildCompleteWorkoutPlanFailure(failure)),
      (plan) => emit(BuildCompleteWorkoutPlanSuccess(plan)),
    );
  }
}
```

No fetch in the constructor. Only Continue calls `fetchPlan`.

---

## Task 3 — Preload config + non-null onboarding selection

### `lib/core/di/injection_container.dart`

Load the config once via the repository, register it, then register Cubits:

```dart
Future<void> initDependencies() async {
  sl
    ..registerLazySingleton<ErrorHandler>(() => const ErrorHandler())
    ..registerLazySingleton<OnboardingLocalService>(
      () => OnboardingLocalService(),
    )
    ..registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(service: sl(), errorHandler: sl()),
    );

  final configResult = await sl<OnboardingRepository>().getGoalsConfig();
  final config = configResult.fold(
    (failure) => throw StateError(failure.message),
    (config) => config,
  );
  sl.registerSingleton<GoalsConfig>(config);

  sl
    ..registerFactory(() => GetGoalsConfigCubit(sl(), sl<GoalsConfig>()))
    ..registerFactory(() => OnboardingSelectionCubit(sl<GoalsConfig>()))
    ..registerLazySingleton<WorkoutPlanLocalService>(
      () => WorkoutPlanLocalService(),
    )
    ..registerLazySingleton<WorkoutPlanRepository>(
      () => WorkoutPlanRepositoryImpl(service: sl(), errorHandler: sl()),
    )
    ..registerLazySingleton(() => BuildCompleteWorkoutPlan(sl()))
    ..registerLazySingleton(() => BuildCompleteWorkoutPlanCubit(sl()));
}
```

### `GetGoalsConfigCubit`

Accept the preloaded config and start in success; keep `fetch()` for retry:

```dart
GetGoalsConfigCubit(this._repository, GoalsConfig initialConfig)
    : super(GetGoalsConfigSuccess(initialConfig));
```

### `presentation/models/onboarding_selection.dart`

```dart
class OnboardingSelection extends Equatable {
  OnboardingSelection({required this.goalId, required this.availabilityId});

  String goalId;
  String availabilityId;

  OnboardingSelection copyWith({String? goalId, String? availabilityId}) {
    return OnboardingSelection(
      goalId: goalId ?? this.goalId,
      availabilityId: availabilityId ?? this.availabilityId,
    );
  }

  @override
  List<Object?> get props => [goalId, availabilityId];
}
```

- Non-null from the first frame.
- Fields are mutable, but only the Cubit writes them and always emits a `copyWith` result.

### `presentation/cubits/onboarding_selection/onboarding_selection_cubit.dart`

```dart
class OnboardingSelectionCubit extends Cubit<OnboardingSelection> {
  OnboardingSelectionCubit(GoalsConfig config)
      : super(OnboardingSelection(
          goalId: config.defaultGoalId,
          availabilityId: config.defaultAvailabilityId,
        ));

  void selectGoal(String goalId) => emit(state.copyWith(goalId: goalId));

  void selectAvailability(String availabilityId) =>
      emit(state.copyWith(availabilityId: availabilityId));
}
```

No `applyDefaults` and no config listener.

---

## Task 4 — Onboarding UI

### `lib/main.dart`

Keep only the language provider:

```dart
runApp(
  BlocProvider(
    create: (_) => LanguageCubit(),
    child: const FitFlowApp(),
  ),
);
```

- Do not provide `BuildCompleteWorkoutPlanCubit` here.
- The plan Cubit is the DI lazy singleton; the placeholder resolves the same instance later.

### `lib/feature/onboarding/ui/onboarding_screen.dart`

Use `MultiBlocProvider` for config + selection and a `BlocConsumer` bound to the DI-singleton plan Cubit; keep the screen stateless:

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => sl<GetGoalsConfigCubit>()),
    BlocProvider(create: (_) => sl<OnboardingSelectionCubit>()),
  ],
  child: AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark,
    child: Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SafeArea(bottom: false, child: const OnboardingHeader()),
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: OnboardingContent(),
            ),
          ),
          SafeArea(
            top: false,
            child: BlocBuilder<OnboardingSelectionCubit, OnboardingSelection>(
              buildWhen: (previous, current) =>
                  previous.goalId != current.goalId ||
                  previous.availabilityId != current.availabilityId,
              builder: (context, selection) =>
                  BlocConsumer<BuildCompleteWorkoutPlanCubit,
                      BuildCompleteWorkoutPlanState>(
                bloc: sl<BuildCompleteWorkoutPlanCubit>(),
                listenWhen: (previous, current) =>
                    current is BuildCompleteWorkoutPlanSuccess ||
                    current is BuildCompleteWorkoutPlanFailure,
                listener: (context, state) {
                  switch (state) {
                    case BuildCompleteWorkoutPlanSuccess():
                      context.pushNamed(AppRouterName.workoutPlan);
                    case BuildCompleteWorkoutPlanFailure(:final failure):
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(failure.message)),
                      );
                    default:
                      break;
                  }
                },
                buildWhen: (previous, current) =>
                    (previous is BuildCompleteWorkoutPlanLoading) !=
                    (current is BuildCompleteWorkoutPlanLoading),
                builder: (context, state) {
                  final isLoading = state is BuildCompleteWorkoutPlanLoading;
                  return OnboardingBottomBar(
                    isLoading: isLoading,
                    onContinue: isLoading
                        ? null
                        : () => sl<BuildCompleteWorkoutPlanCubit>().fetchPlan(
                              goalId: selection.goalId,
                              availabilityId: selection.availabilityId,
                            ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  ),
)
```

### `onboarding_bottom_bar.dart`

- `final VoidCallback? onContinue;` and `final bool isLoading;`.
- `onPressed: onContinue`.
- While loading, show a `CircularProgressIndicator` in place of the label/arrow row; keep the 56px height.

### Sections

- `goal_options_section.dart`: success branch becomes `GoalOptionsList(goals: config.goals)` only.
- `weekly_availability_section.dart`: success branch becomes `AvailabilityOptionsList(options: config.availabilityOptions)` only.
- No selection props, no extra `BlocBuilder` in sections.
- Neither section has both a listener and a builder, so neither needs `BlocConsumer`. If a section later gains both, use `BlocConsumer` inside that section.

### Lists (`goal_options_list.dart`, `availability_options_list.dart`)

Move the selection `BlocBuilder` inside each list:

```dart
BlocBuilder<OnboardingSelectionCubit, OnboardingSelection>(
  buildWhen: (previous, current) => previous.goalId != current.goalId,
  builder: (context, selection) => Column(...),
)
```

```dart
BlocBuilder<OnboardingSelectionCubit, OnboardingSelection>(
  buildWhen: (previous, current) =>
      previous.availabilityId != current.availabilityId,
  builder: (context, selection) {
    final selectedOption = options.firstWhere(
      (option) => option.id == selection.availabilityId,
      orElse: () => options.first,
    );
    ...
  },
)
```

- `AvailabilityOptionsList` shows `RecommendationCard` when `selectedOption.daysPerWeek == 3`.
- Both lists stay `StatelessWidget`; no callbacks.

### Cards/tiles

- `GoalOptionCard` takes `GoalOption goal` and `bool isSelected`; on tap:
  `context.read<OnboardingSelectionCubit>().selectGoal(goal.id)`.
- `AvailabilityOptionTile` keeps `option` + `isSelected`; on tap:
  `context.read<OnboardingSelectionCubit>().selectAvailability(option.id)`.

---

## Task 5 — Placeholder route + screen

### `lib/core/router/app_router_name.dart`

```dart
static const String workoutPlan = 'workoutPlan';
static const String workoutPlanPath = '/workout-plan';
```

### `lib/core/router/app_router.dart`

```dart
GoRoute(
  path: AppRouterName.workoutPlanPath,
  name: AppRouterName.workoutPlan,
  builder: (context, state) => const WorkoutPlanScreen(),
),
```

### `lib/feature/workout_plan/ui/workout_plan_screen.dart`

```dart
class WorkoutPlanScreen extends StatelessWidget {
  const WorkoutPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Plan')),
      body: BlocBuilder<BuildCompleteWorkoutPlanCubit,
          BuildCompleteWorkoutPlanState>(
        bloc: sl<BuildCompleteWorkoutPlanCubit>(),
        builder: (context, state) => switch (state) {
          BuildCompleteWorkoutPlanSuccess(:final plan) => Center(
              child: Text(
                '${plan.plan.name}\n'
                '${plan.sessions.length} sessions\n'
                '${plan.sessions.fold<int>(0, (total, session) => total + session.exercises.length)} exercises',
              ),
            ),
          BuildCompleteWorkoutPlanFailure(:final failure) =>
            Center(child: Text(failure.message)),
          BuildCompleteWorkoutPlanInitial() ||
          BuildCompleteWorkoutPlanLoading() =>
            const Center(child: Text('No workout plan built yet')),
        },
      ),
    );
  }
}
```

- No `extra`, no cast, no ID params, and no provider in the route.
- The same DI-singleton Cubit instance is used by onboarding and this screen.
- Deep link shows the Initial message; it does not redirect or fall back.
- Import `flutter_bloc`, `injection_container.dart`, and the Cubit/state.

### `pubspec.yaml`

Add assets:

```yaml
- data/plans.json
- data/exercises.json
```

Keep `data/goals.json`.

### Delete

`lib/core/state/view_state.dart` (verified no other imports).

---

## Performance rules

- `BuildCompleteWorkoutPlanCubit` is a DI lazy singleton; the plan is built only when Continue calls `fetchPlan`.
- `BlocConsumer.buildWhen` limits rebuilds to loading transitions; `listenWhen` limits side effects to success/failure.
- Selection `BlocBuilder`s use `goalId` / `availabilityId` comparisons; lists rebuild only for their own changed value.
- No cubit fetch in `build`, no `setState` for selection, no data work in `OnboardingScreen`.
- Keep static widgets `const` where possible.

## Risks

- Preloading `GoalsConfig` in `initDependencies()` means a broken/missing `goals.json` prevents app startup. This is accepted for a bundled asset; note it if startup error handling is added later.
- The plan Cubit is a DI lazy singleton and keeps the last `CompleteWorkoutPlan` in memory. That is intentional for navigation; it is never disposed by the widget tree. Clear or reset it if a future flow needs a fresh plan.
- `OnboardingSelection` fields are mutable but must never be assigned from widgets; all writes go through Cubit methods.
- Missing plan IDs or exercise IDs return `CacheFailure`; Continue shows a `SnackBar` and does not navigate.
- No fallback route: opening `/workout-plan` directly shows the Initial placeholder state.

## Validation

1. `flutter pub get`.
2. `flutter analyze` — zero issues.
3. Manual:
   - App starts with defaults already selected (no null/empty selection).
   - Changing goal/availability updates only the relevant list.
   - `RecommendationCard` shows only for 3 days.
   - Continue is disabled during loading; success navigates to `/workout-plan`; placeholder shows plan name + session/exercise counts from the same DI-singleton Cubit instance.
   - Back returns to onboarding; pressing Continue again rebuilds without creating a second Cubit.
   - Failure (missing plan/exercise fixture) shows `SnackBar` and stays on onboarding.
4. Tests:
   - `test/onboarding/onboarding_selection_cubit_test.dart`: initial state uses config defaults; select methods emit updated models.
   - `test/workout_plan/plan_catalog_test.dart`: `planIdFor` covers all 12 combinations + unknown key.
   - `test/workout_plan/build_complete_workout_plan_test.dart`: merged sessions/exercises on success; missing plan/exercise yields `Left(CacheFailure)`.
5. Search confirms `ViewState` and selection callbacks are gone.
