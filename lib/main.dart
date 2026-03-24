// lib/main.dart

import 'package:dhikr_counter/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';

/// App bootstrap:
/// - initializes Flutter bindings
/// - locks orientation to portrait
/// - applies system UI colors
/// - injects Riverpod scope
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Keep UX focused in portrait mode for one-handed dhikr interaction.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Match system chrome with the app's dark visual identity.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    const ProviderScope(
      child: DhikrApp(),
    ),
  );
}
