import 'package:flutter/material.dart';

import 'goal_option_card_skeleton.dart';

class GoalOptionsSkeleton extends StatelessWidget {
  const GoalOptionsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: List.generate(3, (_) => const GoalOptionCardSkeleton()),
    );
  }
}
