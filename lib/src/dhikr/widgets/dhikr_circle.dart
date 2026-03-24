import 'package:dhikr_counter/core/constants/app_colors.dart';
import 'package:dhikr_counter/core/theme/app_theme.dart';
import 'package:dhikr_counter/src/dhikr/providers/dhikr_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'circular_progress_painter.dart';

/// Interactive center circle that handles tap animation and recitation content.
class DhikrCircle extends StatefulWidget {
  final DhikrState dhikrState;
  final VoidCallback onTap;

  const DhikrCircle({
    super.key,
    required this.dhikrState,
    required this.onTap,
  });

  @override
  State<DhikrCircle> createState() => _DhikrCircleState();
}

class _DhikrCircleState extends State<DhikrCircle>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _tapController;
  late Animation<double> _tapScale;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _tapScale = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _tapController.dispose();
    super.dispose();
  }

  void _handleTap() async {
    // Haptic + press animation keep taps tactile and responsive.
    HapticFeedback.mediumImpact();
    await _tapController.forward();
    await _tapController.reverse();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final circleSize = Responsive.circleSize(context);

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _tapScale,
        builder: (context, child) =>
            Transform.scale(scale: _tapScale.value, child: child),
        child: SizedBox(
          width: circleSize,
          height: circleSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow
              Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withAlpha(31),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),

              // Arc progress painter
              AnimatedBuilder(
                animation: _pulseController,
                builder: (_, __) => CustomPaint(
                  size: Size(circleSize, circleSize),
                  painter: CircularProgressPainter(
                    progress: widget.dhikrState.progressPercent,
                    animation: _pulseController,
                  ),
                ),
              ),

              // Inner dark circle
              Container(
                width: circleSize - 16,
                height: circleSize - 16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.surfaceElevated,
                      AppColors.innerCircleDeep,
                    ],
                  ),
                ),
              ),

              // Text content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: circleSize * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Arabic calligraphy — animated cross-fade on dhikr change
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: child,
                      ),
                      child: Text(
                        widget.dhikrState.dhikr.arabicText,
                        key: ValueKey(widget.dhikrState.dhikr.arabicText),
                        textDirection: TextDirection.rtl,
                        style: AppTextStyles.arabic(context, circleSize),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: circleSize * 0.03),

                    // Transliteration
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        widget.dhikrState.dhikr.transliteration,
                        key: ValueKey(widget.dhikrState.dhikr.transliteration),
                        style: AppTextStyles.transliteration(context),
                      ),
                    ),
                    SizedBox(height: circleSize * 0.01),

                    // Translation
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        widget.dhikrState.dhikr.translation,
                        key: ValueKey(widget.dhikrState.dhikr.translation),
                        style: AppTextStyles.translation(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: circleSize * 0.03),

                    // Counter number
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, anim) => ScaleTransition(
                        scale: anim,
                        child: FadeTransition(opacity: anim, child: child),
                      ),
                      child: Text(
                        '${widget.dhikrState.currentCount}',
                        key: ValueKey(widget.dhikrState.currentCount),
                        style: AppTextStyles.counter(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
