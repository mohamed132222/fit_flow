import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  static const List<String> languages = ['English', 'Arabic'];

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _language = LanguageDropdown.languages.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _language,
      underline: const SizedBox.shrink(),
      borderRadius: BorderRadius.circular(12),
      style: AppStyles.font13SemiBoldMuted,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 20,
        color: AppColors.muted,
      ),
      items: [
        for (final language in LanguageDropdown.languages)
          DropdownMenuItem(value: language, child: Text(language)),
      ],
      onChanged: (value) {
        if (value == null) return;
        setState(() => _language = value);
      },
    );
  }
}
