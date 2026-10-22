import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:portfolio/res/app_text.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:portfolio/widgets/common.dart';
import 'package:portfolio/widgets/grid_background.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onResume;
  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final stacked = Responsive.isTablet(context);
    final height = MediaQuery.sizeOf(context).height;

    final intro =
        Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const PulseDot(),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'mobile frontend lead · abstract layers · thane, IN',
                        style: AppText.mono(size: mobile ? 11 : 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: mobile ? 20 : 28),
                Text(
                  'Bhavesh\nAuodichya',
                  style: AppText.display(
                    size: mobile ? 52 : (stacked ? 72 : 92),
                  ),
                ),
                SizedBox(height: mobile ? 20 : 28),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text.rich(
                    TextSpan(
                      style: AppText.body(size: mobile ? 16 : 19),
                      children: [
                        const TextSpan(text: 'I build '),
                        TextSpan(
                          text: 'Android systems that talk to banking hardware',
                          style: AppText.body(
                            size: mobile ? 16 : 19,
                            color: AppColors.text,
                            weight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(text: ' — and '),
                        TextSpan(
                          text: 'AI that runs entirely on the device',
                          style: AppText.body(
                            size: mobile ? 16 : 19,
                            color: AppColors.text,
                            weight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(
                          text: '. Currently shipping India\'s Digital Banking Unit, live at Axis Bank and slice.',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: mobile ? 28 : 36),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ConsoleButton(
                      label: 'view_dbu_work',
                      icon: Icons.arrow_downward_rounded,
                      onTap: onViewWork,
                      filled: true,
                    ),
                    ConsoleButton(
                      label: 'resume.pdf',
                      icon: Icons.download_rounded,
                      onTap: onResume,
                    ),
                  ],
                ),
              ],
            )
            .animate()
            .fadeIn(duration: 700.ms)
            .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);

    final terminal = const _BootTerminal()
        .animate(delay: 250.ms)
        .fadeIn(duration: 700.ms)
        .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);

    return Stack(
      children: [
        const Positioned.fill(child: GridBackground()),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: mobile ? 0 : height * 0.92),
          child: ContentFrame(
            child: Padding(
              padding: EdgeInsets.only(
                top: mobile ? 110 : 150,
                bottom: mobile ? 48 : 72,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (stacked) ...[
                    intro,
                    const SizedBox(height: 40),
                    terminal,
                  ] else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 11, child: intro),
                        const SizedBox(width: 48),
                        Expanded(flex: 9, child: terminal),
                      ],
                    ),
                  SizedBox(height: mobile ? 40 : 72),
                  const _StatsStrip()
                      .animate(delay: 500.ms)
                      .fadeIn(duration: 700.ms),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatsStrip extends StatelessWidget {
  const _StatsStrip();

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final perRow = Responsive.isTablet(context) ? 2 : 4;
    final cells = [
      for (final s in heroStats)
        Padding(
          padding: EdgeInsets.all(mobile ? 16 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.value,
                style: AppText.display(
                  size: mobile ? 30 : 40,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(s.label, style: AppText.mono(size: 12, height: 1.4)),
            ],
          ),
        ),
    ];

    // Table sizes every row to its tallest cell, so wrapped labels never clip.
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.7),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Table(
        border: const TableBorder.symmetric(
          inside: BorderSide(color: AppColors.border),
        ),
        children: [
          for (var r = 0; r < cells.length; r += perRow)
            TableRow(children: cells.sublist(r, r + perRow)),
        ],
      ),
    );
  }
}

class _Line {
  final String text;
  final bool command;
  final Color color;
  const _Line(
    this.text, {
    this.command = false,
    this.color = AppColors.textMuted,
  });
}

const _script = [
  _Line('whoami', command: true),
  _Line('bhavesh — mobile frontend lead', color: AppColors.text),
  _Line('cat stack.txt', command: true),
  _Line(
    'kotlin · java · flutter · rust · gemma · whisper',
    color: AppColors.cyan,
  ),
  _Line('adb shell dumpsys dbu --status', command: true),
  _Line('● axis_bank   10+ sites   ONLINE', color: AppColors.primary),
  _Line('● slice        5+ sites   ONLINE', color: AppColors.primary),
  _Line('● ai_agent    gemma-2b   ON-DEVICE', color: AppColors.pink),
  _Line('● devices      9 / 9     BOUND', color: AppColors.violet),
];

/// Terminal window that types [_script] line by line, then idles with a cursor.
class _BootTerminal extends StatefulWidget {
  const _BootTerminal();

  @override
  State<_BootTerminal> createState() => _BootTerminalState();
}

class _BootTerminalState extends State<_BootTerminal> {
  Timer? _timer;
  int _line = 0;
  int _char = 0;
  bool _cursorOn = true;
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 28), _step);
  }

  void _step(Timer _) {
    setState(() {
      _tick++;
      if (_tick % 18 == 0) _cursorOn = !_cursorOn;
      if (_line >= _script.length) return;

      final current = _script[_line];
      if (!current.command) {
        // Output lines appear whole, after a short pause.
        if (_tick % 6 == 0) {
          _line++;
          _char = 0;
        }
        return;
      }
      if (_char < current.text.length) {
        _char++;
      } else if (_tick % 10 == 0) {
        _line++;
        _char = 0;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final size = mobile ? 11.5 : 13.0;
    final done = _line >= _script.length;

    final rows = <Widget>[];
    for (var i = 0; i <= _line && i < _script.length; i++) {
      final l = _script[i];
      final typing = i == _line;
      final text = typing && l.command ? l.text.substring(0, _char) : l.text;
      if (typing && !l.command) break;
      rows.add(
        Padding(
          padding: EdgeInsets.only(top: l.command && i > 0 ? 10 : 2),
          child: Text.rich(
            TextSpan(
              children: [
                if (l.command)
                  TextSpan(
                    text: '\$ ',
                    style: AppText.mono(size: size, color: AppColors.primary),
                  ),
                TextSpan(
                  text: text,
                  style: AppText.mono(
                    size: size,
                    color: l.command ? AppColors.text : l.color,
                    height: 1.5,
                  ),
                ),
                if (typing)
                  TextSpan(
                    text: _cursorOn ? '▋' : ' ',
                    style: AppText.mono(size: size, color: AppColors.primary),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    if (done) {
      rows.add(
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '\$ ',
                  style: AppText.mono(size: size, color: AppColors.primary),
                ),
                TextSpan(
                  text: _cursorOn ? '▋' : ' ',
                  style: AppText.mono(size: size, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderBright),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 60,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 30,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                for (final c in const [
                  Color(0xFFFF5F57),
                  Color(0xFFFEBC2E),
                  Color(0xFF28C840),
                ]) ...[
                  Container(
                    width: 11,
                    height: 11,
                    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 7),
                ],
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'bhavesh@dbu: ~',
                    style: AppText.mono(size: 12, color: AppColors.textDim),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(mobile ? 16 : 22),
            child: ConstrainedBox(
              // Reserve roughly the final height so the layout doesn't jump
              // while typing; grows if lines wrap on narrow screens.
              constraints: BoxConstraints(minHeight: mobile ? 250 : 280),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rows,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
