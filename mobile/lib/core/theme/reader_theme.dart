import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reading-focused palette and typography matching the premium reader mockup.
class ReaderTheme {
  ReaderTheme._();

  static const Color toolbarBackground = Color(0xFFF3F1EE);
  static const Color canvasBackground = Color(0xFFFAF8F5);
  static const Color footerBackground = Color(0xFFF0EBE3);
  static const Color chapterLabel = Color(0xFF8B7355);
  static const Color bodyText = Color(0xFF3D3632);
  static const Color progressTrack = Color(0xFFE0D8D0);
  static const Color progressFill = Color(0xFF5D4037);
  static const Color iconColor = Color(0xFF2C2420);

  static TextStyle get titleSerif => GoogleFonts.merriweather(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.25,
      );

  static TextStyle get chapterLabelStyle => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: chapterLabel,
        letterSpacing: 1.4,
      );

  static TextStyle bodySerif(double fontSize) => GoogleFonts.merriweather(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: bodyText,
        height: 1.75,
      );

  static TextStyle get footerPageStyle => GoogleFonts.merriweather(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get footerLabelStyle => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: chapterLabel,
        letterSpacing: 1.2,
      );

  static TextStyle get footerPercentStyle => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: chapterLabel,
      );
}
