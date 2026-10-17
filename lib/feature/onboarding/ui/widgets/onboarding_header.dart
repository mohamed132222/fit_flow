import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key, required this.onHelpPressed});

  final VoidCallback onHelpPressed;

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
      
          SizedBox(
            width: 40,
            height: 40,
            child: IconButton(
              onPressed: onHelpPressed,
              iconSize: 22,
              padding: EdgeInsets.zero,
              color: AppColors.muted,
              icon: const Icon(Icons.help_outline_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
