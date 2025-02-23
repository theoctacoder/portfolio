import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                '< CONTACT />',
                style: GoogleFonts.orbitron(
                  fontSize: constraints.maxWidth < 600 ? 24 : 36,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ).animate()
                  .fadeIn(duration: 800.ms)
                  .slideX(begin: -0.3, end: 0),
              const SizedBox(height: 32),
              Container(
                padding: EdgeInsets.all(constraints.maxWidth < 600 ? 16 : 32),
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
                        fontSize: constraints.maxWidth < 600 ? 18 : 24,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    _buildContactGrid(constraints.maxWidth),
                  ],
                ),
              ).animate()
                  .fadeIn(duration: 800.ms)
                  .slideY(begin: 0.3, end: 0),
              const SizedBox(height: 32),
              _buildFooterText(), // Footer with copyright
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactGrid(double width) {
    if (width < 600) {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: _getContactButtons(),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _getContactButtons(),
      );
    }
  }

  List<Widget> _getContactButtons() {
    return [
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
    ];
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: constraints.maxWidth < 600 ? null : 180,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                      icon,
                      color: AppColors.primary,
                      size: 24
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooterText() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primary.withOpacity(0.7),
          ),
          children: [
            const TextSpan(text: 'Made with '),
            TextSpan(
              text: '❤️\uFE0F', // Ensures the heart appears as an emoji
              style: const TextStyle(color: Colors.red),
            ),

            const TextSpan(text: ' for Flutter | © 2025'),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

}
