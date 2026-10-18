import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection_container.dart';
import '../../onboarding/presentation/cubits/build_complete_workout_plan/build_complete_workout_plan_cubit.dart';
import '../../onboarding/presentation/cubits/build_complete_workout_plan/build_complete_workout_plan_state.dart';

class WorkoutPlanScreen extends StatelessWidget {
  const WorkoutPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Plan')),
      body:
          BlocBuilder<
            BuildCompleteWorkoutPlanCubit,
            BuildCompleteWorkoutPlanState
          >(
            bloc: sl<BuildCompleteWorkoutPlanCubit>(),
            builder: (context, state) => switch (state) {
              BuildCompleteWorkoutPlanSuccess(:final plan) => Center(
                child: Text(
                  '${plan.plan.name}\n'
                  '${plan.sessions.length} sessions\n'
                  '${plan.sessions.fold<int>(0, (total, session) => total + session.exercises.length)} exercises',
                ),
              ),
              BuildCompleteWorkoutPlanFailure(:final failure) => Center(
                child: Text(failure.message),
              ),
              BuildCompleteWorkoutPlanInitial() ||
              BuildCompleteWorkoutPlanLoading() => const Center(
                child: Text('No workout plan built yet'),
              ),
            },
          ),
    );
  }
}
