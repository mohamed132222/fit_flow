import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../core/error/exceptions.dart';
import '../models/exercise.dart';
import '../models/plan_catalog.dart';

class WorkoutPlanLocalService {
  WorkoutPlanLocalService({AssetBundle? bundle})
    : _bundle = bundle ?? rootBundle;

  static const String _plansAsset = 'data/plans.json';
  static const String _exercisesAsset = 'data/exercises.json';

  final AssetBundle _bundle;

  Future<PlanCatalog> loadPlanCatalog() async {
    try {
      final raw = await _bundle.loadString(_plansAsset);
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return PlanCatalog.fromJson(json);
    } on AppException {
      rethrow;
    } catch (error) {
      throw CacheException('Failed to load plans data: $error');
    }
  }

  Future<List<Exercise>> loadExercises() async {
    try {
      final raw = await _bundle.loadString(_exercisesAsset);
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return (json['exercises'] as List<dynamic>)
          .map(
            (exercise) => Exercise.fromJson(exercise as Map<String, dynamic>),
          )
          .toList();
    } on AppException {
      rethrow;
    } catch (error) {
      throw CacheException('Failed to load exercises data: $error');
    }
  }
}
