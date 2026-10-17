import 'package:flutter/material.dart';

import '../../data/models/goal_option.dart';
import 'goal_option_card.dart';

class GoalOptionsSection extends StatelessWidget {
  const GoalOptionsSection({
    super.key,
    required this.goals,
    required this.selectedGoalId,
    required this.onGoalSelected,
  });

  final List<GoalOption> goals;
  final String selectedGoalId;
  final ValueChanged<String> onGoalSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: goals
          .map(
            (goal) => GoalOptionCard(
              goal: goal,
              isSelected: goal.id == selectedGoalId,
              onTap: () => onGoalSelected(goal.id),
            ),
          )
          .toList(),
    );
  }
}
