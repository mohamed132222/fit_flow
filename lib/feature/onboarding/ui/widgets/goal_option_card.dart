import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../data/models/goal_option.dart';
import '../../presentation/cubits/onboarding_selection/onboarding_selection_cubit.dart';
import '../onboarding_labels.dart';
import 'goal_radio_indicator.dart';

class GoalOptionCard extends StatelessWidget {
  const GoalOptionCard({
    super.key,
    required this.goal,
    required this.isSelected,
  });

  final GoalOption goal;
  final bool isSelected;

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
        onTap: () =>
            context.read<OnboardingSelectionCubit>().selectGoal(goal.id),
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
                child: OnboardingLabels.goalIcon(
                  goal.iconKey,
                ).svg(width: 22, height: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      OnboardingLabels.goalTitle(goal.id),
                      style: AppStyles.font16Bold,
                    ),
                    Text(
                      OnboardingLabels.goalDescription(goal.id),
                      style: AppStyles.font13Regular,
                    ),
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
