import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:portfolio/res/app_text.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:portfolio/widgets/common.dart';

class DbuSection extends StatelessWidget {
  const DbuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stacked = Responsive.isTablet(context);

    return ContentFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '01',
            kicker: 'flagship_build',
            title: 'Digital Banking Unit',
            subtitle: 'Onsite with Hitachi Payments, I architected and built every module of India\'s pioneering Android-based Digital Banking Unit — a full bank branch in a kiosk, with an AI agent that runs entirely on the device.',
          ),
          const SizedBox(height: 28),
          const Reveal(child: _Badges()),
          const SizedBox(height: 40),
          if (stacked) ...[
            const Reveal(child: _Architecture()),
            const SizedBox(height: 20),
            const Reveal(child: _AgentPanel()),
            const SizedBox(height: 20),
            const Reveal(child: _HardwarePanel()),
          ] else
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 13, child: Reveal(child: _Architecture())),
                SizedBox(width: 20),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Reveal(
                        delay: Duration(milliseconds: 120),
                        child: _AgentPanel(),
                      ),
                      SizedBox(height: 20),
                      Reveal(
                        delay: Duration(milliseconds: 220),
                        child: _HardwarePanel(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(height: 56),
          Reveal(
            child: Row(
              children: [
                const PulseDot(color: AppColors.pink),
                const SizedBox(width: 6),
                Text('in_the_wild', style: AppText.mono(color: AppColors.text)),
                const SizedBox(width: 12),
                if (!Responsive.isMobile(context))
                  Flexible(
                    child: Text(
                      '— launches & press from Axis Bank, slice and Hitachi',
                      style: AppText.mono(size: 12),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const _MediaGrid(),
        ],
      ),
    );
  }
}

class _Badges extends StatelessWidget {
  const _Badges();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [for (final b in dbuBadges) _badge(b)],
    );
  }

  Widget _badge(DbuBadge b) {
    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: b.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (b.label == 'LIVE')
            PulseDot(color: b.color, size: 6)
          else
            Icon(Icons.emoji_events_outlined, size: 14, color: b.color),
          const SizedBox(width: 6),
          Text(
            b.label,
            style: AppText.mono(
              size: 12,
              color: b.color,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              b.detail,
              style: AppText.mono(size: 12, color: AppColors.text),
            ),
          ),
          if (b.url != null)
            Text('  ↗', style: AppText.mono(size: 12, color: b.color)),
        ],
      ),
    );
    if (b.url == null) return chip;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: () => openUrl(b.url!), child: chip),
    );
  }
}

// ─────────────────────── Architecture ───────────────────────

class _Architecture extends StatelessWidget {
  const _Architecture();

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    return _Panel(
      title: 'system_architecture',
      trailing: 'dbu/v2',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < dbuArchitecture.length; i++) ...[
            _LayerRow(layer: dbuArchitecture[i], mobile: mobile),
            _DataBus(
              from: dbuArchitecture[i].color,
              to: i + 1 < dbuArchitecture.length
                  ? dbuArchitecture[i + 1].color
                  : AppColors.amber,
            ),
          ],
          _HardwareLayer(mobile: mobile),
        ],
      ),
    );
  }
}

class _LayerLabel extends StatelessWidget {
  final String tag;
  final String name;
  final Color color;
  const _LayerLabel(this.tag, this.name, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tag,
            style: AppText.mono(
              size: 11,
              color: color,
              weight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            name,
            style: AppText.mono(size: 12, color: AppColors.textMuted),
          ),
        ),
      ],
    );
  }
}

class _LayerRow extends StatelessWidget {
  final ArchLayer layer;
  final bool mobile;
  const _LayerRow({required this.layer, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LayerLabel(layer.tag, layer.name, layer.color),
        const SizedBox(height: 10),
        if (mobile)
          // Compact on phones: titles only, the detail lives on desktop.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final n in layer.nodes)
                _NodeChip(node: n, color: layer.color),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < layer.nodes.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(
                  child: _NodeBox(node: layer.nodes[i], color: layer.color),
                ),
              ],
            ],
          ),
      ],
    );
  }
}

