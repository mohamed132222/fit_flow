import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../data/onboarding_options.dart';
import 'onboarding_content.dart';
import 'widgets/onboarding_bottom_bar.dart';
import 'widgets/onboarding_header.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String _selectedGoalId = 'get_strong';
  int _selectedDays = 3;

  void _selectGoal(String goalId) {
    setState(() => _selectedGoalId = goalId);
  }

  void _selectDays(int days) {
    setState(() => _selectedDays = days);
  }

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
              child: OnboardingHeader(onHelpPressed: () {}),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 32,
                ),
                child: OnboardingContent(
                  goals: goalOptions,
                  selectedGoalId: _selectedGoalId,
                  onGoalSelected: _selectGoal,
                  availabilityOptions: availabilityOptions,
                  selectedDays: _selectedDays,
                  onDaysSelected: _selectDays,
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
