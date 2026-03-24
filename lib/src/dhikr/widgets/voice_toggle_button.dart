import 'package:dhikr_counter/core/constants/app_colors.dart';
import 'package:dhikr_counter/core/constants/app_strings.dart';
import 'package:dhikr_counter/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Toggle chip that switches between tap mode and voice mode state.
class VoiceToggleButton extends StatelessWidget {
  final bool isVoiceMode;
  final VoidCallback onToggle;

  const VoiceToggleButton({
    super.key,
    required this.isVoiceMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isVoiceMode ? AppColors.gold : AppColors.circleBorder,
          ),
          color:
              isVoiceMode ? AppColors.gold.withAlpha(20) : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isVoiceMode ? Icons.mic : Icons.swap_horiz,
              color: isVoiceMode ? AppColors.gold : AppColors.textSecondary,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              isVoiceMode ? AppStrings.changeToTap : AppStrings.changeToVoice,
              style: AppTextStyles.voiceToggle(active: isVoiceMode),
            ),
          ],
        ),
      ),
    );
  }
}
