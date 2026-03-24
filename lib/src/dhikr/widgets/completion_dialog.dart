import 'package:dhikr_counter/core/constants/app_colors.dart';
import 'package:dhikr_counter/core/constants/app_strings.dart';
import 'package:dhikr_counter/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Modal shown when a dhikr reaches its session goal.
class CompletionDialog extends StatelessWidget {
  final String dhikrName;
  final VoidCallback onNext;
  final VoidCallback onReset;

  const CompletionDialog({
    super.key,
    required this.dhikrName,
    required this.onNext,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.scale(context, 28);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(pad),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.goldDim, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withAlpha(38),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.completionEmoji,
              style: TextStyle(fontSize: Responsive.scale(context, 40)),
            ).animate().scale(
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1),
                  duration: 400.ms,
                  curve: Curves.elasticOut,
                ),
            const SizedBox(height: 12),
            Text(
              AppStrings.mashallah,
              style: TextStyle(
                fontFamily: AppStrings.fontFamilyArabic,
                fontSize: Responsive.scale(context, 26),
                color: AppColors.gold,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
            const SizedBox(height: 8),
            Text(
              AppStrings.youCompleted(dhikrName),
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: Responsive.scale(context, 13),
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 350.ms, duration: 300.ms),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReset,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.textMuted),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      AppStrings.again,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        letterSpacing: 2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      AppStrings.next,
                      style: TextStyle(
                        color: AppColors.textOnGold,
                        letterSpacing: 2,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 500.ms, duration: 300.ms),
          ],
        ),
      ).animate().scale(
            begin: const Offset(0.85, 0.85),
            end: const Offset(1, 1),
            duration: 300.ms,
            curve: Curves.easeOut,
          ),
    );
  }
}
