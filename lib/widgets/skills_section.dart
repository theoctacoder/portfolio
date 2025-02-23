import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/app_colors.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  // Responsive helpers
  double _getHeaderFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 24;
    if (screenWidth < 600) return 28;
    if (screenWidth < 900) return 32;
    return 36;
  }

  double _getTitleFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 16;
    if (screenWidth < 600) return 18;
    return 20;
  }

  double _getCardPadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 16;
    if (screenWidth < 600) return 20;
    return 24;
  }

  double _getCardWidth(BuildContext context, BoxConstraints constraints) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return constraints.maxWidth; // Full width on mobile
    } else if (screenWidth < 900) {
      return (constraints.maxWidth - 24) / 2; // Two cards per row on tablet
    }
    return (constraints.maxWidth - 48) / 3; // Three cards per row on desktop
  }

  double _getCardHeight(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 280;
    if (screenWidth < 600) return 300;
    return 320;
  }

  @override
  Widget build(BuildContext context) {
    final List<SkillCategory> skillCategories = [
      SkillCategory(
        title: 'Mobile Development',
        icon: Icons.smartphone,
        skills: [
          'Flutter',
          'Android Native',
          'iOS Native',
          'Jetpack Compose',
          'KMP',
          'SwiftUI',
          'Kotlin',
          'Swift',
        ],
      ),
      SkillCategory(
        title: 'AI & Machine Learning',
        icon: Icons.psychology,
        skills: [
          'TensorFlow',
          'PyTorch',
          'Computer Vision',
          'LLMs',
          'Image Processing',
          'Natural Language Processing',
          'Machine Learning',
          'Deep Learning',
        ],
      ),
      SkillCategory(
        title: 'Backend Development',
        icon: Icons.storage,
        skills: [
          'Spring Boot',
          'Laravel',
          'AWS',
          'Firebase',
          'Docker',
          'Kubernetes',
          'CI/CD',
          'Microservices',
        ],
      ),
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width < 600 ? 16 : 0,
          ),
          child: Text(
            '< SKILLS />',
            style: GoogleFonts.orbitron(
              fontSize: _getHeaderFontSize(context),
              fontWeight: FontWeight.bold,
            ),
          ).animate()
              .fadeIn(duration: 800.ms)
              .slideX(begin: -0.3, end: 0),
        ),
        SizedBox(height: MediaQuery.of(context).size.width < 600 ? 32 : 48),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = _getCardWidth(context, constraints)
                .clamp(300.0, 400.0);
            return Wrap(
              spacing: MediaQuery.of(context).size.width < 600 ? 16 : 24,
              runSpacing: MediaQuery.of(context).size.width < 600 ? 16 : 24,
              children: skillCategories
                  .map((category) => _buildSkillCard(
                context: context,
                title: category.title,
                skills: category.skills,
                icon: category.icon,
                width: cardWidth,
              ))
                  .toList(),
            ).animate()
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.3, end: 0);
          },
        ),
      ],
    );
  }

  Widget _buildSkillCard({
    required BuildContext context,
    required String title,
    required List<String> skills,
    required IconData icon,
    required double width,
  }) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: width,
        height: _getCardHeight(context),
        padding: EdgeInsets.all(_getCardPadding(context)),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile ? 6 : 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: isMobile ? 20 : 24,
                  ),
                ),
                SizedBox(width: isMobile ? 8 : 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: _getTitleFontSize(context),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 16 : 24),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((skill) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 10 : 12,
                    vertical: isMobile ? 4 : 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillCategory {
  final String title;
  final IconData icon;
  final List<String> skills;

  SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}