import '../../../../core/utils/typedefs.dart';
import '../../data/models/goals_config.dart';

abstract interface class OnboardingRepository {
  ResultFuture<GoalsConfig> getGoalsConfig();
}
