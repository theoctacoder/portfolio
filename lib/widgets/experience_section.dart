import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:portfolio/res/app_text.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:portfolio/widgets/common.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '02',
            kicker: 'git log --career',
            title: 'Experience',
          ),
          const SizedBox(height: 40),
          for (var i = 0; i < jobs.length; i++)
            Reveal(
              child: _Commit(
                job: jobs[i],
                isHead: i == 0,
                isLast: i == jobs.length - 1,
              ),
            ),
        ],
      ),
    );
  }
}

class _Commit extends StatefulWidget {
  final Job job;
  final bool isHead;
  final bool isLast;
  const _Commit({
    required this.job,
    required this.isHead,
    required this.isLast,
  });

  @override
  State<_Commit> createState() => _CommitState();
}

class _CommitState extends State<_Commit> {
  static const _collapsedCount = 3;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final job = widget.job;
    final mobile = Responsive.isMobile(context);
    final dotColor = widget.isHead ? AppColors.primary : AppColors.textDim;
    final canExpand = job.highlights.length > _collapsedCount;
    final shown = _expanded || !canExpand
        ? job.highlights
        : job.highlights.take(_collapsedCount).toList();

    final railWidth = mobile ? 20.0 : 32.0;

    // Stack instead of IntrinsicHeight: the rail line stretches to whatever
    // height the wrapped text actually takes.
    return Stack(
      children: [
        if (!widget.isLast)
          Positioned(
            left: railWidth / 2 - 1,
            top: 30,
            bottom: 0,
            child: Container(width: 2, color: AppColors.border),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Graph rail.
            SizedBox(
              width: railWidth,
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  widget.isHead
                      ? PulseDot(color: dotColor, size: 10)
                      : Container(
                          width: 11,
                          height: 11,
                          margin: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.bg,
                            border: Border.all(color: dotColor, width: 2),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(width: mobile ? 10 : 18),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 44),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          'commit ${job.hash}',
                          style: AppText.mono(size: 12, color: AppColors.amber),
                        ),
                        Text(
                          '(${job.branch})',
                          style: AppText.mono(
                            size: 12,
                            color: widget.isHead
                                ? AppColors.cyan
                                : AppColors.textDim,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      job.role,
                      style: AppText.display(size: mobile ? 22 : 28),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 14,
                      runSpacing: 4,
                      children: [
                        Text(
                          '@ ${job.company}',
                          style: AppText.body(
                            size: 15,
                            color: AppColors.primary,
                            weight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${job.period}  ·  ${job.location}',
                          style: AppText.mono(size: 12.5, height: 1.9),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [for (final h in shown) _HighlightRow(h)],
                      ),
                    ),
                    if (canExpand)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => setState(() => _expanded = !_expanded),
                            child: Text(
                              _expanded
                                  ? '− collapse'
                                  : '+ ${job.highlights.length - _collapsedCount} more changes',
                              style: AppText.mono(
                                size: 12.5,
                                color: AppColors.cyan,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HighlightRow extends StatelessWidget {
  final Highlight h;
  const _HighlightRow(this.h);

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              '+ ',
              style: AppText.mono(size: 13, color: AppColors.primary),
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${h.lead}  ',
                    style: AppText.body(
                      size: mobile ? 14.5 : 15.5,
                      color: AppColors.text,
                      weight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: h.text,
                    style: AppText.body(size: mobile ? 14.5 : 15.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
