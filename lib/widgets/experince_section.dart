import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  // Responsive helpers
  double _getHeaderFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 24;
    if (screenWidth < 600) return 28;
    if (screenWidth < 900) return 32;
    return 36;
  }

  double _getCompanyFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 18;
    if (screenWidth < 600) return 20;
    return 24;
  }

  double _getRoleFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 14;
    if (screenWidth < 600) return 16;
    return 18;
  }

  EdgeInsets _getCardPadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return const EdgeInsets.all(16);
    if (screenWidth < 600) return const EdgeInsets.all(20);
    return const EdgeInsets.all(24);
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
          child: Text(
            '< EXPERIENCE />',
            style: GoogleFonts.orbitron(
              fontSize: _getHeaderFontSize(context),
              fontWeight: FontWeight.bold,
            ),
          ).animate()
              .fadeIn(duration: 800.ms)
              .slideX(begin: -0.3, end: 0),
        ),
        SizedBox(height: isMobile ? 32 : 48),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildExperienceCard(
              context: context,
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
              companyUrl: 'https://fermion.in',
            ),
            _buildExperienceCard(
              context: context,
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
              context: context,
              company: 'Herten Technologies',
              role: 'Junior Software Developer',
              duration: 'Aug 2020 - Jan 2021',
              achievements: [
                'Maintained Bada Business CMS serving 50,000+ users',
                'Developed school management SaaS using Laravel',
                'Integrated AWS services for optimal performance',
              ],
              companyUrl: 'https://hertengroup.com/',
            ),
          ],
        ).animate()
            .fadeIn(duration: 800.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildExperienceCard({
    required BuildContext context,
    required String company,
    required String role,
    required String duration,
    required List<String> achievements,
    String? companyUrl,
  }) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 24 : 32),
      padding: _getCardPadding(context),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (screenWidth < 480) ...[
            // Mobile layout - stacked
            Row(
              children: [
                Expanded(
                  child: Text(
                    company,
                    style: GoogleFonts.orbitron(
                      fontSize: _getCompanyFontSize(context),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
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
                        size: isMobile ? 16 : 20,
                        color: AppColors.primary.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: isMobile ? 6 : 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                duration,
                style: TextStyle(fontSize: isMobile ? 12 : 14),
              ),
            ),
          ] else ...[
            // Desktop layout - side by side
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      company,
                      style: GoogleFonts.orbitron(
                        fontSize: _getCompanyFontSize(context),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(duration),
                ),
              ],
            ),
          ],
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            role,
            style: TextStyle(
              fontSize: _getRoleFontSize(context),
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          ...achievements.map((achievement) => Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 3 : 4,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_right,
                  color: AppColors.primary,
                  size: isMobile ? 16 : 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    achievement,
                    style: TextStyle(
                      fontSize: isMobile ? 13 : 14,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}