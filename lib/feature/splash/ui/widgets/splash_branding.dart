import 'package:flutter/material.dart';

import '../../../../core/theme/app_styles.dart';

class SplashBranding extends StatelessWidget {
  const SplashBranding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'FitFlow',
          textAlign: TextAlign.center,
          style: AppStyles.font48Bold,
        ),
        const SizedBox(height: 8),
        Text(
          'ELEVATE YOUR MOVEMENT',
          textAlign: TextAlign.center,
          style: AppStyles.font14Light,
        ),
      ],
    );
  }
}
