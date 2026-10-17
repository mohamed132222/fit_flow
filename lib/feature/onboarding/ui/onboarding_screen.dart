import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../data/onboarding_options.dart';
import 'widgets/goal_option_card.dart';
import 'widgets/onboarding_bottom_bar.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/recommendation_card.dart';
import 'widgets/weekly_availability_section.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String _selectedGoalId = 'get_strong';
  int _selectedDays = 3;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            ColoredBox(
              color: AppColors.headerBackground,
              child: SafeArea(
                bottom: false,
                child: OnboardingHeader(onHelpPressed: () {}),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Your Goal', style: AppStyles.font34ExtraBold),
                    const SizedBox(height: 8),
                    Text(
                      'Customize your journey for precision\nperformance.',
                      style: AppStyles.font15Regular,
                    ),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        for (var i = 0; i < goalOptions.length; i++) ...[
                          if (i > 0) const SizedBox(height: 12),
                          GoalOptionCard(
                            goal: goalOptions[i],
                            isSelected: goalOptions[i].id == _selectedGoalId,
                            onTap: () {
                              setState(
                                () => _selectedGoalId = goalOptions[i].id,
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 40),
                    WeeklyAvailabilitySection(
                      options: availabilityOptions,
                      selectedDays: _selectedDays,
                      onSelected: (days) {
                        setState(() => _selectedDays = days);
                      },
                    ),
                    const SizedBox(height: 32),
                    const RecommendationCard(),
                  ],
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
