import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/complete_workout_plan.dart';

sealed class BuildCompleteWorkoutPlanState extends Equatable {
  const BuildCompleteWorkoutPlanState();

  @override
  List<Object?> get props => [];
}

final class BuildCompleteWorkoutPlanInitial
    extends BuildCompleteWorkoutPlanState {
  const BuildCompleteWorkoutPlanInitial();
}

final class BuildCompleteWorkoutPlanLoading
    extends BuildCompleteWorkoutPlanState {
  const BuildCompleteWorkoutPlanLoading();
}

final class BuildCompleteWorkoutPlanSuccess
    extends BuildCompleteWorkoutPlanState {
  const BuildCompleteWorkoutPlanSuccess(this.plan);

  final CompleteWorkoutPlan plan;

  @override
  List<Object?> get props => [plan];
}

final class BuildCompleteWorkoutPlanFailure
    extends BuildCompleteWorkoutPlanState {
  const BuildCompleteWorkoutPlanFailure(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
