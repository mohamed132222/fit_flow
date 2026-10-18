import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../data/models/availability_option.dart';
import '../../presentation/cubits/onboarding_selection/onboarding_selection_cubit.dart';
import '../onboarding_labels.dart';

class AvailabilityOptionTile extends StatelessWidget {
  const AvailabilityOptionTile({
    super.key,
    required this.option,
    required this.isSelected,
  });

  final AvailabilityOption option;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primary : Colors.transparent,
      elevation: isSelected ? 2 : 0,
      shadowColor: AppColors.primary.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context
            .read<OnboardingSelectionCubit>()
            .selectAvailability(option.id),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              OnboardingLabels.availabilityLabel(option.id),
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
