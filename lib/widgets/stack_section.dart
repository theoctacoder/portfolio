import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:portfolio/res/app_text.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:portfolio/widgets/common.dart';

/// Skills rendered as a config file, plus open-source / side projects.
class StackSection extends StatelessWidget {
  const StackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stacked = Responsive.isTablet(context);
    return ContentFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '04',
            kicker: 'cat stack.toml',
            title: 'Stack & open source',
          ),
          const SizedBox(height: 40),
          if (stacked) ...[
            const Reveal(child: _SkillsFile()),
            const SizedBox(height: 20),
            const _OpenSourceList(),
          ] else
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 11, child: Reveal(child: _SkillsFile())),
                SizedBox(width: 20),
                Expanded(flex: 9, child: _OpenSourceList()),
              ],
            ),
        ],
      ),
    );
  }
}

class _SkillsFile extends StatelessWidget {
  const _SkillsFile();

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    var lineNo = 1;

    Widget line(Widget content) {
      final n = lineNo++;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '$n',
              textAlign: TextAlign.right,
              style: AppText.mono(
                size: 12,
                color: AppColors.textDim,
                height: 2,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: content),
        ],
      );
    }

    final lines = <Widget>[];
    for (final g in skillGroups) {
      lines.add(
        line(
          Text(
            '[${g.key}]',
            style: AppText.mono(size: 13, color: g.color, height: 2),
          ),
        ),
      );
      lines.add(
        line(
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 10),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [for (final s in g.items) TagChip(s, color: g.color)],
            ),
          ),
        ),
      );
    }

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
                const Icon(
                  Icons.description_outlined,
                  size: 14,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 8),
                Text(
                  'stack.toml',
                  style: AppText.mono(size: 12, color: AppColors.text),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(mobile ? 4 : 10, 14, 18, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: lines,
            ),
          ),
        ],
      ),
    );
  }
}

class _OpenSourceList extends StatelessWidget {
  const _OpenSourceList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < openSource.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Reveal(
              delay: Duration(milliseconds: 80 * i),
              child: _RepoCard(item: openSource[i]),
            ),
          ),
      ],
    );
  }
}

class _RepoCard extends StatelessWidget {
  final OpenSourceItem item;
  const _RepoCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      accent: item.color,
      padding: const EdgeInsets.all(20),
      onTap: () => openUrl(item.url),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.inventory_2_outlined,
                size: 16,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.name,
                  style: AppText.mono(
                    size: 14,
                    color: AppColors.text,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              TagChip(item.registry, color: item.color),
            ],
          ),
          const SizedBox(height: 10),
          Text(item.description, style: AppText.body(size: 14, height: 1.5)),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(item.language, style: AppText.mono(size: 12)),
              const Spacer(),
              if (item.sourceUrl != null)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => openUrl(item.sourceUrl!),
                    child: Text(
                      'source ↗',
                      style: AppText.mono(size: 12, color: AppColors.cyan),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
