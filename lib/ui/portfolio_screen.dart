import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/app_colors.dart';

import 'home_screen.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhavesh Auodichya — Mobile Frontend Lead',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bg,
        textTheme: GoogleFonts.spaceGroteskTextTheme(
          ThemeData.dark().textTheme,
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.cyan,
          surface: AppColors.surface,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors.primary.withValues(alpha: 0.3),
        ),
      ),
      home: const SelectionArea(child: HomePage()),
    );
  }
}
