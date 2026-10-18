import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../data/models/complete_workout_plan.dart';
import '../../data/models/exercise.dart';
import '../../data/models/plan_catalog.dart';
import '../repositories/workout_plan_repository.dart';

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
      return Left(
        CacheFailure(
          'No workout plan for ${params.goalId} / ${params.availabilityId}',
        ),
      );
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
          return Left(
            CacheFailure('Exercise ${prescription.exerciseId} not found'),
          );
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
