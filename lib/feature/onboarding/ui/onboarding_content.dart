import 'package:flutter/material.dart';

import '../data/models/availability_option.dart';
import '../data/models/goal_option.dart';
import 'widgets/goal_options_section.dart';
import 'widgets/onboarding_intro.dart';
import 'widgets/recommendation_card.dart';
import 'widgets/weekly_availability_section.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.goals,
    required this.selectedGoalId,
    required this.onGoalSelected,
    required this.availabilityOptions,
    required this.selectedDays,
    required this.onDaysSelected,
  });

  final List<GoalOption> goals;
  final String selectedGoalId;
  final ValueChanged<String> onGoalSelected;
  final List<AvailabilityOption> availabilityOptions;
  final int selectedDays;
  final ValueChanged<int> onDaysSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingIntro(),
        const SizedBox(height: 32),
        GoalOptionsSection(
          goals: goals,
          selectedGoalId: selectedGoalId,
          onGoalSelected: onGoalSelected,
        ),
        const SizedBox(height: 40),
        WeeklyAvailabilitySection(
          options: availabilityOptions,
          selectedDays: selectedDays,
          onSelected: onDaysSelected,
        ),
        const SizedBox(height: 32),
        const RecommendationCard(),
      ],
    );
  }
}
