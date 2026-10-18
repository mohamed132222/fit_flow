import 'package:equatable/equatable.dart';

class PlanBanner extends Equatable {
  const PlanBanner({
    required this.isRecommended,
    required this.badge,
    required this.caption,
    required this.imageKey,
    required this.imageUrl,
  });

  factory PlanBanner.fromJson(Map<String, dynamic> json) {
    return PlanBanner(
      isRecommended: json['isRecommended'] as bool,
      badge: json['badge'] as String,
      caption: json['caption'] as String,
      imageKey: json['imageKey'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  final bool isRecommended;
  final String badge;
  final String caption;
  final String imageKey;
  final String imageUrl;

  @override
  List<Object?> get props => [
    isRecommended,
    badge,
    caption,
    imageKey,
    imageUrl,
  ];
}
