import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTexttheme{
  TTexttheme._();
  static TextTheme lightTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins().copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    headlineMedium: GoogleFonts.poppins().copyWith(
    fontSize: 28,
    color: Colors.black,
    fontWeight: FontWeight.w600
    ),
    headlineSmall: GoogleFonts.poppins().copyWith(
    fontSize: 24,
    color: Colors.black,
    fontWeight: FontWeight.w600
    ),
    bodyLarge:  GoogleFonts.poppins().copyWith(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w400
    ),
    bodyMedium: GoogleFonts.poppins().copyWith(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w400
    ),
  bodySmall:  GoogleFonts.poppins().copyWith(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w300
  )
  );
  static TextTheme darkTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins().copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white
    ),
    headlineMedium: GoogleFonts.poppins().copyWith(
    fontSize: 28,
    color: Colors.white,
    fontWeight: FontWeight.w600
    ),
    headlineSmall: GoogleFonts.poppins().copyWith(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.w600
    ),
    bodyLarge:  GoogleFonts.poppins().copyWith(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w600
    ),
    bodyMedium: GoogleFonts.poppins().copyWith(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w400
    ),
    bodySmall:  GoogleFonts.poppins().copyWith(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w300
  )
  );
}