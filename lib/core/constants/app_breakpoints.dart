import 'package:flutter/material.dart';

/// Screen size breakpoints & layout calculation utilities.
/// Supports Mobile (< 650px), Tablet (650px - 1080px), and Desktop (>= 1080px).
class AppBreakpoints {
  AppBreakpoints._();

  static const double mobileMax = 650.0;
  static const double tabletMax = 1080.0;
  static const double maxContentWidth = 1320.0;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileMax && width < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  /// Returns optimal grid column count for course cards based on available viewport width.
  static int getGridColumnCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 650) {
      return 1; // Single column on phones for comfortable reading
    } else if (width < 950) {
      return 2; // 2 columns on small tablets
    } else if (width < 1250) {
      return 3; // 3 columns on large tablets / laptops
    } else {
      return 4; // 4 columns on large desktop monitors
    }
  }

  /// Horizontal padding based on screen size
  static double getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileMax) {
      return 16.0;
    } else if (width < tabletMax) {
      return 24.0;
    } else {
      return 36.0;
    }
  }
}
