# Onboarding shimmer + per-section Cubit state

## Goal

Replace the full-area `CircularProgressIndicator` on onboarding with skeleton shimmer placeholders that mirror the real goal cards / availability tiles, move the data binding into the sections that consume it, and simplify the cubit with a dedicated readable sealed state.

## Decisions

- Keep Lean architecture and Cubit.
- New sealed state `GetGoalsConfigState` in the cubit folder; stop using `ViewState<GoalsConfig>` for this feature.
- One `BlocBuilder` per consuming section (`GoalOptionsSection`, `WeeklyAvailabilitySection`).
- Custom shimmer widget, no new package.
- Header, intro text, and bottom bar stay visible while loading.
- On failure, each section shows its own error + retry (accepted duplication).

## State shape

New file `lib/feature/onboarding/presentation/cubits/get_goals_config/get_goals_config_state.dart`:

```dart
sealed class GetGoalsConfigState extends Equatable
final class GetGoalsConfigInitial extends GetGoalsConfigState
final class GetGoalsConfigLoading extends GetGoalsConfigState
final class GetGoalsConfigSuccess extends GetGoalsConfigState { final GoalsConfig config; }
final class GetGoalsConfigFailure extends GetGoalsConfigState { final Failure failure; }
```

- `Const` initial/loading; `props` expose config/failure.
- Cubit emits `Initial` from `super`, then `Loading`, then `Success(config)` or `Failure(failure)`.
- Keep the `isClosed` guard after the await.
- UI switches exhaustively on state type (`Success(:final config)`, `Failure(:final failure)`).

## Ordered tasks

1. **State + cubit**
   - Add `get_goals_config_state.dart` as above.
   - Rewrite `GetGoalsConfigCubit` as `Cubit<GetGoalsConfigState>`; remove `ViewState`/`ViewStatus` imports and `copyWith` usage.
   - `ViewState` stays in `core/state` for other features.

2. **Shared custom shimmer**
   - Add `lib/core/common/widgets/app_shimmer.dart`:
     - `StatefulWidget` with `SingleTickerProviderStateMixin`, 1400 ms repeating `AnimationController`.
     - `AnimatedBuilder` + `ShaderMask(blendMode: BlendMode.srcATop)` with a sliding `LinearGradient` (`AppColors.border` → `AppColors.white` → `AppColors.border`).
     - `GradientTransform` shifts horizontally by `bounds.width * (value * 2 - 1)`.
     - Dispose the controller.
   - Add `lib/core/common/widgets/skeleton_box.dart`: simple rounded `Container` with configurable `width`, `height`, `borderRadius` (default 8), color `AppColors.border`.

3. **Goal section**
   - Add `ui/widgets/goal_options_skeleton.dart`: `AppShimmer` wrapping a `Column(spacing: 12)` of 3 card placeholders matching `GoalOptionCard`: white 12-radius bordered card, 16 padding, 48×48 icon tile, two text bars (~14 h / ~10 h), trailing 24×24 circle.
   - Add `ui/widgets/goal_options_list.dart`: move the current selection state/logic here; props `goals`, `initialGoalId`; renders `GoalOptionCard`s.
   - Convert `GoalOptionsSection` to `StatelessWidget` with a `BlocBuilder<GetGoalsConfigCubit, GetGoalsConfigState>`:
     - `Initial || Loading` → `GoalOptionsSkeleton`
     - `Failure` → `OnboardingErrorView(message: failure.message, onRetry: cubit.fetch())`
     - `Success` → `GoalOptionsList(goals: config.goals, initialGoalId: config.defaultGoalId)`

4. **Availability section**
   - Add `ui/widgets/availability_options_skeleton.dart`: `AppShimmer` over the bordered 4-tile container (four `Expanded` ~42 h rounded blocks) + 32 gap + 150 h recommendation card placeholder.
   - Add `ui/widgets/availability_options_list.dart`: move current `_selectedDays` state, tile row, and `RecommendationCard` logic here; props `options`, `initialDays`.
   - Rewrite `WeeklyAvailabilitySection` as `StatelessWidget`: keep static `t.onboarding.weeklyAvailability` title, then a `BlocBuilder`:
     - `Initial || Loading` → `AvailabilityOptionsSkeleton`
     - `Failure` → `OnboardingErrorView(...)`
     - `Success` → `AvailabilityOptionsList(options: config.availabilityOptions, initialDays: config.defaultAvailability?.daysPerWeek ?? config.availabilityOptions.first.daysPerWeek)`

5. **Screen/content cleanup**
   - `OnboardingScreen`: keep `BlocProvider(create: (_) => sl<GetGoalsConfigCubit>()..fetch())`; remove the screen-level `BlocBuilder`, `ViewState`, `GoalsConfig` imports, and loading/error branches.
   - Render header, `Expanded(SingleChildScrollView(padding, child: const OnboardingContent()))`, bottom bar.
   - `OnboardingContent`: remove all data props; compose `OnboardingIntro`, `GoalOptionsSection`, `WeeklyAvailabilitySection`.
   - Delete `ui/widgets/onboarding_loaded_view.dart` (no longer used).
   - Keep `OnboardingErrorView` as the shared section error UI.

## Validation

- `flutter analyze` → no issues.
- `flutter test` → existing 4 tests pass (no new dependency, no pubspec change).
- Manual: cold open onboarding shows header/intro, 3 shimmer goal cards, shimmer availability row + recommendation placeholder; content replaces skeletons without layout jump; retry re-runs fetch and shows shimmer again.

## Risks / notes

- Two independent `BlocBuilder`s against one cubit: both sections update on every emit; failure/retry appears twice by design.
- `Shimmer` animation is infinite; avoid `pumpAndSettle` in any new onboarding widget tests.
- JSON guarantees non-empty availability; retain the existing `.first` fallback.
