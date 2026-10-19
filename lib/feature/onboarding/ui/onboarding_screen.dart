import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/router/app_router_name.dart';
import '../../../core/theme/app_colors.dart';
import '../presentation/cubits/build_complete_workout_plan/build_complete_workout_plan_cubit.dart';
import '../presentation/cubits/build_complete_workout_plan/build_complete_workout_plan_state.dart';
import '../presentation/cubits/get_goals_config/get_goals_config_cubit.dart';
import '../presentation/cubits/onboarding_selection/onboarding_selection_cubit.dart';
import '../presentation/models/onboarding_input.dart';
import '../presentation/models/onboarding_selection.dart';
import 'onboarding_content.dart';
// Rule: avoid many vars in constructors; pass a model instead. See dev_rules.md
import 'widgets/onboarding_bottom_bar.dart';
import 'widgets/onboarding_header.dart';
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<GetGoalsConfigCubit>()),
        BlocProvider(create: (_) => sl<OnboardingSelectionCubit>()),
      ],
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
              SafeArea(
                top: false,
                child:
                    BlocBuilder<OnboardingSelectionCubit, OnboardingSelection>(
                  buildWhen: (previous, current) =>
                      previous.goalId != current.goalId ||
                      previous.availabilityId != current.availabilityId,
                  builder: (context, selection) =>
                      BlocConsumer<
                        BuildCompleteWorkoutPlanCubit,
                        BuildCompleteWorkoutPlanState
                      >(
                    bloc: sl<BuildCompleteWorkoutPlanCubit>(),
                    listenWhen: (previous, current) =>
                        current is BuildCompleteWorkoutPlanSuccess ||
                        current is BuildCompleteWorkoutPlanFailure,
                    listener: (context, state) {
                      switch (state) {
                        case BuildCompleteWorkoutPlanSuccess():
                          context.pushNamed(AppRouterName.workoutPlan);
                        case BuildCompleteWorkoutPlanFailure(
                              :final failure,
                            ):
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(failure.message)),
                          );
                        default:
                          break;
                      }
                    },
                    buildWhen: (previous, current) =>
                        (previous is BuildCompleteWorkoutPlanLoading) !=
                        (current is BuildCompleteWorkoutPlanLoading),
                    builder: (context, state) {
                      final isLoading = state is BuildCompleteWorkoutPlanLoading;
                      return OnboardingBottomBar(
                        isLoading: isLoading,
onContinue: isLoading
    ? null
    : () => sl<BuildCompleteWorkoutPlanCubit>().fetchPlan(
      OnboardingInput(
        goalId: selection.goalId,
        availabilityId: selection.availabilityId,
      ),
    ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}