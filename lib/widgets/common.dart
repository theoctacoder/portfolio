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

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..color = AppColors.primary;

    final b = Path()
      ..moveTo(15, 18)
      ..lineTo(15, 46)
      ..lineTo(26.5, 46)
      ..arcToPoint(
        const Offset(26.5, 32),
        radius: const Radius.circular(7),
        clockwise: false,
      )
      ..lineTo(15, 32)
      ..moveTo(15, 32)
      ..lineTo(25.5, 32)
      ..arcToPoint(
        const Offset(25.5, 18),
        radius: const Radius.circular(7),
        clockwise: false,
      )
      ..lineTo(15, 18);
    final a = Path()
      ..moveTo(37, 46)
      ..lineTo(44, 18)
      ..lineTo(51, 46)
      ..moveTo(40.2, 36.5)
      ..lineTo(47.8, 36.5);
    canvas.drawPath(b, stroke);
    canvas.drawPath(a, stroke);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(13, 51, 11, 3.5),
        const Radius.circular(1.2),
      ),
      Paint()..color = AppColors.cyan,
    );
  }

  @override
  bool shouldRepaint(_LogoPainter old) => false;
}
