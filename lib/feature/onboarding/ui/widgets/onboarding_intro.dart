import 'package:flutter/material.dart';

import '../../../../core/theme/app_styles.dart';
import '../../../../i18n/strings.g.dart';

class OnboardingIntro extends StatelessWidget {
  const OnboardingIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.onboarding.title, style: AppStyles.font34ExtraBold),
        const SizedBox(height: 8),
        Text(
          t.onboarding.subtitle,
          style: AppStyles.font15Regular,
        ),
      ],
    );
  }
}
