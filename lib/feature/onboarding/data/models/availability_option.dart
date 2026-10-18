class AvailabilityOption {
  const AvailabilityOption({
    required this.id,
    required this.label,
    required this.daysPerWeek,
  });

  factory AvailabilityOption.fromJson(Map<String, dynamic> json) {
    return AvailabilityOption(
      id: json['id'] as String,
      label: json['label'] as String,
      daysPerWeek: json['daysPerWeek'] as int,
    );
  }

  final String id;
  final String label;
  final int daysPerWeek;
}
