import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const String name = 'Ismail';
  static const String fullName = 'Ismail';
  static const String role = 'Flutter Developer';
  static const String tagline =
      'Flutter Developer passionate about building clean, modern and '
      'scalable mobile applications with beautiful user experiences.';

  static const String location = 'Egypt';
  static const String displayPhone = '+20 100 240 5175';
  static const String whatsappNumber = '+201002405175';
  static const String email = 'esmailmhmd63@gmail.com';
  static const String githubUrl = 'https://github.com/esmail-10';
  static const String githubDisplay = 'github.com/esmail-10';
  static const String facebookUrl = 'https://www.facebook.com/esmail.mhmd.2025';
  static const String facebookDisplay = 'facebook.com/esmail.mhmd.2025';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/esmail-mhmd-9405b63ab';
  static const String linkedinDisplay = 'linkedin.com/in/esmail-mhmd-9405b63ab';
  static const String portfolioUrl = 'https://ismail-mhmd.vercel.app';
  static const String portfolioDisplay = 'ismail-mhmd.vercel.app';
  static const String cvUrl =
      'https://drive.google.com/file/d/1OvyzIOoyN1_01aBnbePPc1YkHhoKvsKb/view?usp=drive_link';

  static const String tajhizGitHubUrl =
      'https://github.com/esmail-10/tajheez-flutter';
  static const String foodyGitHubUrl = 'https://github.com/esmail-10/foody';
  static const String portfolioGitHubUrl =
      'https://github.com/esmail-10/flutter-portfolio';
  static const String profilePhotoAsset =
      'assets/images/profile/profile_photo.jpg';

  static const List<String> navItems = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Contact',
  ];
}

class AppColors {
  AppColors._();

  static Color background = _light.background;
  static Color secondaryBackground = _light.secondaryBackground;
  static Color card = _light.card;
  static Color cardHover = _light.cardHover;

  static Color primary = _light.primary;
  static Color primaryDark = _light.primaryDark;
  static Color primarySoft = _light.primarySoft;

  static Color textPrimary = _light.textPrimary;
  static Color textSecondary = _light.textSecondary;
  static Color textMuted = _light.textMuted;

  static Color border = _light.border;
  static Color borderHover = _light.borderHover;

  static Color success = _light.success;
  static Color warning = _light.warning;
  static Color danger = _light.danger;

  static Color textOnPrimary = _light.textOnPrimary;

  static LinearGradient primaryGradient = _light.primaryGradient;
  static LinearGradient cardGradient = _light.cardGradient;

  static const _AppPalette _light = _AppPalette(
    background: Color(0xFFF8FAFC),
    secondaryBackground: Color(0xFFF1F5F9),
    card: Color(0xFFFFFFFF),
    cardHover: Color(0xFFE2E8F0),
    primary: Color(0xFF0891B2),
    primaryDark: Color(0xFF0E7490),
    primarySoft: Color(0xFF06B6D4),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF94A3B8),
    border: Color(0xFFE2E8F0),
    borderHover: Color(0xFFCBD5E1),
    success: Color(0xFF10B981),
    warning: Color(0xFFF59E0B),
    danger: Color(0xFFEF4444),
    textOnPrimary: Color(0xFFFFFFFF),
    primaryGradient: LinearGradient(
      colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardGradient: LinearGradient(
      colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static const _AppPalette _dark = _AppPalette(
    background: Color(0xFF0B0F19),
    secondaryBackground: Color(0xFF111827),
    card: Color(0xFF151B2B),
    cardHover: Color(0xFF1B2338),
    primary: Color(0xFF22D3EE),
    primaryDark: Color(0xFF0E7490),
    primarySoft: Color(0xFF67E8F9),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    textMuted: Color(0xFF64748B),
    border: Color(0xFF1E293B),
    borderHover: Color(0xFF334155),
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    danger: Color(0xFFF87171),
    textOnPrimary: Color(0xFF0B0F19),
    primaryGradient: LinearGradient(
      colors: [Color(0xFF22D3EE), Color(0xFF3B82F6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardGradient: LinearGradient(
      colors: [Color(0xFF151B2B), Color(0xFF111827)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static void applyLight() {
    background = _light.background;
    secondaryBackground = _light.secondaryBackground;
    card = _light.card;
    cardHover = _light.cardHover;
    primary = _light.primary;
    primaryDark = _light.primaryDark;
    primarySoft = _light.primarySoft;
    textPrimary = _light.textPrimary;
    textSecondary = _light.textSecondary;
    textMuted = _light.textMuted;
    border = _light.border;
    borderHover = _light.borderHover;
    success = _light.success;
    warning = _light.warning;
    danger = _light.danger;
    textOnPrimary = _light.textOnPrimary;
    primaryGradient = _light.primaryGradient;
    cardGradient = _light.cardGradient;
  }

  static void applyDark() {
    background = _dark.background;
    secondaryBackground = _dark.secondaryBackground;
    card = _dark.card;
    cardHover = _dark.cardHover;
    primary = _dark.primary;
    primaryDark = _dark.primaryDark;
    primarySoft = _dark.primarySoft;
    textPrimary = _dark.textPrimary;
    textSecondary = _dark.textSecondary;
    textMuted = _dark.textMuted;
    border = _dark.border;
    borderHover = _dark.borderHover;
    success = _dark.success;
    warning = _dark.warning;
    danger = _dark.danger;
    textOnPrimary = _dark.textOnPrimary;
    primaryGradient = _dark.primaryGradient;
    cardGradient = _dark.cardGradient;
  }
}

class _AppPalette {
  final Color background;
  final Color secondaryBackground;
  final Color card;
  final Color cardHover;
  final Color primary;
  final Color primaryDark;
  final Color primarySoft;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color borderHover;
  final Color success;
  final Color warning;
  final Color danger;
  final Color textOnPrimary;
  final LinearGradient primaryGradient;
  final LinearGradient cardGradient;

  const _AppPalette({
    required this.background,
    required this.secondaryBackground,
    required this.card,
    required this.cardHover,
    required this.primary,
    required this.primaryDark,
    required this.primarySoft,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.borderHover,
    required this.success,
    required this.warning,
    required this.danger,
    required this.textOnPrimary,
    required this.primaryGradient,
    required this.cardGradient,
  });
}
