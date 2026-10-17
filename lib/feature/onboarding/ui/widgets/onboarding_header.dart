import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import 'language_dropdown.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key,});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.headerBackground,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('FitFlow', style: AppStyles.font20Bold),
          const LanguageDropdown(),
        ],
      ),
    );
  }
}
