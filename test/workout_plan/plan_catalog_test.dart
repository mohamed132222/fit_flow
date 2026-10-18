import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:fit_flow/feature/onboarding/data/models/plan_catalog.dart';

void main() {
  late PlanCatalog catalog;

  setUpAll(() {
    final raw = File('data/plans.json').readAsStringSync();
    catalog = PlanCatalog.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  });

  test('planIdFor resolves all twelve goal/availability combinations', () {
    const goals = [
      'goal_build_muscle',
      'goal_get_strong',
      'goal_general_fitness',
    ];
    const availabilities = ['days_2', 'days_3', 'days_4', 'days_5plus'];

    for (final goalId in goals) {
      for (final availabilityId in availabilities) {
        final planId = catalog.planIdFor(
          goalId: goalId,
          availabilityId: availabilityId,
        );

        expect(planId, isNotNull, reason: '$goalId|$availabilityId');
        expect(catalog.planById(planId!), isNotNull);
      }
    }
  });

  test('planIdFor returns null for an unknown combination', () {
    expect(
      catalog.planIdFor(goalId: 'goal_unknown', availabilityId: 'days_2'),
      isNull,
    );
  });

  test('planById returns null for an unknown id', () {
    expect(catalog.planById('plan_unknown'), isNull);
  });
}
