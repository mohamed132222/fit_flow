import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class GoalRadioIndicator extends StatelessWidget {
  const GoalRadioIndicator({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primary : AppColors.white,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.radioBorder,
        ),
      ),
      child: isSelected
          ? const SizedBox(
              width: 8,
              height: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
              ),
            )
          : null,
    );
  }
}
