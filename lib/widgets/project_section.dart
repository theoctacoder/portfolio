import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProjectModel> projects = [
      ProjectModel(
        title: 'DGV Money',
        description:
            'A comprehensive SaaS platform for loan processing that serves multiple major banks including HDFC, Federal, Kotak, and Karnataka Bank. The platform features Aadhaar e-KYC integration, e-Signing capabilities, and e-NACH support with robust offline functionality. Processing over 5,000 loan applications monthly, it was showcased to G20 delegates including the Finance Minister and RBI Governor.',
        imagePath: 'assets/images/dgv_money.png',
        link: 'https://www.dgv.in/index.html#/money',
        tags: [
          'Android Native',
          'Aadhaar Integration',
          'e-KYC',
          'Banking',
          "SignDesk",
          "HDFC",
          "Federal",
          "Karnataka",
          "e-NACH",
          'Offline Support',
          'SaaS',
        ],
      ),
      ProjectModel(
        title: 'DGV Connect',
        description:
            'An innovative marketplace app for dairy farmers integrating livestock management with financial services. The platform enables discovery and purchase of indigenous bovine breeds, milking equipment, and provides digital bovine loans through partner banks. Built with advanced features including AI-powered cattle identification and comprehensive farm management tools, the app has driven a 70% increase in digital adoption among 80,000+ farmers. The platform streamlines the traditional pashu mela experience into a digital format, complete with detailed bovine documentation and embedded financing options.',
        imagePath: 'assets/images/dgv_connect.png',
        link:
            'https://play.google.com/store/apps/details?id=com.dgvconnect&hl=en_IN',
        tags: [
          'Android Native',
          'AI Integration',
          'FinTech',
          'Marketplace',
          'Digital Lending',
          'Agriculture',
        ],
      ),
      ProjectModel(
        title: 'DGV Digital Bovine Insurance',
        description: 'An end-to-end digital insurance platform revolutionizing the dairy sector insurance landscape. The platform leverages TensorFlow models for cattle identification and body measurement, improving claim processing time by 80%. This innovative solution helps insurers achieve business scalability and sustainability while reducing loss ratios through advanced digital processes. The platform combines AI-powered measurements with streamlined claim processing to create a more efficient and accurate insurance system for the dairy sector.',
        imagePath: 'assets/images/dgv_dbi.png',
        link: 'https://www.dgv.in/index.html#/insurance',
        tags: [
          'TensorFlow',
          'AI/ML',
          'Flutter',
          "Object Detection",
          "Object Measurement",
          'Insurance Tech',
          'Computer Vision',
          'Digital Claims',
        ],
      ),
      ProjectModel(
        title: 'DGV Pay',
        description: 'A comprehensive payment solution deployed on 5,000+ POS devices across multiple states, bringing doorstep banking services to farmers and milk societies. The platform integrates multiple payment modes including Card payments, AEPS, IMPS, and Micro ATM transactions, transforming how dairy farmers and milk supply chain enterprises access financial services. This digital infrastructure initiative is focused on empowering rural and semi-urban communities with modern banking solutions at their doorstep.',
        imagePath: 'assets/images/dgv_pay.png',
        link: 'https://www.dgv.in/index.html#/pay',
        tags: [
          'Android Native',
          "WPOS",
          'FinTech',
          'POS Integration',
          'AEPS',
          'IMPS',
          'Micro ATM',
          "CARD Payments",
          'Rural Banking',
        ],
      ),
      ProjectModel(
        title: 'U-Instant - Utkarsh Bank',
        description: 'A robust customer onboarding platform developed for Utkarsh Small Finance Bank, featuring both customer-facing (U-Instant) and agent-facing (DigiOnBoarding) applications. Built with Flutter for maximum reliability and efficiency, these interconnected apps have successfully facilitated the onboarding of over 2 million customers to Utkarsh Small Finance Bank. The platform streamlines the entire onboarding process while ensuring compliance with banking regulations and security standards.',
        imagePath: 'assets/images/utkarsh_uinstant.webp',
        link: 'https://www.utkarsh.bank/',
        tags: [
          'Flutter',
          'Banking',
          'Digital Onboarding',
          'FinTech',
          'Customer Experience',
          'Agent Portal',
          'Financial Inclusion',
        ],
      ),
      // ProjectModel(
      //   title: 'Puzzle Paws',
      //   description:
      //       'A delightful iOS puzzle game featuring adorable pets, built with SwiftUI. Perfect for all ages, combining entertainment with brain-training elements.',
      //   imagePath: 'assets/images/puzzle_paws.png',
      //   link: 'https://apps.apple.com/in/app/puzzle-paws/id6587583492',
      //   tags: ['SwiftUI', 'iOS', 'Game Development', 'UI/UX'],
      // ),
      // ProjectModel(
      //   title: 'Mem Match',
      //   description:
      //       'Cross-platform memory training game built with Flutter. Features multiple difficulty levels and brain-training exercises.',
      //   imagePath: 'assets/images/mem_match.jpeg',
      //   link:
      //       'https://play.google.com/store/apps/details?id=com.theoctacoder.memmatch',
      //   tags: ['Flutter', 'Android', 'iOS', 'Cross-Platform'],
      // ),
    ];

    return Column(
      children: [
        Text(
          '< PROJECTS />',
          style: GoogleFonts.orbitron(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3, end: 0),
        const SizedBox(height: 48),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children:
              projects.map((project) => ProjectCard(project: project)).toList(),
        ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
      ],
    );
  }
}

class ProjectModel {
  final String title;
  final String description;
  final String imagePath;
  final String link;
  final List<String> tags;

  ProjectModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.link,
    required this.tags,
  });
}

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Transform.translate(
        offset: isHovered ? const Offset(0, -5) : Offset.zero,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.2),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    widget.project.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.primary.withOpacity(0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 48,
                              color: AppColors.primary.withOpacity(0.5),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Project Preview',
                              style: TextStyle(
                                color: AppColors.primary.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.project.title,
                style: GoogleFonts.orbitron(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.project.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.project.tags
                    .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.9),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => launchUrl(Uri.parse(widget.project.link)),
                icon: const Icon(Icons.launch),
                label: const Text('View Project'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  side: BorderSide(
                    color: AppColors.primary.withOpacity(0.2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
