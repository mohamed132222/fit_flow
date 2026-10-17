import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../data/models/goal_option.dart';
import 'goal_radio_indicator.dart';

class GoalOptionCard extends StatelessWidget {
  const GoalOptionCard({
    super.key,
    required this.goal,
    required this.isSelected,
    required this.onTap,
  });

  final GoalOption goal;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.iconTileBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: goal.icon.svg(width: 22, height: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal.title, style: AppStyles.font16Bold),
                    Text(goal.description, style: AppStyles.font13Regular),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GoalRadioIndicator(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }
}
