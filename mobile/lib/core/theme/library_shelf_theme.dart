import 'package:flutter/material.dart';

/// Dark wooden bookshelf palette matching the premium library mockup.
class LibraryShelfTheme {
  LibraryShelfTheme._();

  static const Color woodDark = Color(0xFF1E1210);
  static const Color woodMid = Color(0xFF2C1814);
  static const Color woodPlank = Color(0xFF3D281F);
  static const Color shelfTop = Color(0xFF9A7B6A);
  static const Color shelfMid = Color(0xFF6D4C41);
  static const Color shelfShadow = Color(0xFF3E2723);
  static const Color headerText = Color(0xFFF5F0EB);
  static const Color headerMuted = Color(0xFFB8A99E);
  static const Color navActive = Color(0xFFD4A574);
  static const Color navInactive = Color(0xFF8A7A72);
  static const Color fabBrown = Color(0xFF6D4C41);
  static const Color spotlight = Color(0x44FFCC80);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF352018), woodMid, woodDark],
  );

  static const LinearGradient shelfGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [shelfTop, shelfMid, shelfShadow],
  );
}
