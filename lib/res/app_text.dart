import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/app_colors.dart';

/// Mono for labels/code, grotesk for headings and body.
class AppText {
  static TextStyle mono({
    double size = 13,
    Color color = AppColors.textMuted,
    FontWeight weight = FontWeight.w400,
    double? height,
    double letterSpacing = 0,
  }) => GoogleFonts.jetBrainsMono(
    fontSize: size,
    color: color,
    fontWeight: weight,
    height: height,
    letterSpacing: letterSpacing,
  );

  static TextStyle display({
    double size = 48,
    Color color = AppColors.text,
    FontWeight weight = FontWeight.w700,
    double height = 1.05,
  }) => GoogleFonts.spaceGrotesk(
    fontSize: size,
    color: color,
    fontWeight: weight,
    height: height,
    letterSpacing: -size * 0.03,
  );

  static TextStyle body({
    double size = 16,
    Color color = AppColors.textMuted,
    FontWeight weight = FontWeight.w400,
    double height = 1.6,
  }) => GoogleFonts.spaceGrotesk(
    fontSize: size,
    color: color,
    fontWeight: weight,
    height: height,
  );
}
