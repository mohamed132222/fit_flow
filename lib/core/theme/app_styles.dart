import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  AppStyles._();

  static TextStyle font48Bold = GoogleFonts.lexend(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: -1.2,
    height: 1,
  );

  static TextStyle font14Light = GoogleFonts.lexend(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.white60,
    letterSpacing: 2.8,
    height: 20 / 14,
  );
}
