import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/availability_option.dart';
import '../../presentation/cubits/onboarding_selection/onboarding_selection_cubit.dart';
import '../../presentation/models/onboarding_selection.dart';
import 'availability_option_tile.dart';
import 'recommendation_card.dart';

class AvailabilityOptionsList extends StatelessWidget {
  const AvailabilityOptionsList({super.key, required this.options});

  final List<AvailabilityOption> options;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingSelectionCubit, OnboardingSelection>(
      buildWhen: (previous, current) =>
          previous.availabilityId != current.availabilityId,
      builder: (context, selection) {
        final selectedOption = options.firstWhere(
          (option) => option.id == selection.availabilityId,
          orElse: () => options.first,
        );

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
                  ...options.map(
                    (option) => Expanded(
                      child: AvailabilityOptionTile(
                        option: option,
                        isSelected: option.id == selectedOption.id,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (selectedOption.daysPerWeek == 3) ...[
              const SizedBox(height: 32),
              const RecommendationCard(),
            ],
          ],
        );
      },
    );
  }
}
