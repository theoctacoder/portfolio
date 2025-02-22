import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '< EXPERIENCE />',
          style: GoogleFonts.orbitron(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ).animate()
            .fadeIn(duration: 800.ms)
            .slideX(begin: -0.3, end: 0),
        const SizedBox(height: 48),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildExperienceCard(
              company: 'Fermion Infotech',
              role: 'Sr. Mobile Application Developer/AI Developer',
              duration: 'July 2022 - Present',
              achievements: [
                'Developed Liveness Detection SDK achieving 95% accuracy in identity verification',
                'Led Sony\'s Shark Tank India AI chatbot development using LLMs',
                'Built custom ATS with LLMs, automating 90% of screening process',
                'Developed DGV Connect marketplace app for 80,000+ dairy farmers',
                'Created DGV Digital Bovine Insurance platform with ML-based cattle identification',
                'Built and deployed DGV Pay across 5,000+ POS devices',
                'Developed DGV Money processing 5,000+ monthly loan applications',
                'Mentored team of 5 junior developers and established best practices',
              ],
              companyUrl: 'https://fermion.in', // Add company URL

            ),
            _buildExperienceCard(
              company: 'Freelancer',
              role: 'Full Stack Developer',
              duration: 'Jan 2021 - July 2022',
              achievements: [
                'Built Heaven mental health platform using Flutter and Spring Boot',
                'Implemented CI/CD pipelines reducing deployment time by 80%',
                'Developed custom business management solutions',
                'Led multiple successful client projects with diverse tech stacks',
              ],
            ),
            _buildExperienceCard(
              company: 'Herten Technologies',
              role: 'Junior Software Developer',
              duration: 'Aug 2020 - Jan 2021',
              achievements: [
                'Maintained Bada Business CMS serving 50,000+ users',
                'Developed school management SaaS using Laravel',
                'Integrated AWS services for optimal performance',
              ],
              companyUrl: 'https://hertengroup.com/', // Add company URL

            ),
          ],
        ).animate()
            .fadeIn(duration: 800.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildExperienceCard({
    required String company,
    required String role,
    required String duration,
    required List<String> achievements,
    String? companyUrl, // Added company URL parameter
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    company,
                    style: GoogleFonts.orbitron(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  if (companyUrl != null) ...[
                    const SizedBox(width: 8),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => launchUrl(Uri.parse(companyUrl)),
                        child: Icon(
                          Icons.launch,
                          size: 20,
                          color: AppColors.primary.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(duration),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            role,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 16),
          ...achievements.map((achievement) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.arrow_right,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(achievement),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

}

