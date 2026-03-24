import 'dart:math' as math;

import 'package:dhikr_counter/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Draws the circular track, progress arc, tip glow, and breathing pulse ring.
class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Animation<double> animation;

  CircularProgressPainter({
    required this.progress,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Background track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.circleBorder
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    if (progress > 0) {
      final sweepAngle = 2 * math.pi * progress;

      // Gold sweep arc
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        sweepAngle,
        false,
        Paint()
          ..shader = SweepGradient(
            colors: const [
              AppColors.goldSweepStart,
              AppColors.gold,
              AppColors.goldLight,
            ],
            stops: const [0.0, 0.7, 1.0],
            startAngle: -math.pi / 2,
            endAngle: -math.pi / 2 + sweepAngle,
          ).createShader(Rect.fromCircle(center: center, radius: radius))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..strokeCap = StrokeCap.round,
      );

      // Glowing dot at arc tip
      final angle = -math.pi / 2 + sweepAngle;
      final tipOffset = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawCircle(tipOffset, 4, Paint()..color = AppColors.goldLight);
    }

    // Animated breathing pulse ring
    final pulseAlpha = ((1 - animation.value) * 20).round();
    canvas.drawCircle(
      center,
      radius * (1 + animation.value * 0.04),
      Paint()
        ..color = AppColors.gold.withAlpha(pulseAlpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter old) => old.progress != progress;
}
