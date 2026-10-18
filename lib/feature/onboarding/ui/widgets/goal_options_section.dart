import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/cubits/get_goals_config/get_goals_config_cubit.dart';
import '../../presentation/cubits/get_goals_config/get_goals_config_state.dart';
import 'goal_options_list.dart';
import 'goal_options_skeleton.dart';
import 'onboarding_error_view.dart';

class GoalOptionsSection extends StatelessWidget {
  const GoalOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetGoalsConfigCubit, GetGoalsConfigState>(
      builder: (context, state) => switch (state) {
        GetGoalsConfigInitial() ||
        GetGoalsConfigLoading() => const GoalOptionsSkeleton(),
        GetGoalsConfigFailure(:final failure) => OnboardingErrorView(
          message: failure.message,
          onRetry: () => context.read<GetGoalsConfigCubit>().fetch(),
        ),
        GetGoalsConfigSuccess(:final config) => GoalOptionsList(
          goals: config.goals,
        ),
      },
    );
  }
}
