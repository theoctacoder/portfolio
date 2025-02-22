import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/app_colors.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:html' as html;

class ResumeSection extends StatefulWidget {
  const ResumeSection({super.key});

  @override
  State<ResumeSection> createState() => _ResumeSectionState();
}

class _ResumeSectionState extends State<ResumeSection> {
  bool isHovered = false;
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '< RESUME />',
          style: GoogleFonts.orbitron(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ).animate()
            .fadeIn(duration: 800.ms)
            .slideX(begin: -0.3, end: 0),
        const SizedBox(height: 48),
        MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isHovered ? AppColors.primary : AppColors.primary.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                    if (isDownloading)
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'My Resume',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Download my resume to learn more about my experience,\nskills, and qualifications.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDownloadButton(
                      label: 'PDF Version',
                      icon: Icons.picture_as_pdf,
                      assetPath: 'assets/resume/bhavesh_auodichya_resume.pdf',
                    ),
                    const SizedBox(width: 16),
                    // _buildDownloadButton(
                    //   label: 'Word Version',
                    //   icon: Icons.document_scanner,
                    //   assetPath: 'assets/resume/bhavesh_auodichya_resume.docx',
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ).animate()
            .fadeIn(duration: 800.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildDownloadButton({
    required String label,
    required IconData icon,
    required String assetPath,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _downloadResume(assetPath),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _downloadResume(String assetPath) async {
    setState(() => isDownloading = true);

    try {
      // For web platform
      if (kIsWeb) {
        final bytes = await rootBundle.load(assetPath);
        final blob = html.Blob([bytes.buffer.asUint8List()]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement()
          ..href = url
          ..style.display = 'none'
          ..download = assetPath.split('/').last;
        html.document.body?.children.add(anchor);
        anchor.click();
        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      }
      // For mobile platforms
      else {
        // Implement mobile download logic if needed
      }
    } catch (e) {
      print('Error downloading resume: $e');
    } finally {
      setState(() => isDownloading = false);
    }
  }
}