class _NodeChip extends StatelessWidget {
  final ArchNode node;
  final Color color;
  const _NodeChip({required this.node, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        node.title,
        style: AppText.body(
          size: 13.5,
          color: AppColors.text,
          weight: FontWeight.w600,
          height: 1.3,
        ),
      ),
    );
  }
}

class _NodeBox extends StatefulWidget {
  final ArchNode node;
  final Color color;
  const _NodeBox({required this.node, required this.color});

  @override
  State<_NodeBox> createState() => _NodeBoxState();
}

class _NodeBoxState extends State<_NodeBox> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.color;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        constraints: const BoxConstraints(minHeight: 84),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: c.withValues(alpha: _hover ? 0.12 : 0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: c.withValues(alpha: _hover ? 0.7 : 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.node.title,
              style: AppText.body(
                size: 15,
                color: AppColors.text,
                weight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.node.subtitle,
              style: AppText.mono(size: 11, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _HardwareLayer extends StatelessWidget {
  final bool mobile;
  const _HardwareLayer({required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LayerLabel('L1', 'hardware · 9 device classes', AppColors.amber),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final d in dbuDevices)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: AppColors.amber.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.amber.withValues(alpha: 0.28),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.memory_rounded,
                      size: 13,
                      color: AppColors.amber,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        d,
                        style: AppText.mono(size: 11.5, color: AppColors.text),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Short vertical bus between layers with packets flowing down and up.
class _DataBus extends StatefulWidget {
  final Color from;
  final Color to;
  const _DataBus({required this.from, required this.to});

  @override
  State<_DataBus> createState() => _DataBusState();
}

class _DataBusState extends State<_DataBus>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          painter: _BusPainter(_controller.value, widget.from, widget.to),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _BusPainter extends CustomPainter {
  final double t;
  final Color from;
  final Color to;
  _BusPainter(this.t, this.from, this.to);

  @override
  void paint(Canvas canvas, Size size) {
    const lanes = [0.2, 0.5, 0.8];
    for (var i = 0; i < lanes.length; i++) {
      final x = size.width * lanes[i];
      final line = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [from.withValues(alpha: 0.35), to.withValues(alpha: 0.35)],
        ).createShader(Rect.fromLTWH(x, 0, 1, size.height))
        ..strokeWidth = 1;

      // Dashed line.
      for (double y = 0; y < size.height; y += 6) {
        canvas.drawLine(Offset(x, y), Offset(x, y + 3), line);
      }

      // Middle lane flows upward (responses), outer lanes flow down (commands).
      final up = i == 1;
      final phase = (t + i * 0.33) % 1.0;
      final y = (up ? 1 - phase : phase) * size.height;
      final color = Color.lerp(from, to, y / size.height)!;
      canvas.drawCircle(
        Offset(x, y),
        5,
        Paint()..color = color.withValues(alpha: 0.25),
      );
      canvas.drawCircle(Offset(x, y), 2.2, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(_BusPainter old) => old.t != t;
}

// ──────────────────────── Side panels ────────────────────────

class _Panel extends StatelessWidget {
  final String title;
  final String? trailing;
  final Widget child;
  final Color accent;
  const _Panel({
    required this.title,
    required this.child,
    this.trailing,
    this.accent = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Text('▸ ', style: AppText.mono(size: 12, color: accent)),
                Expanded(
                  child: Text(
                    title,
                    style: AppText.mono(size: 12, color: AppColors.text),
                  ),
                ),
                if (trailing != null)
                  Text(
                    trailing!,
                    style: AppText.mono(size: 11, color: AppColors.textDim),
                  ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(mobile ? 16 : 22), child: child),
        ],
      ),
    );
  }
}

class _AgentPanel extends StatelessWidget {
  const _AgentPanel();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'on_device_ai_agent',
      trailing: 'offline',
      accent: AppColors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Speak or type in English or Hindi. Whisper transcribes locally, Gemma 2B plans the journey, and an Accessibility Service taps through the real app to finish it.',
            style: AppText.body(size: 14.5),
          ),
          const SizedBox(height: 18),
          _Pipeline(),
          const SizedBox(height: 18),
          Text(
            'journeys completed by voice',
            style: AppText.mono(size: 11, color: AppColors.textDim),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final j in dbuAgentJourneys)
                TagChip(j, color: AppColors.pink),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pipeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const steps = ['voice', 'whisper', 'gemma-2b', 'a11y', 'done'];
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 6,
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: i == steps.length - 1
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : AppColors.surfaceHigh,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: i == steps.length - 1
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : AppColors.borderBright,
              ),
            ),
            child: Text(
              steps[i],
              style: AppText.mono(
                size: 11,
                color: i == steps.length - 1
                    ? AppColors.primary
                    : AppColors.text,
              ),
            ),
          ),
          if (i < steps.length - 1)
            Text('→', style: AppText.mono(size: 12, color: AppColors.textDim)),
        ],
      ],
    );
  }
}

