import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/build_complete_workout_plan.dart';
import '../../models/onboarding_input.dart';
import 'build_complete_workout_plan_state.dart';

class BuildCompleteWorkoutPlanCubit
    extends Cubit<BuildCompleteWorkoutPlanState> {
  BuildCompleteWorkoutPlanCubit(this._build)
    : super(const BuildCompleteWorkoutPlanInitial());

  final BuildCompleteWorkoutPlan _build;

  Future<void> fetchPlan(OnboardingInput input) async {
    emit(const BuildCompleteWorkoutPlanLoading());
    final result = await _build(
      BuildCompleteWorkoutPlanParams(
        goalId: input.goalId,
        availabilityId: input.availabilityId,
      ),
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(BuildCompleteWorkoutPlanFailure(failure)),
      (plan) => emit(BuildCompleteWorkoutPlanSuccess(plan)),
    );
  }
}
