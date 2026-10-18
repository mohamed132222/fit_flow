import '../../../../core/error/error_handler.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repositories/workout_plan_repository.dart';
import '../models/exercise.dart';
import '../models/plan_catalog.dart';
import '../services/workout_plan_local_service.dart';

class WorkoutPlanRepositoryImpl implements WorkoutPlanRepository {
  const WorkoutPlanRepositoryImpl({
    required this.service,
    required this.errorHandler,
  });

  final WorkoutPlanLocalService service;
  final ErrorHandler errorHandler;

  @override
  ResultFuture<PlanCatalog> getPlans() =>
      errorHandler.guard(service.loadPlanCatalog);

  @override
  ResultFuture<List<Exercise>> getExercises() =>
      errorHandler.guard(service.loadExercises);
}
