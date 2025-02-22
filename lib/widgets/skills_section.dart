import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/app_colors.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
        Text(
          '< SKILLS />',
          style: GoogleFonts.orbitron(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ).animate()
            .fadeIn(duration: 800.ms)
            .slideX(begin: -0.3, end: 0),
        const SizedBox(height: 48),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = (constraints.maxWidth - 48) / 3;
            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children: skillCategories
                  .map((category) => _buildSkillCard(
                title: category.title,
                skills: category.skills,
                icon: category.icon,
                width: cardWidth.clamp(300, 400),
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
    required String title,
    required List<String> skills,
    required IconData icon,
    required double width,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: width,
        height: 320,
        padding: const EdgeInsets.all(24),
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((skill) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
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
                    style: const TextStyle(
                      color: Colors.white,  // Changed to white
                      fontSize: 14,
                      fontWeight: FontWeight.w400,  // Slightly lighter weight for better readability
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