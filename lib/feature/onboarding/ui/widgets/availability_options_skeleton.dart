import 'package:flutter/material.dart';

import '../../../../../core/common/widgets/app_shimmer.dart';
import '../../../../../core/common/widgets/skeleton_box.dart';
import '../../../../../core/theme/app_colors.dart';

class AvailabilityOptionsSkeleton extends StatelessWidget {
  const AvailabilityOptionsSkeleton({super.key});

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
          child: AppShimmer(
            child: Row(
              children: List.generate(
                4,
                (_) => const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: SkeletonBox(height: 40),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        const AppShimmer(
          child: SkeletonBox(height: 150, borderRadius: 12),
        ),
      ],
    );
  }
}
