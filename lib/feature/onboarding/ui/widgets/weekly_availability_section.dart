import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_styles.dart';
import '../../../../i18n/strings.g.dart';
import '../../presentation/cubits/get_goals_config/get_goals_config_cubit.dart';
import '../../presentation/cubits/get_goals_config/get_goals_config_state.dart';
import 'availability_options_list.dart';
import 'availability_options_skeleton.dart';
import 'onboarding_error_view.dart';

class WeeklyAvailabilitySection extends StatelessWidget {
  const WeeklyAvailabilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.onboarding.weeklyAvailability, style: AppStyles.font18Bold),
        const SizedBox(height: 16),
        BlocBuilder<GetGoalsConfigCubit, GetGoalsConfigState>(
          builder: (context, state) => switch (state) {
            GetGoalsConfigInitial() ||
            GetGoalsConfigLoading() => const AvailabilityOptionsSkeleton(),
            GetGoalsConfigFailure(:final failure) => OnboardingErrorView(
              message: failure.message,
              onRetry: () => context.read<GetGoalsConfigCubit>().fetch(),
            ),
            GetGoalsConfigSuccess(:final config) => AvailabilityOptionsList(
              options: config.availabilityOptions,
            ),
          },
        ),
      ],
    );
  }
}
