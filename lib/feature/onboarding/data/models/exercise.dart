import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroupLabel,
    required this.category,
    required this.mechanic,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.equipment,
    required this.instructions,
    required this.tips,
    required this.difficulty,
    required this.measurement,
    required this.icon,
    required this.thumbnailUrl,
    required this.videoUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      muscleGroupLabel: json['muscleGroupLabel'] as String,
      category: json['category'] as String,
      mechanic: json['mechanic'] as String,
      primaryMuscles: (json['primaryMuscles'] as List<dynamic>)
          .map((muscle) => muscle as String)
          .toList(),
      secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>)
          .map((muscle) => muscle as String)
          .toList(),
      equipment: (json['equipment'] as List<dynamic>)
          .map((item) => item as String)
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((instruction) => instruction as String)
          .toList(),
      tips: (json['tips'] as List<dynamic>)
          .map((tip) => tip as String)
          .toList(),
      difficulty: json['difficulty'] as String,
      measurement: json['measurement'] as String,
      icon: json['icon'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      videoUrl: json['videoUrl'] as String,
    );
  }

  final String id;
  final String name;
  final String muscleGroupLabel;
  final String category;
  final String mechanic;
  final List<String> primaryMuscles;
  final List<String> secondaryMuscles;
  final List<String> equipment;
  final List<String> instructions;
  final List<String> tips;
  final String difficulty;
  final String measurement;
  final String icon;
  final String thumbnailUrl;
  final String videoUrl;

  @override
  List<Object?> get props => [
    id,
    name,
    muscleGroupLabel,
    category,
    mechanic,
    primaryMuscles,
    secondaryMuscles,
    equipment,
    instructions,
    tips,
    difficulty,
    measurement,
    icon,
    thumbnailUrl,
    videoUrl,
  ];
}
