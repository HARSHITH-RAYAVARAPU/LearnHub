import 'package:flutter/material.dart';

/// Centralized color palette for the LearnHub design system.
/// Crafted with high-contrast, professional product aesthetics.
class AppColors {
  AppColors._();

  // Primary Brand Colors
  static const Color primary = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryDark = Color(0xFF3730A3); // Indigo 800
  static const Color primaryLight = Color(0xFFEEF2FF); // Indigo 50
  static const Color accent = Color(0xFF06B6D4); // Cyan 500

  // Badge Specific Accent Colors (Noticeable, distinct visual identity)
  static const Color badgeFreeBg = Color(0xFF059669); // Emerald 600
  static const Color badgeFreeText = Color(0xFFFFFFFF);
  static const Color badgeNewBg = Color(0xFF4F46E5); // Brand Indigo
  static const Color badgeNewText = Color(0xFFFFFFFF);
  static const Color badgeHotBg = Color(0xFFEA580C); // Orange 600
  static const Color badgeHotText = Color(0xFFFFFFFF);

  // Surface & Neutral Colors
  static const Color backgroundLight = Color(0xFFF8FAFC); // Slate 50
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF1F5F9); // Slate 100
  static const Color borderLight = Color(0xFFE2E8F0); // Slate 200
  static const Color borderSubtle = Color(0xFFCBD5E1); // Slate 300

  // Typography Tokens
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400
  static const Color textInverse = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Shadow Colors
  static final Color shadowSubtle = const Color(0xFF0F172A).withOpacity(0.06);
  static final Color shadowElevated = const Color(0xFF0F172A).withOpacity(0.12);
}
