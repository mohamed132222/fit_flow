import '../../../../core/error/error_handler.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../models/goals_config.dart';
import '../services/onboarding_local_service.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl({
    required this.service,
    required this.errorHandler,
  });

  final OnboardingLocalService service;
  final ErrorHandler errorHandler;

  @override
  ResultFuture<GoalsConfig> getGoalsConfig() =>
      errorHandler.guard(service.loadGoalsConfig);
}
