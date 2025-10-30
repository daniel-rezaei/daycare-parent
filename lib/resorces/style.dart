import 'package:flutter/material.dart';

class AppTypography {
  static TextTheme textTheme = const TextTheme(
    // Headings
    displayLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w600,fontFamily: 'Inter'), // h1
    displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,fontFamily: 'Inter'), // h2
    displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600,fontFamily: 'Inter'), // h3
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,fontFamily: 'Inter'), // h4

    // Titles
    titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,fontFamily: 'Inter'), // Title-L
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,fontFamily: 'Inter'), // Title-M

    // Body
    bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,fontFamily: 'Inter'), // Body-L
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,fontFamily: 'Inter'), // Body-M
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal,fontFamily: 'Inter'), // small

    // Buttons
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,fontFamily: 'Inter'), // Button-L
    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,fontFamily: 'Inter'), // Button-M

    // Extra styles
    titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic,fontFamily: 'Inter'), // blockquote
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,fontFamily: 'Inter'), // table head
  ).apply(
    fontFamily: "Inter",
  );

  static const TextStyle titleSmallSemiBold = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle semiBold = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle semiBold20 = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static const TextStyle semiBold14 = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static const TextStyle largeB = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static const TextStyle mB = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );
  static const TextStyle medium = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}