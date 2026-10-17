import '../../../gen/assets.gen.dart';
import '../../../i18n/strings.g.dart';
import 'models/availability_option.dart';
import 'models/goal_option.dart';

List<GoalOption> get goalOptions => [
  GoalOption(
    id: 'build_muscle',
    title: t.onboarding.goals.buildMuscle.title,
    description: t.onboarding.goals.buildMuscle.description,
    icon: Assets.images.muscles,
  ),
  GoalOption(
    id: 'get_strong',
    title: t.onboarding.goals.getStrong.title,
    description: t.onboarding.goals.getStrong.description,
    icon: Assets.images.bag,
  ),
  GoalOption(
    id: 'general_fitness',
    title: t.onboarding.goals.generalFitness.title,
    description: t.onboarding.goals.generalFitness.description,
    icon: Assets.images.fitness,
  ),
];

List<AvailabilityOption> get availabilityOptions => [
  AvailabilityOption(
    days: 2,
    label: t.onboarding.availability.days2,
  ),
  AvailabilityOption(
    days: 3,
    label: t.onboarding.availability.days3,
  ),
  AvailabilityOption(
    days: 4,
    label: t.onboarding.availability.days4,
  ),
  AvailabilityOption(
    days: 5,
    label: t.onboarding.availability.days5plus,
  ),
];
