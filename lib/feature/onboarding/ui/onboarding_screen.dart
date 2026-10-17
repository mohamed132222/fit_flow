import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../data/onboarding_options.dart';
import 'onboarding_content.dart';
import 'widgets/onboarding_bottom_bar.dart';
import 'widgets/onboarding_header.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            SafeArea(
              bottom: false,
              child:const OnboardingHeader(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 32,
                ),
                child: OnboardingContent(
                  goals: goalOptions,
                  availabilityOptions: availabilityOptions,
                ),
              ),
            ),
            SafeArea(top: false, child: OnboardingBottomBar(onContinue: () {})),
          ],
        ),
      ),
    );
  }
}
