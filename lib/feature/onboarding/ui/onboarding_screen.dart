import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection_container.dart';
import '../../../core/theme/app_colors.dart';
import '../presentation/cubits/get_goals_config/get_goals_config_cubit.dart';
import 'onboarding_content.dart';
import 'widgets/onboarding_bottom_bar.dart';
import 'widgets/onboarding_header.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetGoalsConfigCubit>()..fetch(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              SafeArea(bottom: false, child: const OnboardingHeader()),
              const Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: OnboardingContent(),
                ),
              ),
              SafeArea(top: false, child: OnboardingBottomBar(onContinue: () {})),
            ],
          ),
        ),
      ),
    );
  }
}
