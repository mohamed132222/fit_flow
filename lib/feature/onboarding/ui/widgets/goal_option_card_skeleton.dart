import 'package:flutter/material.dart';

import '../../../../../core/common/widgets/app_shimmer.dart';
import '../../../../../core/common/widgets/skeleton_box.dart';
import '../../../../../core/theme/app_colors.dart';

class GoalOptionCardSkeleton extends StatelessWidget {
  const GoalOptionCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: const AppShimmer(
        child: Row(
          children: [
            SkeletonBox(width: 48, height: 48),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: 120, height: 14),
                  SizedBox(height: 8),
                  SkeletonBox(width: 180, height: 10),
                ],
              ),
            ),
            SizedBox(width: 12),
            SkeletonBox(width: 24, height: 24, borderRadius: 12),
          ],
        ),
      ),
    );
  }
}
