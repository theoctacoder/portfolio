import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/bloc/portfolio_bloc.dart';
import 'package:portfolio/bloc/portfolio_event.dart';
import 'package:portfolio/res/app_colors.dart';
import 'package:portfolio/widgets/nav_item.dart';
import 'package:portfolio/widgets/personal_project_section.dart';
import 'package:portfolio/widgets/resume_section.dart';

import '../widgets/contact_section.dart';
import '../widgets/experince_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/project_section.dart';
import '../widgets/skills_section.dart';
import 'package:visibility_detector/visibility_detector.dart';

// Add these controllers at the top of HomePage class
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  final GlobalKey resumeKey = GlobalKey();
  final GlobalKey personalProjectsKey = GlobalKey();

  String _currentSection = '';
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // Show/hide scroll to top button
    setState(() {
      _showScrollToTop = _scrollController.offset > 700;

      // Clear selection when at top
      if (_scrollController.offset < 100) {
        _currentSection = '';
      }
    });
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    ).then((_) {
      // Ensure selection is cleared after scroll animation
      setState(() {
        _currentSection = '';
      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.darkBg.withOpacity(0.95),
        elevation: 0,
        toolbarHeight: 70,
        // Increased height to accommodate content
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: ScrollProgressIndicator(scrollController: _scrollController),
        ),
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _scrollToTop,
                child: Text(
                  'BA',
                  style: GoogleFonts.orbitron(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
              ),
            ),
            const Spacer(),
            _buildNavItems(),
          ],
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _showScrollToTop ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.arrow_upward),
        )
            .animate()
            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            children: [
              const SizedBox(height: 32), // Add spacing after fixed AppBar
              const HeroSection(),
              const SizedBox(height: 100),
              _buildSectionWithDetector(
                'skills',
                SkillsSection(key: skillsKey),
              ),
              const SizedBox(height: 100),
              _buildSectionWithDetector(
                'experience',
                ExperienceSection(key: experienceKey),
              ),
              const SizedBox(height: 100),
              _buildSectionWithDetector(
                'projects',
                ProjectsSection(key: projectsKey),
              ),
              const SizedBox(height: 100),

              _buildSectionWithDetector(
                'personal',
                PersonalProjectsSection(key: personalProjectsKey),
              ),
              const SizedBox(height: 100),
              _buildSectionWithDetector(
                'resume',
                ResumeSection(key: resumeKey),
              ),
              const SizedBox(height: 100),
              _buildSectionWithDetector(
                'contact',
                ContactSection(key: contactKey),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItems() {
    return Row(
      children: [
        _buildNavItem('Skills', skillsKey),
        _buildNavItem('Experience', experienceKey),
        _buildNavItem('Projects', projectsKey),
        _buildNavItem('Personal Projects', personalProjectsKey),
        _buildNavItem('Resume', resumeKey),
        _buildNavItem('Contact', contactKey),
      ],
    );
  }

  Widget _buildNavItem(String title, GlobalKey key) {
    final isSelected = _currentSection.toLowerCase() == title.toLowerCase();
    return NavItem(
      title: title,
      isSelected: isSelected,
      onTap: () {
        if (title.toLowerCase() == _currentSection.toLowerCase()) {
          _scrollToTop();
        } else {
          _scrollToSection(key);
        }
      },
    );

  }

  Widget _buildSectionWithDetector(String sectionId, Widget child) {
    return VisibilityDetector(
      key: Key(sectionId),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.3) {
          if (_scrollController.offset > 100) {
            setState(() {
              _currentSection = sectionId;
            });
          }
        }
      },
      child: child,
    );
  }
}

// Add Progress Indicator
class ScrollProgressIndicator extends StatelessWidget {
  final ScrollController scrollController;

  const ScrollProgressIndicator({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ScrollPosition?>(
      valueListenable: _ScrollPositionListenable(scrollController),
      builder: (context, position, child) {
        if (position == null) {
          return const LinearProgressIndicator(
            value: 0,
            backgroundColor: Colors.transparent,
            minHeight: 2,
          );
        }

        final double progress =
            position.hasContentDimensions && position.maxScrollExtent > 0
                ? (position.pixels / position.maxScrollExtent).clamp(0.0, 1.0)
                : 0.0;

        return LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 2,
        );
      },
    );
  }
}

// Custom ValueListenable for scroll position
class _ScrollPositionListenable extends ValueListenable<ScrollPosition?> {
  final ScrollController controller;
  final List<VoidCallback> _listeners = [];
  ScrollPosition? _position;

  _ScrollPositionListenable(this.controller) {
    controller.addListener(_handleScroll);
  }

  void _handleScroll() {
    final ScrollPosition? newPosition =
        controller.hasClients ? controller.position : null;
    if (newPosition != _position) {
      _position = newPosition;
      for (final listener in _listeners) {
        listener();
      }
    }
  }

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  @override
  ScrollPosition? get value => _position;

  void dispose() {
    controller.removeListener(_handleScroll);
    _listeners.clear();
  }
}
