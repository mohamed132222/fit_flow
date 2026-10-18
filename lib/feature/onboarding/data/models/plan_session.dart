import 'package:equatable/equatable.dart';

import 'plan_exercise_prescription.dart';

class PlanSession extends Equatable {
  const PlanSession({
    required this.id,
    required this.order,
    required this.name,
    required this.type,
    required this.focus,
    required this.durationMinutes,
    required this.estimatedKcal,
    required this.exerciseCount,
    required this.exercises,
  });

  factory PlanSession.fromJson(Map<String, dynamic> json) {
    return PlanSession(
      id: json['id'] as String,
      order: json['order'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      focus: (json['focus'] as List<dynamic>)
          .map((item) => item as String)
          .toList(),
      durationMinutes: json['durationMinutes'] as int,
      estimatedKcal: json['estimatedKcal'] as int,
      exerciseCount: json['exerciseCount'] as int,
      exercises: (json['exercises'] as List<dynamic>)
          .map(
            (exercise) => PlanExercisePrescription.fromJson(
              exercise as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  final String id;
  final int order;
  final String name;
  final String type;
  final List<String> focus;
  final int durationMinutes;
  final int estimatedKcal;
  final int exerciseCount;
  final List<PlanExercisePrescription> exercises;

  @override
  List<Object?> get props => [
    id,
    order,
    name,
    type,
    focus,
    durationMinutes,
    estimatedKcal,
    exerciseCount,
    exercises,
  ];
}
