import 'package:flutter_test/flutter_test.dart';

import 'package:fit_flow/feature/onboarding/data/models/availability_option.dart';
import 'package:fit_flow/feature/onboarding/data/models/goal_option.dart';
import 'package:fit_flow/feature/onboarding/data/models/goals_config.dart';
import 'package:fit_flow/feature/onboarding/presentation/cubits/onboarding_selection/onboarding_selection_cubit.dart';

const _config = GoalsConfig(
  defaultGoalId: 'goal_build_muscle',
  defaultAvailabilityId: 'days_3',
  goals: [
    GoalOption(
      id: 'goal_build_muscle',
      title: 'Build Muscle',
      description: 'Build muscle',
      iconKey: 'fitness_center',
    ),
  ],
  availabilityOptions: [
    AvailabilityOption(id: 'days_2', label: '2 days', daysPerWeek: 2),
    AvailabilityOption(id: 'days_3', label: '3 days', daysPerWeek: 3),
  ],
);

void main() {
  test('initial state uses config defaults', () {
    final cubit = OnboardingSelectionCubit(_config);

    expect(cubit.state.goalId, 'goal_build_muscle');
    expect(cubit.state.availabilityId, 'days_3');

    cubit.close();
  });

  test('selectGoal emits an updated selection', () {
    final cubit = OnboardingSelectionCubit(_config);

    cubit.selectGoal('goal_get_strong');

    expect(cubit.state.goalId, 'goal_get_strong');
    expect(cubit.state.availabilityId, 'days_3');

    cubit.close();
  });

  test('selectAvailability emits an updated selection', () {
    final cubit = OnboardingSelectionCubit(_config);

    cubit.selectAvailability('days_2');

    expect(cubit.state.goalId, 'goal_build_muscle');
    expect(cubit.state.availabilityId, 'days_2');

    cubit.close();
  });
}
