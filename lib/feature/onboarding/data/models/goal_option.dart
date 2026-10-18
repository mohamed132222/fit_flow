class GoalOption {
  const GoalOption({
    required this.id,
    required this.title,
    required this.description,
    required this.iconKey,
  });

  factory GoalOption.fromJson(Map<String, dynamic> json) {
    return GoalOption(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconKey: json['icon'] as String,
    );
  }

  final String id;
  final String title;
  final String description;
  final String iconKey;
}
