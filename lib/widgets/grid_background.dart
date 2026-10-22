import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio/res/app_colors.dart';

/// Blueprint grid with slow-drifting signal pulses travelling along the lines.
class GridBackground extends StatefulWidget {
  const GridBackground({super.key});

  @override
  State<GridBackground> createState() => _GridBackgroundState();
}

class _GridBackgroundState extends State<GridBackground>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          painter: _GridPainter(_controller.value),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final double t;
  _GridPainter(this.t);

  static const _cell = 48.0;

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = AppColors.border.withValues(alpha: 0.55)
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += _cell) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (double y = 0; y <= size.height; y += _cell) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }

    // Signal pulses: a few deterministic lanes so the motion feels designed.
    final cols = (size.width / _cell).floor();
    final rows = (size.height / _cell).floor();
    if (cols < 2 || rows < 2) return;

    const lanes = 7;
    for (var i = 0; i < lanes; i++) {
      final horizontal = i.isEven;
      final phase = (t + i / lanes) % 1.0;
      final color = i % 3 == 0 ? AppColors.cyan : AppColors.primary;
      final pulse = Paint()
        ..shader = null
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round;

      if (horizontal) {
        final y = ((i * 7 + 3) % rows) * _cell;
        final head = phase * (size.width + 240) - 120;
        pulse.shader = LinearGradient(
          colors: [color.withValues(alpha: 0), color.withValues(alpha: 0.8)],
        ).createShader(Rect.fromLTWH(head - 120, y - 1, 120, 2));
        canvas.drawLine(Offset(head - 120, y), Offset(head, y), pulse);
      } else {
        final x = ((i * 5 + 2) % cols) * _cell;
        final head = phase * (size.height + 240) - 120;
        pulse.shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0), color.withValues(alpha: 0.8)],
        ).createShader(Rect.fromLTWH(x - 1, head - 120, 2, 120));
        canvas.drawLine(Offset(x, head - 120), Offset(x, head), pulse);
      }
    }

    // Soft vignette glow in the top-left to give depth.
    final glow = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.10),
              AppColors.primary.withValues(alpha: 0),
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.18, size.height * 0.25),
              radius: math.max(size.width, size.height) * 0.5,
            ),
          );
    canvas.drawRect(Offset.zero & size, glow);

    // Fade the grid into the page background at the bottom.
    final fade = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.55, 1],
        colors: [AppColors.bg.withValues(alpha: 0), AppColors.bg],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, fade);
  }

  @override
  bool shouldRepaint(_GridPainter old) => old.t != t;
}
