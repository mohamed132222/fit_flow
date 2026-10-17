import 'package:flutter/material.dart';

import '../data/models/availability_option.dart';
import '../data/models/goal_option.dart';
import 'widgets/goal_options_section.dart';
import 'widgets/onboarding_intro.dart';
import 'widgets/weekly_availability_section.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.goals,
    required this.availabilityOptions,
  });

  final List<GoalOption> goals;
  final List<AvailabilityOption> availabilityOptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingIntro(),
        const SizedBox(height: 32),
        GoalOptionsSection(goals: goals),
        const SizedBox(height: 40),
        WeeklyAvailabilitySection(options: availabilityOptions),
      ],
    );
  }
}
