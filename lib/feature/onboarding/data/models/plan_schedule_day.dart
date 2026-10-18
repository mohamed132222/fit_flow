import 'package:equatable/equatable.dart';

class PlanScheduleDay extends Equatable {
  const PlanScheduleDay({
    required this.dayOfWeek,
    required this.dayKey,
    required this.dayLabel,
    required this.isTrainingDay,
    required this.sessionId,
  });

  factory PlanScheduleDay.fromJson(Map<String, dynamic> json) {
    return PlanScheduleDay(
      dayOfWeek: json['dayOfWeek'] as int,
      dayKey: json['dayKey'] as String,
      dayLabel: json['dayLabel'] as String,
      isTrainingDay: json['isTrainingDay'] as bool,
      sessionId: json['sessionId'] as String?,
    );
  }

  final int dayOfWeek;
  final String dayKey;
  final String dayLabel;
  final bool isTrainingDay;
  final String? sessionId;

  @override
  List<Object?> get props => [
    dayOfWeek,
    dayKey,
    dayLabel,
    isTrainingDay,
    sessionId,
  ];
}
