import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/availability_option.dart';
import 'availability_option_tile.dart';
import 'recommendation_card.dart';

class AvailabilityOptionsList extends StatefulWidget {
  const AvailabilityOptionsList({
    super.key,
    required this.options,
    required this.initialDays,
  });

  final List<AvailabilityOption> options;
  final int initialDays;

  @override
  State<AvailabilityOptionsList> createState() =>
      _AvailabilityOptionsListState();
}

class _AvailabilityOptionsListState extends State<AvailabilityOptionsList> {
  late int _selectedDays;

  @override
  void initState() {
    super.initState();
    _selectedDays = widget.initialDays;
  }

  void _selectDays(int days) {
    setState(() => _selectedDays = days);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    isSelected: option.daysPerWeek == _selectedDays,
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
