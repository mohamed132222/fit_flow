import 'package:flutter/material.dart';

import '../../../../core/theme/app_styles.dart';
import '../../../../i18n/strings.g.dart';

class SplashBranding extends StatelessWidget {
  const SplashBranding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          t.appName,
          textAlign: TextAlign.center,
          style: AppStyles.font48Bold,
        ),
        const SizedBox(height: 8),
        Text(
          t.splash.tagline,
          textAlign: TextAlign.center,
          style: AppStyles.font14Light,
        ),
      ],
    );
  }
}
