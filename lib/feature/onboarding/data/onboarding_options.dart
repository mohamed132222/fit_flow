import '../../../gen/assets.gen.dart';
import 'models/availability_option.dart';
import 'models/goal_option.dart';

final goalOptions = [
  GoalOption(
    id: 'build_muscle',
    title: 'Build Muscle',
    description: 'Focus on hypertrophy and\nstrength.',
    icon: Assets.images.muscles,
  ),
  GoalOption(
    id: 'get_strong',
    title: 'Get Strong',
    description: 'Prioritize heavy lifting and power.',
    icon: Assets.images.bag,
  ),
  GoalOption(
    id: 'general_fitness',
    title: 'General Fitness',
    description: 'Balanced health and mobility.',
    icon: Assets.images.fitness,
  ),
];

const availabilityOptions = [
  AvailabilityOption(days: 2, label: '2 Days'),
  AvailabilityOption(days: 3, label: '3 Days'),
  AvailabilityOption(days: 4, label: '4 Days'),
  AvailabilityOption(days: 5, label: '5+ Days'),
];
