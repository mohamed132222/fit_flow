import '../../../../core/utils/typedefs.dart';
import '../../data/models/exercise.dart';
import '../../data/models/plan_catalog.dart';

abstract interface class WorkoutPlanRepository {
  ResultFuture<PlanCatalog> getPlans();
  ResultFuture<List<Exercise>> getExercises();
}
