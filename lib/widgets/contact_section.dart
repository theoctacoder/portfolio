import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '< CONTACT />',
          style: GoogleFonts.orbitron(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ).animate()
            .fadeIn(duration: 800.ms)
            .slideX(begin: -0.3, end: 0),
        const SizedBox(height: 48),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Text(
                'Let\'s Build Something Amazing Together',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildContactButton(
                    icon: Icons.email,
                    label: 'Email',
                    onTap: () => launchUrl(Uri.parse('mailto:audichyabhavesh33@gmail.com')),
                  ),
                  _buildContactButton(
                    icon: Icons.link,
                    label: 'LinkedIn',
                    onTap: () => launchUrl(Uri.parse('https://linkedin.com/in/audibhavesh')),
                  ),
                  _buildContactButton(
                    icon: Icons.code,
                    label: 'GitHub',
                    onTap: () => launchUrl(Uri.parse('https://github.com/audibhavesh')),
                  ),
                  _buildContactButton(
                    icon: Icons.question_answer,
                    label: 'Stack Overflow',
                    onTap: () => launchUrl(Uri.parse('https://stackoverflow.com/users/8818996/bhavesh-audichya')),
                  ),
                ],
              ),
            ],
          ),
        ).animate()
            .fadeIn(duration: 800.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(icon, color: AppColors.primary, size: 24),
                const SizedBox(height: 8),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}