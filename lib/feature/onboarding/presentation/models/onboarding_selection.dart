import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class OnboardingSelection extends Equatable {
  OnboardingSelection({required this.goalId, required this.availabilityId});

  String goalId;
  String availabilityId;

  OnboardingSelection copyWith({String? goalId, String? availabilityId}) {
    return OnboardingSelection(
      goalId: goalId ?? this.goalId,
      availabilityId: availabilityId ?? this.availabilityId,
    );
  }

  @override
  List<Object?> get props => [goalId, availabilityId];
}
