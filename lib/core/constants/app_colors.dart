import 'package:flutter/material.dart';

/// Central palette for the Dhikr Counter UI.
class AppColors {
  AppColors._();

  static const background = Color(0xFF0A0A0A);
  static const surface = Color(0xFF141414);
  static const cardBg = Color(0xFF1A1A1A);
  static const surfaceElevated = Color(0xFF1E1E1E);
  static const innerCircleDeep = Color(0xFF0D0D0D);

  static const gold = Color(0xFFD4AF37);
  static const goldLight = Color(0xFFEDD47A);
  static const goldDim = Color(0xFF8B7325);
  /// Transparent gold for sweep gradient start (ARGB).
  static const goldSweepStart = Color(0x008B7325);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF888888);
  static const textMuted = Color(0xFF555555);
  static const textOnGold = Color(0xFF000000);

  static const liveGreen = Color(0xFF4CAF50);
  static const circleBorder = Color(0xFF2A2A2A);
  static const circleGlow = Color(0xFFD4AF37);

  /// ~75% black overlay for modal barriers.
  static const barrierScrim = Color(0xBF000000);
}
