import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'screens/portfolio_screen.dart';
import 'widgets/splash_screen.dart';

final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
  ThemeMode.dark,
);

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        if (mode == ThemeMode.light) {
          AppColors.applyLight();
        } else {
          AppColors.applyDark();
        }

        return MaterialApp(
          title: 'Ismail — Flutter Developer',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          home: const SplashScreen(child: PortfolioScreen()),
        );
      },
    );
  }
}
