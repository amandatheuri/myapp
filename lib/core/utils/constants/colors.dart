import 'package:flutter/material.dart';
class TColors {
  TColors._();
  
  // Primary Colors
  static const Color primaryColor = Color.fromARGB(255, 57, 181, 74);
  static const Color secondaryColor = Color(0xFFB8B7BC);
  static const Color tertiaryColor = Color(0xFFEFEFEF);

  // Text Colors
  static const Color primaryTextColorLight = Color(0xFF000000);
  static const Color primaryTextColorDark = Colors.white;

  // Background Colors
  static const Color primaryBackgroundLight = Color(0xFFFFFFFF);
  static const Color primaryBackgroundDark = Color(0xFF000000);

  // Button Colors
  static const Color backgroundButton = Color.fromARGB(255, 157, 194, 136);

  // State Colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFFC107);

  // Accent Colors
  static const Color accentColorLight = Color(0xFF00BCD4);
  static const Color accentColorDark = Color(0xFF0288D1);

  // Disabled Colors
  static const Color disabledColorLight = Color(0xFFE0E0E0);
  static const Color disabledColorDark = Color(0xFF616161);

  // Divider and Border Colors
  static const Color dividerColor = Color(0xFFBDBDBD);
  static const Color borderColor = Color(0xFF9E9E9E);

  // Shadow Color
  static  Color shadowColor = Color(0xFF000000).withOpacity(0.25);

  // Gradient Colors
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFFB1FF84), Color(0xFFB8B7BC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const List<Color> secondaryGradient = [
    Color(0xFFB8B7BC),
    Color(0xFFE0E0E0),
  ];

  // Overlay Colors
  static const Color overlayLight = Color(0x80FFFFFF);
  static const Color overlayDark = Color(0x80000000);

  // Accessibility Colors
  static const Color highContrastText = Color(0xFF212121);
  static const Color highContrastBackground = Color(0xFFF5F5F5);
}

