import 'package:flutter/material.dart';

/// Design tokens for the application
/// Following mobile-first responsive design principles
class DesignTokens {
  // ============================================
  // BREAKPOINTS
  // ============================================
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  // ============================================
  // SPACING
  // ============================================
  static const double spacingMobile = 16;
  static const double spacingTablet = 24;
  static const double spacingDesktop = 32;

  // Common spacing values
  static const double spacing4 = 4;
  static const double spacing6 = 6;
  static const double spacing8 = 8;
  static const double spacing12 = 12;
  static const double spacing16 = 16;
  static const double spacing20 = 20;
  static const double spacing24 = 24;
  static const double spacing28 = 28;
  static const double spacing32 = 32;
  static const double spacing40 = 40;
  static const double spacing48 = 48;

  // ============================================
  // BORDER RADIUS
  // ============================================
  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusXLarge = 20;

  // BorderRadius objects for convenience
  static BorderRadius get borderRadiusSmall =>
      BorderRadius.circular(radiusSmall);
  static BorderRadius get borderRadiusMedium =>
      BorderRadius.circular(radiusMedium);
  static BorderRadius get borderRadiusLarge =>
      BorderRadius.circular(radiusLarge);
  static BorderRadius get borderRadiusXLarge =>
      BorderRadius.circular(radiusXLarge);

  // ============================================
  // ELEVATION (Minimal shadows)
  // ============================================
  static const double elevationNone = 0;
  static const double elevationMinimal = 0.5;
  static const double elevationLow = 1;
  static const double elevationMedium = 2;
  static const double elevationHigh = 4;

  // ============================================
  // ANIMATION DURATIONS
  // ============================================
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 400);

  // ============================================
  // TYPOGRAPHY SCALE
  // ============================================
  // Mobile base: 14px, Desktop base: 16px
  static double getBaseFontSize(BuildContext context) {
    return isDesktop(context) ? 16 : 14;
  }

  static double getFontSize(BuildContext context, double scale) {
    return getBaseFontSize(context) * scale;
  }

  // Font sizes (relative to base)
  static const double fontScaleXSmall = 0.75; // 10.5px mobile, 12px desktop
  static const double fontScaleSmall = 0.875; // 12.25px mobile, 14px desktop
  static const double fontScaleBase = 1.0; // 14px mobile, 16px desktop
  static const double fontScaleMedium = 1.125; // 15.75px mobile, 18px desktop
  static const double fontScaleLarge = 1.25; // 17.5px mobile, 20px desktop
  static const double fontScaleXLarge = 1.5; // 21px mobile, 24px desktop
  static const double fontScaleXXLarge = 2.0; // 28px mobile, 32px desktop

  // ============================================
  // TOUCH TARGETS
  // ============================================
  static const double minTouchTarget = 44;

  // ============================================
  // BORDER WIDTH
  // ============================================
  static const double borderWidthThin = 1;
  static const double borderWidthMedium = 1.2;
  static const double borderWidthThick = 2;

  // ============================================
  // RESPONSIVE HELPERS
  // ============================================
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  static double getResponsiveSpacing(BuildContext context) {
    if (isDesktop(context)) return spacingDesktop;
    if (isTablet(context)) return spacingTablet;
    return spacingMobile;
  }

  static int getGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 4; // Desktop large
    if (width >= tabletBreakpoint) return 3; // Desktop/Tablet
    if (width >= mobileBreakpoint) return 2; // Tablet small
    return 2; // Mobile
  }

  // ============================================
  // TEXT STYLES
  // ============================================
  static TextStyle getDisplayLarge(BuildContext context) {
    return TextStyle(
      fontSize: getFontSize(context, fontScaleXXLarge),
      fontWeight: FontWeight.bold,
      height: 1.2,
    );
  }

  static TextStyle getDisplayMedium(BuildContext context) {
    return TextStyle(
      fontSize: getFontSize(context, fontScaleXLarge),
      fontWeight: FontWeight.bold,
      height: 1.2,
    );
  }

  static TextStyle getHeadlineLarge(BuildContext context) {
    return TextStyle(
      fontSize: getFontSize(context, fontScaleLarge),
      fontWeight: FontWeight.w600,
      height: 1.3,
    );
  }

  static TextStyle getHeadlineMedium(BuildContext context) {
    return TextStyle(
      fontSize: getFontSize(context, fontScaleMedium),
      fontWeight: FontWeight.w600,
      height: 1.3,
    );
  }

  static TextStyle getBodyLarge(BuildContext context) {
    return TextStyle(
      fontSize: getFontSize(context, fontScaleBase),
      fontWeight: FontWeight.normal,
      height: 1.5,
    );
  }

  static TextStyle getBodyMedium(BuildContext context) {
    return TextStyle(
      fontSize: getFontSize(context, fontScaleSmall),
      fontWeight: FontWeight.normal,
      height: 1.5,
    );
  }

  static TextStyle getBodySmall(BuildContext context) {
    return TextStyle(
      fontSize: getFontSize(context, fontScaleXSmall),
      fontWeight: FontWeight.normal,
      height: 1.5,
    );
  }
}
