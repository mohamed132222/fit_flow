import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/goals_config.dart';
import '../../models/onboarding_selection.dart';

class OnboardingSelectionCubit extends Cubit<OnboardingSelection> {
  OnboardingSelectionCubit(GoalsConfig config)
    : super(
        OnboardingSelection(
          goalId: config.defaultGoalId,
          availabilityId: config.defaultAvailabilityId,
        ),
      );

  void selectGoal(String goalId) => emit(state.copyWith(goalId: goalId));

  void selectAvailability(String availabilityId) =>
      emit(state.copyWith(availabilityId: availabilityId));
}
