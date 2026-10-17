import 'package:flutter/material.dart';

import '../../../../core/theme/app_styles.dart';

class OnboardingIntro extends StatelessWidget {
  const OnboardingIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Your Goal', style: AppStyles.font34ExtraBold),
        const SizedBox(height: 8),
        Text(
          'Customize your journey for precision\nperformance.',
          style: AppStyles.font15Regular,
        ),
      ],
    );
  }
}
