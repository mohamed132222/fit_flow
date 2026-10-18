import 'package:equatable/equatable.dart';

class PlanExercisePrescription extends Equatable {
  const PlanExercisePrescription({
    required this.order,
    required this.exerciseId,
    required this.sets,
    required this.repsMin,
    required this.repsMax,
    required this.durationSeconds,
    required this.restSeconds,
  });

  factory PlanExercisePrescription.fromJson(Map<String, dynamic> json) {
    return PlanExercisePrescription(
      order: json['order'] as int,
      exerciseId: json['exerciseId'] as String,
      sets: json['sets'] as int,
      repsMin: json['repsMin'] as int?,
      repsMax: json['repsMax'] as int?,
      durationSeconds: json['durationSeconds'] as int?,
      restSeconds: json['restSeconds'] as int,
    );
  }

  final int order;
  final String exerciseId;
  final int sets;
  final int? repsMin;
  final int? repsMax;
  final int? durationSeconds;
  final int restSeconds;

  @override
  List<Object?> get props => [
    order,
    exerciseId,
    sets,
    repsMin,
    repsMax,
    durationSeconds,
    restSeconds,
  ];
}
