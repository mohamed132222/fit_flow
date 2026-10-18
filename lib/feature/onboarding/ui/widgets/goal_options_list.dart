import 'package:flutter/material.dart';

import '../../data/models/goal_option.dart';
import 'goal_option_card.dart';

class GoalOptionsList extends StatefulWidget {
  const GoalOptionsList({
    super.key,
    required this.goals,
    required this.initialGoalId,
  });

  final List<GoalOption> goals;
  final String initialGoalId;

  @override
  State<GoalOptionsList> createState() => _GoalOptionsListState();
}

class _GoalOptionsListState extends State<GoalOptionsList> {
  late String _selectedGoalId;

  @override
  void initState() {
    super.initState();
    _selectedGoalId = widget.initialGoalId;
  }

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
              goalId: goal.id,
              iconKey: goal.iconKey,
              isSelected: goal.id == _selectedGoalId,
              onTap: () => _selectGoal(goal.id),
            ),
          )
          .toList(),
    );
  }
}
