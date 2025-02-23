import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/app_colors.dart';
import 'floating_icons.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  // Responsive font sizes
  double _getNameFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 28;
    if (screenWidth < 600) return 32;
    if (screenWidth < 900) return 40;
    return 48;
  }

  double _getSubtitleFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 16;
    if (screenWidth < 600) return 18;
    if (screenWidth < 900) return 20;
    return 24;
  }

  double _getStatNumberFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 24;
    if (screenWidth < 600) return 28;
    if (screenWidth < 900) return 32;
    return 36;
  }

  // Responsive padding
  EdgeInsets _getStatCardPadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return const EdgeInsets.all(12);
    if (screenWidth < 600) return const EdgeInsets.all(16);
    return const EdgeInsets.all(24);
  }

  EdgeInsets _getStatCardMargin(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return const EdgeInsets.symmetric(horizontal: 8);
    if (screenWidth < 600) return const EdgeInsets.symmetric(horizontal: 12);
    return const EdgeInsets.symmetric(horizontal: 16);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    return SizedBox(
      height: screenHeight - (isMobile ? 60 : 100), // Adjust for smaller mobile header
      child: Stack(
        children: [
          const FloatingIconBackground(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.0 : 24.0,
                  vertical: isMobile ? 24.0 : 32.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'BHAVESH AUODICHYA',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.orbitron(
                          fontSize: _getNameFontSize(context),
                          fontWeight: FontWeight.bold,
                          letterSpacing: isMobile ? 1 : 2,
                        ),
                      ),
                    ).animate()
                        .fadeIn(duration: 800.ms)
                        .slideY(begin: 0.3, end: 0),
                    SizedBox(height: isMobile ? 16 : 24),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          isMobile
                              ? 'Mobile Development\nAI Engineering\nFull Stack'
                              : 'Mobile Development • AI Engineering • Full Stack',
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: _getSubtitleFontSize(context),
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                    SizedBox(height: isMobile ? 32 : 48),
                    _buildStatsSection(context, isMobile),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          _buildStatCard(context, '6+', 'Years\nExperience'),
          const SizedBox(height: 16),
          _buildStatCard(context, '80K+', 'Users\nImpacted'),
          const SizedBox(height: 16),
          _buildStatCard(context, '20L+', 'Bank Customers\nOnboarded'),
        ],
      ).animate()
          .fadeIn(duration: 800.ms, delay: 500.ms)
          .slideY(begin: 0.3, end: 0);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatCard(context, '6+', 'Years\nExperience'),
        _buildStatCard(context, '80K+', 'Users\nImpacted'),
        _buildStatCard(context, '20L+', 'Bank Customers\nOnboarded'),
      ],
    ).animate()
        .fadeIn(duration: 800.ms, delay: 500.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildStatCard(BuildContext context, String number, String label) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      margin: _getStatCardMargin(context),
      padding: _getStatCardPadding(context),
      width: isMobile ? double.infinity : null,
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: GoogleFonts.orbitron(
              fontSize: _getStatNumberFontSize(context),
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: isMobile ? 4 : 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 14 : 16,
            ),
          ),
        ],
      ),
    );
  }
}