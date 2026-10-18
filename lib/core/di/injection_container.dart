import 'package:get_it/get_it.dart';

import '../../feature/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../feature/onboarding/data/services/onboarding_local_service.dart';
import '../../feature/onboarding/domain/repositories/onboarding_repository.dart';
import '../../feature/onboarding/presentation/cubits/get_goals_config/get_goals_config_cubit.dart';
import '../error/error_handler.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  sl
    ..registerLazySingleton<ErrorHandler>(() => const ErrorHandler())
    ..registerLazySingleton<OnboardingLocalService>(
      () => OnboardingLocalService(),
    )
    ..registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(service: sl(), errorHandler: sl()),
    )
    ..registerFactory(() => GetGoalsConfigCubit(sl()));
}