class _HardwarePanel extends StatelessWidget {
  const _HardwarePanel();

  @override
  Widget build(BuildContext context) {
    Widget fact(String value, String label) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppText.display(size: 26, color: AppColors.amber)),
        const SizedBox(height: 2),
        Text(label, style: AppText.mono(size: 11)),
      ],
    );

    return _Panel(
      title: 'hardware_r_and_d',
      trailing: 'first-of-its-kind',
      accent: AppColors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Banking peripherals had no Android support. I wrote the SDKs — including the first Android SDK for Reiner (Germany) cheque scanners — and a device service layer on AIDL.',
            style: AppText.body(size: 14.5),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: fact('9', 'AIDL device services')),
              Expanded(child: fact('4', 'transports: USB · serial · BT · JNI')),
            ],
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Media ─────────────────────────

class _MediaGrid extends StatelessWidget {
  const _MediaGrid();

  @override
  Widget build(BuildContext context) {
    final cols = Responsive.isMobile(context) ? 1 : 2;
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 12.0;
        final itemWidth = (constraints.maxWidth - gap * (cols - 1)) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var i = 0; i < dbuMedia.length; i++)
              SizedBox(
                width: itemWidth,
                child: Reveal(
                  delay: Duration(milliseconds: 60 * i),
                  child: _MediaCard(item: dbuMedia[i]),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Compact press row: coloured icon tile, source, headline and a CTA.
class _MediaCard extends StatelessWidget {
  final MediaItem item;
  const _MediaCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final (icon, kind) = switch (item.kind) {
      MediaKind.video => (Icons.play_arrow_rounded, 'video'),
      MediaKind.post => (Icons.article_outlined, 'post'),
      MediaKind.web => (Icons.language_rounded, 'site'),
    };

    return GlowCard(
      accent: item.color,
      padding: EdgeInsets.all(mobile ? 14 : 16),
      onTap: () => openUrl(item.url),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: mobile ? 44 : 52,
            height: mobile ? 44 : 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  item.color.withValues(alpha: 0.35),
                  item.color.withValues(alpha: 0.08),
                ],
              ),
              border: Border.all(color: item.color.withValues(alpha: 0.5)),
            ),
            child: Icon(icon, color: item.color, size: mobile ? 22 : 26),
          ),
          SizedBox(width: mobile ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: item.source,
                        style: AppText.mono(size: 11, color: item.color),
                      ),
                      TextSpan(
                        text: '  ·  $kind',
                        style: AppText.mono(size: 11, color: AppColors.textDim),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: AppText.body(
                    size: mobile ? 14.5 : 15.5,
                    color: AppColors.text,
                    weight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
                if (!mobile) ...[
                  const SizedBox(height: 4),
                  Text(
                    item.caption,
                    style: AppText.body(size: 13.5, height: 1.5),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.north_east_rounded, size: 16, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
