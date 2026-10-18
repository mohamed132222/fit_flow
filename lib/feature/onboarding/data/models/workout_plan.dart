import 'package:equatable/equatable.dart';

import 'plan_banner.dart';
import 'plan_schedule_day.dart';
import 'plan_session.dart';

class WorkoutPlan extends Equatable {
  const WorkoutPlan({
    required this.id,
    required this.goalId,
    required this.availabilityId,
    required this.daysPerWeek,
    required this.name,
    required this.level,
    required this.description,
    required this.durationWeeks,
    required this.sessionsPerWeek,
    required this.avgSessionMinutes,
    required this.weeklyMinutes,
    required this.weeklyEstimatedKcal,
    required this.uniqueExerciseCount,
    required this.targetMuscles,
    required this.progression,
    required this.banner,
    required this.schedule,
    required this.sessions,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(
      id: json['id'] as String,
      goalId: json['goalId'] as String,
      availabilityId: json['availabilityId'] as String,
      daysPerWeek: json['daysPerWeek'] as int,
      name: json['name'] as String,
      level: json['level'] as String,
      description: json['description'] as String,
      durationWeeks: json['durationWeeks'] as int,
      sessionsPerWeek: json['sessionsPerWeek'] as int,
      avgSessionMinutes: json['avgSessionMinutes'] as int,
      weeklyMinutes: json['weeklyMinutes'] as int,
      weeklyEstimatedKcal: json['weeklyEstimatedKcal'] as int,
      uniqueExerciseCount: json['uniqueExerciseCount'] as int,
      targetMuscles: (json['targetMuscles'] as List<dynamic>)
          .map((muscle) => muscle as String)
          .toList(),
      progression: json['progression'] as String,
      banner: PlanBanner.fromJson(json['banner'] as Map<String, dynamic>),
      schedule: (json['schedule'] as List<dynamic>)
          .map((day) => PlanScheduleDay.fromJson(day as Map<String, dynamic>))
          .toList(),
      sessions: (json['sessions'] as List<dynamic>)
          .map(
            (session) => PlanSession.fromJson(session as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final String id;
  final String goalId;
  final String availabilityId;
  final int daysPerWeek;
  final String name;
  final String level;
  final String description;
  final int durationWeeks;
  final int sessionsPerWeek;
  final int avgSessionMinutes;
  final int weeklyMinutes;
  final int weeklyEstimatedKcal;
  final int uniqueExerciseCount;
  final List<String> targetMuscles;
  final String progression;
  final PlanBanner banner;
  final List<PlanScheduleDay> schedule;
  final List<PlanSession> sessions;

  @override
  List<Object?> get props => [
    id,
    goalId,
    availabilityId,
    daysPerWeek,
    name,
    level,
    description,
    durationWeeks,
    sessionsPerWeek,
    avgSessionMinutes,
    weeklyMinutes,
    weeklyEstimatedKcal,
    uniqueExerciseCount,
    targetMuscles,
    progression,
    banner,
    schedule,
    sessions,
  ];
}
