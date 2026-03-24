import 'package:dhikr_counter/core/constants/app_colors.dart';
import 'package:dhikr_counter/core/constants/app_strings.dart';
import 'package:dhikr_counter/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/dhikr_provider.dart';

/// Header section that shows a simulated "live" total recitation counter.
class GlobalLiveCount extends ConsumerWidget {
  const GlobalLiveCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatted = ref.watch(globalCountFormattedProvider);

    return Column(
      children: [
        // "GLOBAL LIVE COUNT" badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.circleBorder),
            color: AppColors.cardBg,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _PulsingDot(),
              const SizedBox(width: 6),
              Text(
                AppStrings.globalLiveCount,
                style: AppTextStyles.labelSmall(context).copyWith(
                  color: AppColors.gold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Responsive.scale(context, 16)),

        // Animated number
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, anim) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(anim),
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: Text(
            formatted,
            key: ValueKey(formatted),
            style: AppTextStyles.globalCount(context),
          ),
        ),
        const SizedBox(height: 4),

        Text(
          AppStrings.totalRecitationsToday,
          style: AppTextStyles.labelSmall(context).copyWith(
            color: AppColors.gold,
          ),
        ),
      ],
    );
  }
}

/// Tiny animated status indicator used beside the live-count label.
class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.liveGreen.withAlpha(
            (102 + _ctrl.value * 153).round(),
          ),
        ),
      ),
    );
  }
}
