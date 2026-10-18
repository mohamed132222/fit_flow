import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/goals_config.dart';
import '../../../domain/repositories/onboarding_repository.dart';
import 'get_goals_config_state.dart';

class GetGoalsConfigCubit extends Cubit<GetGoalsConfigState> {
  GetGoalsConfigCubit(this._repository, GoalsConfig initialConfig)
    : super(GetGoalsConfigSuccess(initialConfig));

  final OnboardingRepository _repository;

  Future<void> fetch() async {
    emit(const GetGoalsConfigLoading());
    final result = await _repository.getGoalsConfig();
    if (isClosed) return;
    result.fold(
      (failure) => emit(GetGoalsConfigFailure(failure)),
      (config) => emit(GetGoalsConfigSuccess(config)),
    );
  }
}
