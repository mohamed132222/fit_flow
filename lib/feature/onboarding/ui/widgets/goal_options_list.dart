import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/cubits/onboarding_selection/onboarding_selection_cubit.dart';
import '../../presentation/models/onboarding_selection.dart';
import '../../data/models/goal_option.dart';
import 'goal_option_card.dart';

class GoalOptionsList extends StatelessWidget {
  const GoalOptionsList({super.key, required this.goals});

  final List<GoalOption> goals;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingSelectionCubit, OnboardingSelection>(
      buildWhen: (previous, current) => previous.goalId != current.goalId,
      builder: (context, selection) => Column(
        spacing: 12,
        children: goals
            .map(
              (goal) => GoalOptionCard(
                goal: goal,
                isSelected: goal.id == selection.goalId,
              ),
            )
            .toList(),
      ),
    );
  }
}
