import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_language.dart';
import '../../../../core/localization/language_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.watch<LanguageCubit>().state;

    return DropdownButton<AppLanguage>(
      value: language,
      underline: const SizedBox.shrink(),
      borderRadius: BorderRadius.circular(12),
      style: AppStyles.font13SemiBoldMuted,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 20,
        color: AppColors.muted,
      ),
      items: [
        for (final language in AppLanguage.values)
          DropdownMenuItem(
            value: language,
            child: Text(language.nativeName),
          ),
      ],
      onChanged: (value) {
        if (value == null) return;
        context.read<LanguageCubit>().changeLanguage(value);
      },
    );
  }
}
