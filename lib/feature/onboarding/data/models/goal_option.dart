import '../../../../gen/assets.gen.dart';

class GoalOption {
  const GoalOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String id;
  final String title;
  final String description;
  final SvgGenImage icon;
}
