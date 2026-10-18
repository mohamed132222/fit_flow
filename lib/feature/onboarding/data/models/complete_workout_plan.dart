import 'package:equatable/equatable.dart';

import 'exercise.dart';
import 'plan_exercise_prescription.dart';
import 'plan_session.dart';
import 'workout_plan.dart';

class CompleteExercise extends Equatable {
  const CompleteExercise({required this.prescription, required this.exercise});

  final PlanExercisePrescription prescription;
  final Exercise exercise;

  @override
  List<Object?> get props => [prescription, exercise];
}

class CompleteSession extends Equatable {
  const CompleteSession({required this.session, required this.exercises});

  final PlanSession session;
  final List<CompleteExercise> exercises;

  @override
  List<Object?> get props => [session, exercises];
}

class CompleteWorkoutPlan extends Equatable {
  const CompleteWorkoutPlan({required this.plan, required this.sessions});

  final WorkoutPlan plan;
  final List<CompleteSession> sessions;

  CompleteSession? sessionById(String? id) {
    if (id == null) return null;
    for (final session in sessions) {
      if (session.session.id == id) return session;
    }
    return null;
  }

  @override
  List<Object?> get props => [plan, sessions];
}
