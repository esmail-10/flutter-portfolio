import 'package:flutter/material.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  static const double mobile = 640;
  static const double tablet = 900;
  static const double desktop = 1100;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobile && width < tablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tablet;

  static double contentMaxWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1440) return 1280;
    if (width >= 1200) return 1160;
    return width;
  }

  static double horizontalPadding(BuildContext context) {
    if (isMobile(context)) return 20;
    if (isTablet(context)) return 40;
    return 64;
  }

  static double sectionVerticalPadding(BuildContext context) {
    if (isMobile(context)) return 64;
    if (isTablet(context)) return 88;
    return 112;
  }

  static int gridColumns(BuildContext context, {required int max}) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return 1;
    if (width < 900) return 2;
    if (width < 1200) return 3;
    return max;
  }
}
