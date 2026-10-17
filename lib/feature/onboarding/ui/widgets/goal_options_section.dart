import 'package:flutter/material.dart';

import '../../data/models/goal_option.dart';
import 'goal_option_card.dart';

class GoalOptionsSection extends StatefulWidget {
  const GoalOptionsSection({super.key, required this.goals});

  final List<GoalOption> goals;

  @override
  State<GoalOptionsSection> createState() => _GoalOptionsSectionState();
}

class _GoalOptionsSectionState extends State<GoalOptionsSection> {
  String _selectedGoalId = 'get_strong';

  void _selectGoal(String goalId) {
    setState(() => _selectedGoalId = goalId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: widget.goals
          .map(
            (goal) => GoalOptionCard(
              goal: goal,
              isSelected: goal.id == _selectedGoalId,
              onTap: () => _selectGoal(goal.id),
            ),
          )
          .toList(),
    );
  }
}
