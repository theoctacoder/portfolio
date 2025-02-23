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
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
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

  // Responsive sizing helpers
  double _getHorizontalPadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 16.0;
    if (screenWidth < 1200) return 32.0;
    return 48.0;
  }

  double _getResponsiveSpacing(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) return 40.0;
    if (screenHeight < 900) return 60.0;
    return 100.0;
  }

  double _getResponsiveFontSize(
    BuildContext context, {
    double baseSize = 16,
    double minSize = 14,
    double maxSize = 24,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * (baseSize / 1000);
    return fontSize.clamp(minSize, maxSize);
  }

  bool _isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  void _scrollListener() {
    setState(() {
      _showScrollToTop = _scrollController.offset > 700;
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
    _scrollController
        .animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    )
        .then((_) {
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

  // Drawer for mobile navigation
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: AppColors.darkBg,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: Text(
                'Navigation',
                style: GoogleFonts.orbitron(
                  fontSize: 24,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerNavigationItems(),
          ],
        ),
      ),
    );
  }

  // Create drawer navigation items
  Widget _buildDrawerNavigationItems() {
    return Column(
      children: [
        _buildDrawerItem('Home', () => _scrollToTop()),
        _buildDrawerItem('Skills', () => _scrollToSection(skillsKey)),
        _buildDrawerItem('Experience', () => _scrollToSection(experienceKey)),
        _buildDrawerItem('Projects', () => _scrollToSection(projectsKey)),
        _buildDrawerItem(
            'Personal Projects', () => _scrollToSection(personalProjectsKey)),
        _buildDrawerItem('Resume', () => _scrollToSection(resumeKey)),
        _buildDrawerItem('Contact', () => _scrollToSection(contactKey)),
      ],
    );
  }

  // Helper method for drawer items
  Widget _buildDrawerItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        onTap(); // Perform scroll action
      },
    );
  }

  // Desktop navigation items
  Widget _buildDesktopNavigation() {
    return Row(
      mainAxisSize: MainAxisSize.min,
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

  // Navigation item for desktop
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

  // Section visibility detector
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove automaticallyImplyLeading
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // This removes the default menu icon
        // Prevents any leading widget from appearing
        backgroundColor: AppColors.darkBg.withOpacity(0.95),
        elevation: 0,
        toolbarHeight: _isMobileView(context) ? 60 : 70,
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
                    fontSize: _getResponsiveFontSize(context, baseSize: 24),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const Spacer(),
            if (!_isMobileView(context)) _buildDesktopNavigation(),
          ],
        ),
      ),
      endDrawer: _isMobileView(context) ? _buildDrawer() : null,
      floatingActionButton: AnimatedOpacity(
        opacity: _showScrollToTop ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.arrow_upward),
        ).animate().scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
            ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _getHorizontalPadding(context),
          ),
          child: Column(
            children: [
              SizedBox(height: _getResponsiveSpacing(context) * 0.3),
              const HeroSection(),
              SizedBox(height: _getResponsiveSpacing(context)),
              _buildSectionWithDetector(
                'skills',
                SkillsSection(key: skillsKey),
              ),
              SizedBox(height: _getResponsiveSpacing(context)),
              _buildSectionWithDetector(
                'experience',
                ExperienceSection(key: experienceKey),
              ),
              SizedBox(height: _getResponsiveSpacing(context)),
              _buildSectionWithDetector(
                'projects',
                ProjectsSection(key: projectsKey),
              ),
              SizedBox(height: _getResponsiveSpacing(context)),
              _buildSectionWithDetector(
                'personal',
                PersonalProjectsSection(key: personalProjectsKey),
              ),
              SizedBox(height: _getResponsiveSpacing(context)),
              _buildSectionWithDetector(
                'resume',
                ResumeSection(key: resumeKey),
              ),
              SizedBox(height: _getResponsiveSpacing(context)),
              _buildSectionWithDetector(
                'contact',
                ContactSection(key: contactKey),
              ),
              SizedBox(height: _getResponsiveSpacing(context) * 0.5),
            ],
          ),
        ),
      ),
    );
  }
}

// Rest of the code remains the same (ScrollProgressIndicator and _ScrollPositionListenable classes)
// Existing ScrollProgressIndicator and _ScrollPositionListenable classes remain the same
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
