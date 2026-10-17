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

  static TextStyle font34ExtraBold = GoogleFonts.plusJakartaSans(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.85,
    height: 1.25,
  );

  static TextStyle font20Bold = GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle font18Bold = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.45,
  );

  static TextStyle font16Bold = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle font15Regular = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle font13Regular = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle font13BoldWhite = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle font13SemiBoldMuted = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.muted,
  );

  static TextStyle font17Bold = GoogleFonts.plusJakartaSans(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle font11MediumHint = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.hint,
  );

  static TextStyle font10BoldMuted = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.muted,
    letterSpacing: 1,
  );

  static TextStyle font10BoldPrimary = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: 1,
  );
}
