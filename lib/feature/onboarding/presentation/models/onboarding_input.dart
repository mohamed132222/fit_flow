import 'package:equatable/equatable.dart';

class OnboardingInput extends Equatable {
  const OnboardingInput({
    required this.goalId,
    required this.availabilityId,
  });

  final String goalId;
  final String availabilityId;

  @override
  List<Object?> get props => [goalId, availabilityId];
}