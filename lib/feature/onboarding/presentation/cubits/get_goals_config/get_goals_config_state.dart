import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/goals_config.dart';

sealed class GetGoalsConfigState extends Equatable {
  const GetGoalsConfigState();

  @override
  List<Object?> get props => [];
}

final class GetGoalsConfigInitial extends GetGoalsConfigState {
  const GetGoalsConfigInitial();
}

final class GetGoalsConfigLoading extends GetGoalsConfigState {
  const GetGoalsConfigLoading();
}

final class GetGoalsConfigSuccess extends GetGoalsConfigState {
  const GetGoalsConfigSuccess(this.config);

  final GoalsConfig config;

  @override
  List<Object?> get props => [config];
}

final class GetGoalsConfigFailure extends GetGoalsConfigState {
  const GetGoalsConfigFailure(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
