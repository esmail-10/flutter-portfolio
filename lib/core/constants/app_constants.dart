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
  static const String linkedinUrl =
      'https://www.linkedin.com/in/esmail-mhmd-9405b63ab';
  static const String linkedinDisplay =
      'linkedin.com/in/esmail-mhmd-9405b63ab';
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

  static const Color background = Color(0xFF0B0F19);
  static const Color secondaryBackground = Color(0xFF111827);
  static const Color card = Color(0xFF151B2B);
  static const Color cardHover = Color(0xFF1B2338);

  static const Color primary = Color(0xFF22D3EE); // Flutter Cyan
  static const Color primaryDark = Color(0xFF0E7490);
  static const Color primarySoft = Color(0xFF67E8F9);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static const Color border = Color(0xFF1E293B);
  static const Color borderHover = Color(0xFF334155);

  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color danger = Color(0xFFF87171);

  static const Color textOnPrimary = Color(0xFF0B0F19);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF22D3EE), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF151B2B), Color(0xFF111827)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
