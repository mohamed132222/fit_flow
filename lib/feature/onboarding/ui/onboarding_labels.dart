import '../../../gen/assets.gen.dart';
import '../../../i18n/strings.g.dart';

class OnboardingLabels {
  const OnboardingLabels._();

  static String goalTitle(String goalId) => switch (goalId) {
    'goal_build_muscle' => t.onboarding.goals.buildMuscle.title,
    'goal_get_strong' => t.onboarding.goals.getStrong.title,
    'goal_general_fitness' => t.onboarding.goals.generalFitness.title,
    _ => goalId,
  };

  static String goalDescription(String goalId) => switch (goalId) {
    'goal_build_muscle' => t.onboarding.goals.buildMuscle.description,
    'goal_get_strong' => t.onboarding.goals.getStrong.description,
    'goal_general_fitness' => t.onboarding.goals.generalFitness.description,
    _ => goalId,
  };

  static String availabilityLabel(String availabilityId) =>
      switch (availabilityId) {
        'days_2' => t.onboarding.availability.days2,
        'days_3' => t.onboarding.availability.days3,
        'days_4' => t.onboarding.availability.days4,
        'days_5plus' => t.onboarding.availability.days5plus,
        _ => availabilityId,
      };

  static SvgGenImage goalIcon(String iconKey) => switch (iconKey) {
    'fitness_center' => Assets.images.muscles,
    'weight' => Assets.images.bag,
    'directions_run' => Assets.images.fitness,
    _ => Assets.images.fitness,
  };
}
