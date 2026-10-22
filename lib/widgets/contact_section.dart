import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:portfolio/res/app_text.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:portfolio/widgets/common.dart';

class ContactSection extends StatelessWidget {
  final VoidCallback onResume;
  const ContactSection({super.key, required this.onResume});

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);

    return ContentFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '05',
            kicker: 'ping',
            title: 'Let\'s build something\nthat ships.',
          ),
          const SizedBox(height: 36),
          Reveal(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(mobile ? 20 : 36),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    AppColors.surface,
                    AppColors.cyan.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '\$ ',
                          style: AppText.mono(
                            size: mobile ? 13 : 15,
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(
                          text: 'mail -s "hello" ',
                          style: AppText.mono(
                            size: mobile ? 13 : 15,
                            color: AppColors.text,
                          ),
                        ),
                        TextSpan(
                          text: Links.email,
                          style: AppText.mono(
                            size: mobile ? 13 : 15,
                            color: AppColors.cyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 620),
                    child: Text(
                      'Open to conversations about Android platform work, banking hardware, on-device AI and leading mobile teams.',
                      style: AppText.body(size: mobile ? 15 : 17),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ConsoleButton(
                        label: 'email_me',
                        icon: Icons.alternate_email_rounded,
                        filled: true,
                        onTap: () => openUrl('mailto:${Links.email}'),
                      ),
                      ConsoleButton(
                        label: 'resume.pdf',
                        icon: Icons.download_rounded,
                        onTap: onResume,
                      ),
                      ConsoleButton(
                        label: 'linkedin',
                        icon: Icons.work_outline_rounded,
                        onTap: () => openUrl(Links.linkedIn),
                      ),
                      ConsoleButton(
                        label: 'github',
                        icon: Icons.code_rounded,
                        onTap: () => openUrl(Links.github),
                      ),
                      ConsoleButton(
                        label: 'stackoverflow',
                        icon: Icons.layers_outlined,
                        onTap: () => openUrl(Links.stackOverflow),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 56),
          Container(height: 1, color: AppColors.border),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 8,
              spacing: 24,
              children: [
                Text(
                  '© ${DateTime.now().year} bhavesh auodichya',
                  style: AppText.mono(size: 12, color: AppColors.textDim),
                ),
                Text(
                  'built with flutter · compiled to web',
                  style: AppText.mono(size: 12, color: AppColors.textDim),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
