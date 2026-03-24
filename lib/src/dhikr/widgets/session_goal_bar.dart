import 'package:dhikr_counter/core/constants/app_colors.dart';
import 'package:dhikr_counter/core/constants/app_strings.dart';
import 'package:dhikr_counter/core/theme/app_theme.dart';
import 'package:dhikr_counter/src/dhikr/providers/dhikr_state.dart';
import 'package:flutter/material.dart';

/// Displays current session progress as text and animated linear indicator.
class SessionGoalBar extends StatelessWidget {
  final DhikrState dhikrState;

  const SessionGoalBar({super.key, required this.dhikrState});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.sessionGoal,
              style: AppTextStyles.goalLabel(context),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                AppStrings.sessionCompletePercent(
                    dhikrState.progressPercentInt),
                key: ValueKey(dhikrState.progressPercentInt),
                style: AppTextStyles.complete(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            '${dhikrState.currentCount} / ${dhikrState.dhikr.sessionGoal}',
            key: ValueKey(dhikrState.currentCount),
            style: AppTextStyles.goalCount(context),
          ),
        ),
        const SizedBox(height: 10),

        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: dhikrState.progressPercent),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            builder: (_, value, __) => LinearProgressIndicator(
              value: value,
              minHeight: 3,
              backgroundColor: AppColors.circleBorder,
              valueColor: AlwaysStoppedAnimation<Color>(
                dhikrState.isCompleted ? AppColors.goldLight : AppColors.gold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
