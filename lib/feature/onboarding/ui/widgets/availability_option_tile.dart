import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../data/models/availability_option.dart';

class AvailabilityOptionTile extends StatelessWidget {
  const AvailabilityOptionTile({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onSelected,
  });

  final AvailabilityOption option;
  final bool isSelected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primary : Colors.transparent,
      elevation: isSelected ? 2 : 0,
      shadowColor: AppColors.primary.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onSelected(option.days),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              option.label,
              style: isSelected
                  ? AppStyles.font13BoldWhite
                  : AppStyles.font13SemiBoldMuted,
            ),
          ),
        ),
      ),
    );
  }
}
