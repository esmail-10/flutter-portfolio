import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primarySoft,
        surface: AppColors.card,
        onSurface: AppColors.textPrimary,
        onPrimary: AppColors.textOnPrimary,
        error: AppColors.danger,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      dividerColor: AppColors.border,
      splashFactory: InkRipple.splashFactory,
      splashColor: AppColors.primary.withValues(alpha: 0.08),
      highlightColor: AppColors.primary.withValues(alpha: 0.04),
    );
  }

  static const double maxContentWidth = 1200;
  static const Duration fastDuration = Duration(milliseconds: 250);
  static const Duration mediumDuration = Duration(milliseconds: 450);
  static const Duration slowDuration = Duration(milliseconds: 700);
  static const Curve defaultCurve = Curves.easeOutCubic;
}
