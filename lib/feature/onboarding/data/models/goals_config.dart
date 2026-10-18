import 'availability_option.dart';
import 'goal_option.dart';

class GoalsConfig {
  const GoalsConfig({
    required this.defaultGoalId,
    required this.defaultAvailabilityId,
    required this.goals,
    required this.availabilityOptions,
  });

  factory GoalsConfig.fromJson(Map<String, dynamic> json) {
    final screen = json['selectGoalScreen'] as Map<String, dynamic>;

    return GoalsConfig(
      defaultGoalId: screen['defaultGoalId'] as String,
      defaultAvailabilityId: screen['defaultAvailabilityId'] as String,
      goals: (json['goals'] as List<dynamic>)
          .map((goal) => GoalOption.fromJson(goal as Map<String, dynamic>))
          .toList(),
      availabilityOptions: (json['availabilityOptions'] as List<dynamic>)
          .map(
            (option) =>
                AvailabilityOption.fromJson(option as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final String defaultGoalId;
  final String defaultAvailabilityId;
  final List<GoalOption> goals;
  final List<AvailabilityOption> availabilityOptions;

  AvailabilityOption? get defaultAvailability {
    for (final option in availabilityOptions) {
      if (option.id == defaultAvailabilityId) return option;
    }
    return null;
  }
}
