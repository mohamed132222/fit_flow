import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:fit_flow/core/error/failures.dart';
import 'package:fit_flow/core/utils/typedefs.dart';
import 'package:fit_flow/feature/onboarding/data/models/exercise.dart';
import 'package:fit_flow/feature/onboarding/data/models/plan_banner.dart';
import 'package:fit_flow/feature/onboarding/data/models/plan_catalog.dart';
import 'package:fit_flow/feature/onboarding/data/models/plan_exercise_prescription.dart';
import 'package:fit_flow/feature/onboarding/data/models/plan_session.dart';
import 'package:fit_flow/feature/onboarding/data/models/workout_plan.dart';
import 'package:fit_flow/feature/onboarding/domain/repositories/workout_plan_repository.dart';
import 'package:fit_flow/feature/onboarding/domain/usecases/build_complete_workout_plan.dart';

class _FakeRepository implements WorkoutPlanRepository {
  _FakeRepository({required this.catalog, required this.exercises});

  final PlanCatalog catalog;
  final List<Exercise> exercises;

  @override
  ResultFuture<PlanCatalog> getPlans() async => Right(catalog);

  @override
  ResultFuture<List<Exercise>> getExercises() async => Right(exercises);
}

const _prescription = PlanExercisePrescription(
  order: 1,
  exerciseId: 'ex_bench',
  sets: 3,
  repsMin: 8,
  repsMax: 10,
  durationSeconds: null,
  restSeconds: 90,
);

const _session = PlanSession(
  id: 'session_1',
  order: 1,
  name: 'Full Body A',
  type: 'strength',
  focus: ['Chest'],
  durationMinutes: 55,
  estimatedKcal: 330,
  exerciseCount: 1,
  exercises: [_prescription],
);

const _plan = WorkoutPlan(
  id: 'plan_1',
  goalId: 'goal_1',
  availabilityId: 'days_2',
  daysPerWeek: 2,
  name: 'Test Plan',
  level: 'beginner',
  description: 'A plan',
  durationWeeks: 8,
  sessionsPerWeek: 2,
  avgSessionMinutes: 55,
  weeklyMinutes: 110,
  weeklyEstimatedKcal: 660,
  uniqueExerciseCount: 1,
  targetMuscles: ['chest'],
  progression: 'Add reps',
  banner: PlanBanner(
    isRecommended: false,
    badge: 'BADGE',
    caption: 'Caption',
    imageKey: 'banner',
    imageUrl: 'https://example.com/banner.png',
  ),
  schedule: [],
  sessions: [_session],
);

const _exercise = Exercise(
  id: 'ex_bench',
  name: 'Bench Press',
  muscleGroupLabel: 'Chest',
  category: 'push',
  mechanic: 'compound',
  primaryMuscles: ['chest'],
  secondaryMuscles: ['triceps'],
  equipment: ['Barbell'],
  instructions: ['Press'],
  tips: ['Brace'],
  difficulty: 'beginner',
  measurement: 'reps',
  icon: 'fitness_center',
  thumbnailUrl: 'https://example.com/bench.png',
  videoUrl: 'https://example.com/bench.mp4',
);

void main() {
  test('merges sessions and exercises on success', () async {
    final useCase = BuildCompleteWorkoutPlan(
      _FakeRepository(
        catalog: const PlanCatalog(
          version: 1,
          planLookup: {'goal_1|days_2': 'plan_1'},
          plans: [_plan],
        ),
        exercises: [_exercise],
      ),
    );

    final result = await useCase(
      const BuildCompleteWorkoutPlanParams(
        goalId: 'goal_1',
        availabilityId: 'days_2',
      ),
    );

    final plan = result.getOrElse((_) => throw StateError('expected Right'));

    expect(plan.plan.id, 'plan_1');
    expect(plan.sessions, hasLength(1));
    expect(plan.sessions.first.exercises, hasLength(1));
    expect(plan.sessions.first.exercises.first.exercise.id, 'ex_bench');
    expect(plan.sessionById('session_1')?.session.id, 'session_1');
    expect(plan.sessionById('missing'), isNull);
    expect(plan.sessionById(null), isNull);
  });

  test('returns CacheFailure when the plan lookup is missing', () async {
    final useCase = BuildCompleteWorkoutPlan(
      _FakeRepository(
        catalog: const PlanCatalog(version: 1, planLookup: {}, plans: [_plan]),
        exercises: [_exercise],
      ),
    );

    final result = await useCase(
      const BuildCompleteWorkoutPlanParams(
        goalId: 'goal_1',
        availabilityId: 'days_2',
      ),
    );

    expect(result.isLeft(), isTrue);
    result.fold(
      (failure) => expect(failure, isA<CacheFailure>()),
      (_) => fail('expected Left'),
    );
  });

  test('returns CacheFailure when an exercise is missing', () async {
    final useCase = BuildCompleteWorkoutPlan(
      _FakeRepository(
        catalog: const PlanCatalog(
          version: 1,
          planLookup: {'goal_1|days_2': 'plan_1'},
          plans: [_plan],
        ),
        exercises: const [],
      ),
    );

    final result = await useCase(
      const BuildCompleteWorkoutPlanParams(
        goalId: 'goal_1',
        availabilityId: 'days_2',
      ),
    );

    expect(result.isLeft(), isTrue);
    result.fold(
      (failure) => expect(failure, isA<CacheFailure>()),
      (_) => fail('expected Left'),
    );
  });
}
