import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../data/models/availability_option.dart';
import 'availability_option_tile.dart';
import 'recommendation_card.dart';

class WeeklyAvailabilitySection extends StatefulWidget {
  const WeeklyAvailabilitySection({super.key, required this.options});

  final List<AvailabilityOption> options;

  @override
  State<WeeklyAvailabilitySection> createState() =>
      _WeeklyAvailabilitySectionState();
}

class _WeeklyAvailabilitySectionState extends State<WeeklyAvailabilitySection> {
  int _selectedDays = 3;

  void _selectDays(int days) {
    setState(() => _selectedDays = days);
  }

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
              ...widget.options.map(
                (option) => Expanded(
                  child: AvailabilityOptionTile(
                    option: option,
                    isSelected: option.days == _selectedDays,
                    onSelected: _selectDays,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_selectedDays == 3) ...[
          const SizedBox(height: 32),
          const RecommendationCard(),
        ],
      ],
    );
  }
}
