import 'package:equatable/equatable.dart';

import 'workout_plan.dart';

class PlanCatalog extends Equatable {
  const PlanCatalog({
    required this.version,
    required this.planLookup,
    required this.plans,
  });

  factory PlanCatalog.fromJson(Map<String, dynamic> json) {
    final lookup = json['planLookup'] as Map<String, dynamic>;

    return PlanCatalog(
      version: json['version'] as int,
      planLookup: {
        for (final entry in lookup.entries) entry.key: entry.value as String,
      },
      plans: (json['plans'] as List<dynamic>)
          .map((plan) => WorkoutPlan.fromJson(plan as Map<String, dynamic>))
          .toList(),
    );
  }

  final int version;
  final Map<String, String> planLookup;
  final List<WorkoutPlan> plans;

  String? planIdFor({required String goalId, required String availabilityId}) =>
      planLookup['$goalId|$availabilityId'];

  WorkoutPlan? planById(String id) {
    for (final plan in plans) {
      if (plan.id == id) return plan;
    }
    return null;
  }

  @override
  List<Object?> get props => [version, planLookup, plans];
}
