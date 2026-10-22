import 'package:flutter/material.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:portfolio/res/app_text.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fades and slides its child in the first time it scrolls into view.
class Reveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const Reveal({super.key, required this.child, this.delay = Duration.zero});

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  final _key = UniqueKey();
  bool _visible = false;

  void _onVisibility(VisibilityInfo info) {
    if (_visible || info.visibleFraction < 0.08) return;
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: _onVisibility,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _visible ? Offset.zero : const Offset(0, 0.06),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Centers content and caps it at [Responsive.maxContentWidth].
class ContentFrame extends StatelessWidget {
  final Widget child;
  const ContentFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.gutter(context)),
          child: child,
        ),
      ),
    );
  }
}

/// `01 // section_name` kicker plus a large title.
class SectionHeader extends StatelessWidget {
  final String index;
  final String kicker;
  final String title;
  final String? subtitle;
  const SectionHeader({
    super.key,
    required this.index,
    required this.kicker,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    return Reveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                index,
                style: AppText.mono(
                  color: AppColors.primary,
                  weight: FontWeight.w600,
                ),
              ),
              Text('  //  $kicker', style: AppText.mono()),
              const SizedBox(width: 16),
              Expanded(child: Container(height: 1, color: AppColors.border)),
            ],
          ),
          const SizedBox(height: 20),
          Text(title, style: AppText.display(size: mobile ? 34 : 52)),
          if (subtitle != null) ...[
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                subtitle!,
                style: AppText.body(size: mobile ? 15 : 17),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Bordered surface that lifts and glows in [accent] on hover.
class GlowCard extends StatefulWidget {
  final Widget child;
  final Color accent;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  const GlowCard({
    super.key,
    required this.child,
    this.accent = AppColors.primary,
    this.onTap,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: _hover ? AppColors.surfaceHigh : AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hover
                  ? widget.accent.withValues(alpha: 0.55)
                  : AppColors.border,
            ),
            boxShadow: [
              if (_hover)
                BoxShadow(
                  color: widget.accent.withValues(alpha: 0.12),
                  blurRadius: 32,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final String label;
  final Color color;
  const TagChip(this.label, {super.key, this.color = AppColors.textMuted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(label, style: AppText.mono(size: 12, color: color)),
    );
  }
}

/// Pulsing status dot used for "live" indicators.
class PulseDot extends StatefulWidget {
  final Color color;
  final double size;
  const PulseDot({super.key, this.color = AppColors.primary, this.size = 8});

  @override
  State<PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<PulseDot>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    return SizedBox(
      width: s * 2.5,
      height: s * 2.5,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _controller.value;
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: s + s * 1.5 * t,
                height: s + s * 1.5 * t,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: 0.35 * (1 - t)),
                ),
              ),
              Container(
                width: s,
                height: s,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Primary / outline button in the mono style.
class ConsoleButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;
  const ConsoleButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  State<ConsoleButton> createState() => _ConsoleButtonState();
}

class _ConsoleButtonState extends State<ConsoleButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final fg = widget.filled ? AppColors.bg : AppColors.text;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: widget.filled
                ? (_hover ? const Color(0xFF5BE89A) : AppColors.primary)
                : (_hover ? AppColors.surfaceHigh : Colors.transparent),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.filled
                  ? AppColors.primary
                  : (_hover ? AppColors.primary : AppColors.borderBright),
            ),
            boxShadow: [
              if (widget.filled && _hover)
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 24,
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 16, color: fg),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: AppText.mono(
                  size: 13,
                  color: fg,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The BA monogram (same geometry as web/favicon.svg), drawn on a 64×64 grid.
class LogoMark extends StatelessWidget {
  final double size;
  const LogoMark({super.key, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.square(size), painter: _LogoPainter());
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 64);

    final frame = RRect.fromRectAndRadius(
      const Rect.fromLTWH(1, 1, 62, 62),
      const Radius.circular(15),
    );
    canvas.drawRRect(frame, Paint()..color = AppColors.surface);
    canvas.drawRRect(
      frame,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = AppColors.primary.withValues(alpha: 0.55),
    );

    // "BA" outlined from JetBrains Mono ExtraBold (same as web/favicon.svg).
    final glyph = Path()
      ..moveTo(13.77, 42)
      ..lineTo(13.77, 18)
      ..lineTo(21.5, 18)
      ..quadraticBezierTo(23.9, 18, 25.69, 18.77)
      ..quadraticBezierTo(27.48, 19.55, 28.48, 20.93)
      ..quadraticBezierTo(29.48, 22.31, 29.48, 24.18)
      ..quadraticBezierTo(29.48, 26.22, 28.37, 27.58)
      ..quadraticBezierTo(27.25, 28.95, 25.47, 29.21)
      ..lineTo(25.47, 29.28)
      ..quadraticBezierTo(26.82, 29.41, 27.86, 30.21)
      ..quadraticBezierTo(28.89, 31.02, 29.47, 32.27)
      ..quadraticBezierTo(30.04, 33.52, 30.04, 35.06)
      ..quadraticBezierTo(30.04, 37.13, 29.01, 38.7)
      ..quadraticBezierTo(27.97, 40.26, 26.12, 41.13)
      ..quadraticBezierTo(24.26, 42, 21.79, 42)
      ..close()
      ..moveTo(18.54, 27.67)
      ..lineTo(21.43, 27.67)
      ..quadraticBezierTo(22.88, 27.67, 23.7, 26.89)
      ..quadraticBezierTo(24.52, 26.12, 24.52, 24.81)
      ..quadraticBezierTo(24.52, 23.46, 23.7, 22.72)
      ..quadraticBezierTo(22.88, 21.98, 21.43, 21.98)
      ..lineTo(18.54, 21.98)
      ..close()
      ..moveTo(18.54, 38.02)
      ..lineTo(21.63, 38.02)
      ..quadraticBezierTo(23.24, 38.02, 24.16, 37.17)
      ..quadraticBezierTo(25.08, 36.31, 25.08, 34.8)
      ..quadraticBezierTo(25.08, 33.29, 24.16, 32.42)
      ..quadraticBezierTo(23.24, 31.55, 21.63, 31.55)
      ..lineTo(18.54, 31.55)
      ..close()
      ..moveTo(32.15, 42)
      ..lineTo(38.03, 18)
      ..lineTo(44.28, 18)
      ..lineTo(50.23, 42)
      ..lineTo(45.2, 42)
      ..lineTo(44.05, 36.58)
      ..lineTo(38.33, 36.58)
      ..lineTo(37.18, 42)
      ..close()
      ..moveTo(39.15, 32.63)
      ..lineTo(43.19, 32.63)
      ..lineTo(42.04, 26.84)
      ..quadraticBezierTo(41.81, 25.59, 41.57, 24.36)
      ..quadraticBezierTo(41.32, 23.13, 41.19, 22.44)
      ..quadraticBezierTo(41.06, 23.13, 40.84, 24.35)
      ..quadraticBezierTo(40.63, 25.56, 40.37, 26.81)
      ..close();
    canvas.drawPath(glyph, Paint()..color = AppColors.primary);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(13.77, 47, 10, 3.2),
        const Radius.circular(1),
      ),
      Paint()..color = AppColors.cyan,
    );
  }

  @override
  bool shouldRepaint(_LogoPainter old) => false;
}
