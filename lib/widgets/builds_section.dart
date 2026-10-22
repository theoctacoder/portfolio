import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:portfolio/res/app_text.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:portfolio/widgets/common.dart';

class BuildsSection extends StatefulWidget {
  const BuildsSection({super.key});

  @override
  State<BuildsSection> createState() => _BuildsSectionState();
}

class _BuildsSectionState extends State<BuildsSection> {
  BuildTag? _filter;
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final items = _filter == null
        ? builds
        : builds.where((b) => b.tags.contains(_filter)).toList();
    final w = Responsive.width(context);
    final cols = w < 720 ? 1 : (w < 1080 ? 2 : 3);
    // Keep the first view short; filters always show their full set.
    final limit = cols == 1 ? 4 : cols * 2;
    final truncated = _filter == null && !_showAll && items.length > limit;
    final visible = truncated ? items.take(limit).toList() : items;

    return ContentFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '03',
            kicker: 'ls ./builds',
            title: 'Things I\'ve shipped',
            subtitle: 'Kiosks, SDKs, banking apps and ML models — most of them running in production for banks and their customers.',
          ),
          const SizedBox(height: 28),
          Reveal(child: _filters()),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 16.0;
              final itemWidth =
                  (constraints.maxWidth - gap * (cols - 1)) / cols;
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Wrap(
                  key: ValueKey(_filter),
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final b in visible)
                      SizedBox(
                        width: itemWidth,
                        child: _BuildCard(item: b),
                      ),
                  ],
                ),
              );
            },
          ),
          if (truncated) ...[
            const SizedBox(height: 24),
            Center(
              child: ConsoleButton(
                label: 'show all ${items.length} builds',
                icon: Icons.unfold_more_rounded,
                onTap: () => setState(() => _showAll = true),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _filters() {
    Widget chip(String label, BuildTag? tag) {
      final selected = _filter == tag;
      final count = tag == null
          ? builds.length
          : builds.where((b) => b.tags.contains(tag)).length;
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => setState(() => _filter = tag),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '--$label',
                    style: AppText.mono(
                      size: 12.5,
                      color: selected ? AppColors.primary : AppColors.text,
                    ),
                  ),
                  TextSpan(
                    text: '  $count',
                    style: AppText.mono(size: 11, color: AppColors.textDim),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        chip('all', null),
        for (final t in BuildTag.values) chip(t.label, t),
      ],
    );
  }
}

class _BuildCard extends StatelessWidget {
  final BuildItem item;
  const _BuildCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      padding: EdgeInsets.zero,
      onTap: item.url != null ? () => openUrl(item.url!) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (item.image != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(13),
              ),
              child: SizedBox(
                height: 160,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(item.image!, fit: BoxFit.cover),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00000000), Color(0xCC0C1016)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.org.toLowerCase(),
                        style: AppText.mono(size: 11.5),
                      ),
                    ),
                    if (item.url != null)
                      const Icon(
                        Icons.north_east_rounded,
                        size: 16,
                        color: AppColors.textMuted,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(item.title, style: AppText.display(size: 22, height: 1.2)),
                const SizedBox(height: 10),
                Text(item.summary, style: AppText.body(size: 14, height: 1.55)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.8),
                        width: 2,
                      ),
                    ),
                    color: AppColors.primary.withValues(alpha: 0.06),
                  ),
                  child: Text(
                    item.metric,
                    style: AppText.mono(
                      size: 12.5,
                      color: AppColors.primary,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [for (final s in item.stack) TagChip(s)],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
