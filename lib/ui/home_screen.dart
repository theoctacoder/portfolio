import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:portfolio/res/app_text.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:portfolio/widgets/builds_section.dart';
import 'package:portfolio/widgets/common.dart';
import 'package:portfolio/widgets/contact_section.dart';
import 'package:portfolio/widgets/dbu_section.dart';
import 'package:portfolio/widgets/experience_section.dart';
import 'package:portfolio/widgets/hero_section.dart';
import 'package:portfolio/widgets/stack_section.dart';

class _NavTarget {
  final String label;
  final GlobalKey key;
  _NavTarget(this.label) : key = GlobalKey();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scroll = ScrollController();
  final _sections = [
    _NavTarget('dbu'),
    _NavTarget('experience'),
    _NavTarget('builds'),
    _NavTarget('stack'),
    _NavTarget('contact'),
  ];

  int _active = -1;
  double _progress = 0;
  bool _scrolled = false;
  bool _menuOpen = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = _scroll.position;
    final progress = pos.maxScrollExtent > 0
        ? (pos.pixels / pos.maxScrollExtent).clamp(0.0, 1.0)
        : 0.0;

    // Active section = last one whose top has passed a third of the viewport.
    final probe = MediaQuery.sizeOf(context).height * 0.33;
    var active = -1;
    for (var i = 0; i < _sections.length; i++) {
      final box =
          _sections[i].key.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= probe) active = i;
    }

    if (progress != _progress ||
        active != _active ||
        (pos.pixels > 20) != _scrolled) {
      setState(() {
        _progress = progress;
        _active = active;
        _scrolled = pos.pixels > 20;
      });
    }
  }

  void _goTo(int index) {
    setState(() => _menuOpen = false);
    final ctx = _sections[index].key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
    );
  }

  void _toTop() {
    setState(() => _menuOpen = false);
    _scroll.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  void _openResume() =>
      openUrl(Uri.base.resolve('assets/${Links.resumeAsset}').toString());

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final gap = SizedBox(height: mobile ? 96 : 150);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scroll,
            child: Column(
              children: [
                HeroSection(onViewWork: () => _goTo(0), onResume: _openResume),
                SizedBox(height: mobile ? 48 : 80),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: DbuSection(key: _sections[0].key),
                ),
                gap,
                ExperienceSection(key: _sections[1].key),
                SizedBox(height: mobile ? 56 : 100),
                BuildsSection(key: _sections[2].key),
                gap,
                StackSection(key: _sections[3].key),
                gap,
                ContactSection(key: _sections[4].key, onResume: _openResume),
              ],
            ),
          ),
          Positioned(top: 0, left: 0, right: 0, child: _navBar(mobile)),
        ],
      ),
    );
  }

  Widget _navBar(bool mobile) {
    final compact = Responsive.width(context) < 960;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _scrolled || _menuOpen ? 14 : 0,
          sigmaY: _scrolled || _menuOpen ? 14 : 0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _scrolled || _menuOpen
                ? AppColors.bg.withValues(alpha: 0.78)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: _scrolled ? AppColors.border : Colors.transparent,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: Responsive.maxContentWidth,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.gutter(context),
                      vertical: mobile ? 14 : 18,
                    ),
                    child: Row(
                      children: [
                        _logo(),
                        const Spacer(),
                        if (compact)
                          IconButton(
                            onPressed: () =>
                                setState(() => _menuOpen = !_menuOpen),
                            icon: Icon(
                              _menuOpen ? Icons.close : Icons.menu_rounded,
                              color: AppColors.text,
                            ),
                          )
                        else
                          for (var i = 0; i < _sections.length; i++)
                            _NavLink(
                              index: i,
                              label: _sections[i].label,
                              active: _active == i,
                              onTap: () => _goTo(i),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
              if (compact)
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  child: _menuOpen
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            children: [
                              for (var i = 0; i < _sections.length; i++)
                                InkWell(
                                  onTap: () => _goTo(i),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '0${i + 1}',
                                          style: AppText.mono(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        const SizedBox(width: 14),
                                        Text(
                                          _sections[i].label,
                                          style: AppText.mono(
                                            size: 16,
                                            color: AppColors.text,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      : const SizedBox(width: double.infinity),
                ),
              // Scroll progress.
              Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: _progress,
                  child: Container(
                    height: 2,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.cyan],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _toTop,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LogoMark(size: 30),
            const SizedBox(width: 10),
            Text(
              '~/bhavesh',
              style: AppText.mono(size: 13, color: AppColors.text),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final int index;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _NavLink({
    required this.index,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final lit = widget.active || _hover;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '0${widget.index + 1}. ',
                  style: AppText.mono(size: 12, color: AppColors.primary),
                ),
                TextSpan(
                  text: widget.label,
                  style: AppText.mono(
                    size: 13,
                    color: lit ? AppColors.text : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
