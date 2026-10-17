import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../data/models/availability_option.dart';
import 'availability_option_tile.dart';

class WeeklyAvailabilitySection extends StatelessWidget {
  const WeeklyAvailabilitySection({
    super.key,
    required this.options,
    required this.selectedDays,
    required this.onSelected,
  });

  final List<AvailabilityOption> options;
  final int selectedDays;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weekly Availability', style: AppStyles.font18Bold),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              for (final option in options)
                Expanded(
                  child: AvailabilityOptionTile(
                    option: option,
                    isSelected: option.days == selectedDays,
                    onSelected: onSelected,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
