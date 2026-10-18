import 'package:flutter/material.dart';

import 'widgets/goal_options_section.dart';
import 'widgets/onboarding_intro.dart';
import 'widgets/weekly_availability_section.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnboardingIntro(),
        SizedBox(height: 32),
        GoalOptionsSection(),
        SizedBox(height: 40),
        WeeklyAvailabilitySection(),
      ],
    );
  }
}
