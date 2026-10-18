import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../core/error/exceptions.dart';
import '../models/goals_config.dart';

class OnboardingLocalService {
  OnboardingLocalService({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  static const String _goalsAsset = 'data/goals.json';

  final AssetBundle _bundle;

  Future<GoalsConfig> loadGoalsConfig() async {
    try {
      final raw = await _bundle.loadString(_goalsAsset);
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return GoalsConfig.fromJson(json);
    } on AppException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (error) {
      throw CacheException('Failed to load goals data: $error');
    }
  }
}
