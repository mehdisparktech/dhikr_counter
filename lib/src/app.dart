// lib/app.dart

import 'package:dhikr_counter/core/constants/app_strings.dart';
import 'package:dhikr_counter/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'dhikr/screens/dhikr_screen.dart';

/// Root application widget responsible for global app configuration.
class DhikrApp extends StatelessWidget {
  const DhikrApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Keep routing simple for now: one feature screen as home.
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const DhikrScreen(),
    );
  }
}
