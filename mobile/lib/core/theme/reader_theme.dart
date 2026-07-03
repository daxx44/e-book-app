import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_typography.dart';

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

  static TextStyle get titleSerif => AppTypography.headline(fontSize: 26);

  static TextStyle get chapterLabelStyle => AppTypography.label(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: chapterLabel,
        letterSpacing: 1.4,
      );

  static TextStyle bodySerif(double fontSize) => AppTypography.body(
        fontSize: fontSize,
        color: bodyText,
        height: 1.75,
      );

  static TextStyle get footerPageStyle => AppTypography.headline(fontSize: 22);

  static TextStyle get footerLabelStyle => AppTypography.label(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: chapterLabel,
        letterSpacing: 1.2,
      );

  static TextStyle get footerPercentStyle => AppTypography.label(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: chapterLabel,
      );
}
