import 'package:get_it/get_it.dart';

import '../../feature/onboarding/data/models/goals_config.dart';
import '../../feature/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../feature/onboarding/data/services/onboarding_local_service.dart';
import '../../feature/onboarding/domain/repositories/onboarding_repository.dart';
import '../../feature/onboarding/presentation/cubits/get_goals_config/get_goals_config_cubit.dart';
import '../../feature/onboarding/presentation/cubits/onboarding_selection/onboarding_selection_cubit.dart';
import '../../feature/onboarding/data/repositories/workout_plan_repository_impl.dart';
import '../../feature/onboarding/data/services/workout_plan_local_service.dart';
import '../../feature/onboarding/domain/repositories/workout_plan_repository.dart';
import '../../feature/onboarding/domain/usecases/build_complete_workout_plan.dart';
import '../../feature/onboarding/presentation/cubits/build_complete_workout_plan/build_complete_workout_plan_cubit.dart';
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
    );

  final configResult = await sl<OnboardingRepository>().getGoalsConfig();
  final config = configResult.fold(
    (failure) => throw StateError(failure.message),
    (config) => config,
  );
  sl.registerSingleton<GoalsConfig>(config);

  sl
    ..registerFactory(() => GetGoalsConfigCubit(sl(), sl<GoalsConfig>()))
    ..registerFactory(() => OnboardingSelectionCubit(sl<GoalsConfig>()))
    ..registerLazySingleton<WorkoutPlanLocalService>(
      () => WorkoutPlanLocalService(),
    )
    ..registerLazySingleton<WorkoutPlanRepository>(
      () => WorkoutPlanRepositoryImpl(service: sl(), errorHandler: sl()),
    )
    ..registerLazySingleton(() => BuildCompleteWorkoutPlan(sl()))
    ..registerLazySingleton(() => BuildCompleteWorkoutPlanCubit(sl()));
}
