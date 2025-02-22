import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalProjectsSection extends StatelessWidget {
  const PersonalProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PersonalProjectModel> projects = [
      PersonalProjectModel(
        title: 'Flutter Env Manager',
        description: 'A powerful Flutter package for managing environment configurations using YAML files. It automatically generates Dart classes based on environment configurations, supports multiple environments, and includes features like automatic YAML file creation, dynamic class generation, and pubspec version support. The package simplifies environment management for Flutter applications and is published on pub.dev.',
        githubUrl: 'https://github.com/audibhavesh/flutter_env_manager',
        projectUrl: 'https://pub.dev/packages/flutter_env_manager',
        tags: [
          'Flutter',
          'Package',
          'pub.dev',
          'YAML',
          'Code Generation',
          'Environment Management',
        ],
      ),
      PersonalProjectModel(
        title: 'Android Architecture CLI',
        description: 'An open-source CLI toolkit featuring pre-built templates for Android architectures including Hilt, Dagger, and Flutter architectures like Flutter-Bloc and Flutter-Provider. This toolkit reduces project setup time by 80% while enforcing standardized code practices across teams.',
        githubUrl: 'https://github.com/audibhavesh/android-architecture-cli',
        projectUrl: 'https://www.npmjs.com/package/android-architecture-cli',
        tags: [
          'CLI',
          'Android',
          'Flutter',
          'Hilt',
          'Dagger',
          'Project Templates',
        ],
      ),
      PersonalProjectModel(
        title: 'Puzzle Paws',
        description: 'A delightful iOS puzzle game featuring adorable pets, built with SwiftUI. Perfect for all ages, combining entertainment with brain-training elements.',
        imagePath: 'assets/images/puzzle_paws.png',
        projectUrl: 'https://apps.apple.com/in/app/puzzle-paws/id6587583492',
        tags: ['SwiftUI', 'iOS', 'Game Development', 'UI/UX'],
      ),
      PersonalProjectModel(
        title: 'Mem Match',
        description: 'Cross-platform memory training game built with Flutter. Features multiple difficulty levels and brain-training exercises.',
        imagePath: 'assets/images/mem_match.jpeg',
        projectUrl: 'https://play.google.com/store/apps/details?id=com.theoctacoder.memmatch',
        tags: ['Flutter', 'Android', 'iOS', 'Cross-Platform'],
      ),
    ];

    return Column(
      children: [
        Text(
          '< PERSONAL PROJECTS />',
          style: GoogleFonts.orbitron(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3, end: 0),
        const SizedBox(height: 48),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: projects
              .map((project) => PersonalProjectCard(project: project))
              .toList(),
        ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
      ],
    );
  }
}

class PersonalProjectModel {
  final String title;
  final String description;
  final String? githubUrl;
  final String? projectUrl;
  final String? imagePath;
  final List<String> tags;

  PersonalProjectModel({
    required this.title,
    required this.description,
    this.githubUrl,
    this.projectUrl,
    this.imagePath,
    required this.tags,
  });
}
class PersonalProjectCard extends StatefulWidget {
  final PersonalProjectModel project;

  const PersonalProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<PersonalProjectCard> createState() => _PersonalProjectCardState();
}

class _PersonalProjectCardState extends State<PersonalProjectCard> {
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
              if (widget.project.imagePath != null) ...[
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
                      widget.project.imagePath!,
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
              ],
              Row(
                children: [
                  Icon(
                    widget.project.githubUrl != null ? Icons.code : Icons.apps,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.project.title,
                      style: GoogleFonts.orbitron(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
              // TextButton.icon(
              //   onPressed: () => launchUrl(Uri.parse(
              //       widget.project.githubUrl ?? widget.project.link!)),
              //   icon: Icon(widget.project.githubUrl != null
              //       ? Icons.code
              //       : Icons.launch),
              //   label: Text(widget.project.githubUrl != null
              //       ? 'View Source'
              //       : 'View Project'),
              //   style: TextButton.styleFrom(
              //     foregroundColor: AppColors.primary,
              //     padding:
              //     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //     side: BorderSide(
              //       color: AppColors.primary.withOpacity(0.2),
              //     ),
              //   ),
              // ),
              // Add this to the bottom of the card's Column children
              Row(
                children: [
                  if (widget.project.githubUrl != null)
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () => launchUrl(Uri.parse(widget.project.githubUrl!)),
                        icon: const Icon(Icons.code),
                        label: const Text('Source Code'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          side: BorderSide(
                            color: AppColors.primary.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  if (widget.project.githubUrl != null && widget.project.projectUrl != null)
                    const SizedBox(width: 8),
                  if (widget.project.projectUrl != null)
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () => launchUrl(Uri.parse(widget.project.projectUrl!)),
                        icon: Icon(widget.project.githubUrl != null ? Icons.launch : Icons.apps),
                        label: Text(widget.project.githubUrl != null ? 'View Project' : 'Download'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          side: BorderSide(
                            color: AppColors.primary.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}