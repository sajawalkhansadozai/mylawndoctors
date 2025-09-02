import 'package:flutter/material.dart';

// Brand colors
const kGreen = Color(0xFF4CAF50);
const kGreenDark = Color(0xFF45A049);
const kForest = Color(0xFF2D5016);
const kBlue = Color(0xFF1A4C96);

const kBrandGradient = LinearGradient(
  colors: [kForest, kGreen, kGreenDark],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kHeroGradient = LinearGradient(
  colors: [kBlue, kForest, kGreen, kGreenDark],
  stops: [0.0, 0.3, 0.7, 1.0],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Arial',
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF9FFFB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE8F5E8), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kGreen, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: const Color(0xFF333333),
      displayColor: const Color(0xFF333333),
    ),
  );
}
