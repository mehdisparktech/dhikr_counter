import 'package:dhikr_counter/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Responsive dimension helpers derived from screen width.
class Responsive {
  Responsive._();

  /// Clamp-based scaling: returns [base] on a 375-wide phone,
  /// scales down to ×0.85 at 320 and up to ×1.25 at 700+.
  static double scale(BuildContext context, double base) {
    final w = MediaQuery.sizeOf(context).width;
    final factor = (w / 375).clamp(0.85, 1.25);
    return base * factor;
  }

  /// Max circle diameter that still leaves horizontal padding.
  static double circleSize(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final maxByWidth = size.width * 0.72;
    final maxByHeight = size.height * 0.40;
    return maxByWidth.clamp(200.0, maxByHeight.clamp(200.0, 340.0));
  }

  /// Horizontal padding that grows on wider screens.
  static double horizontalPadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w > 600) return 48;
    if (w > 400) return 28;
    return 20;
  }
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle globalCount(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: Responsive.scale(context, 42),
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 1.0,
      );

  static TextStyle labelSmall(BuildContext context) => GoogleFonts.rajdhani(
        fontSize: Responsive.scale(context, 11),
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 3.0,
      );

  static TextStyle transliteration(BuildContext context) =>
      GoogleFonts.rajdhani(
        fontSize: Responsive.scale(context, 20),
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 4.0,
      );

  static TextStyle translation(BuildContext context) => GoogleFonts.rajdhani(
        fontSize: Responsive.scale(context, 11),
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        letterSpacing: 3.0,
      );

  static TextStyle counter(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: Responsive.scale(context, 32),
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle tapToRecite(BuildContext context) => GoogleFonts.rajdhani(
        fontSize: Responsive.scale(context, 13),
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
        letterSpacing: 4.0,
      );

  static TextStyle goalLabel(BuildContext context) => GoogleFonts.rajdhani(
        fontSize: Responsive.scale(context, 11),
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        letterSpacing: 2.5,
      );

  static TextStyle goalCount(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: Responsive.scale(context, 18),
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle complete(BuildContext context) => GoogleFonts.rajdhani(
        fontSize: Responsive.scale(context, 14),
        fontWeight: FontWeight.w700,
        color: AppColors.gold,
        letterSpacing: 2.0,
      );

  static TextStyle appBarTitle(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: Responsive.scale(context, 22),
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle appBarSubtitle(BuildContext context) =>
      GoogleFonts.rajdhani(
        fontSize: Responsive.scale(context, 11),
        fontWeight: FontWeight.w600,
        color: AppColors.gold,
        letterSpacing: 3.5,
      );

  static TextStyle arabic(BuildContext context, double circleSize) =>
      TextStyle(
        fontFamily: 'Amiri',
        fontSize: circleSize * 0.18,
        color: AppColors.gold,
        height: 1.5,
      );

  static TextStyle voiceToggle({required bool active}) => TextStyle(
        color: active ? AppColors.gold : AppColors.textSecondary,
        fontSize: 12,
        letterSpacing: 2.5,
        fontWeight: FontWeight.w600,
      );
}

ThemeData buildAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.gold,
      surface: AppColors.surface,
    ),
  );
}
