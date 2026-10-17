import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../i18n/strings.g.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.6,
            child: Assets.images.onboardingImage.image(fit: BoxFit.cover),
          ),
          Assets.images.onBoardingShadow.image(fit: BoxFit.cover),
          Positioned(
            left: 16,
            right: 16,
            bottom: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(t.onboarding.recommended, style: AppStyles.font10BoldPrimary),
                Text(
                  t.onboarding.recoveryCycle,
                  style: AppStyles.font11MediumHint,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
