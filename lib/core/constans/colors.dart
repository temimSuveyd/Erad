import 'package:flutter/material.dart';

class AppColors {
  // ============================================
  // PRIMARY COLORS - Blue Theme
  // ============================================
  static const Color primary = Color(0xFF2563EB); // Clean blue
  static const Color primaryLight = Color(0xFF60A5FA); // Light blue
  static const Color primaryDark = Color(0xFF1D4ED8); // Dark blue
  static const Color primaryLighter = Color(0xFFDBeafe); // Very light blue

  // ============================================
  // BACKGROUND COLORS
  // ============================================
  static const Color white = Color(0xFFFFFFFF); // Pure white
  static const Color background = Color(0xFFF8FAFC); // Very light blue-gray
  static const Color surface = Color(0xFFFFFFFF); // White surface
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Light gray surface

  // ============================================
  // TEXT COLORS
  // ============================================
  static const Color textPrimary = Color(0xFF1E293B); // Dark blue-gray
  static const Color textSecondary = Color(0xFF64748B); // Medium blue-gray
  static const Color textLight = Color(0xFF94A3B8); // Light blue-gray
  static const Color textDisabled = Color(0xFFCBD5E1); // Very light gray

  // ============================================
  // BORDER COLORS
  // ============================================
  static const Color border = Color(0xFFE2E8F0); // Light gray border
  static const Color borderLight = Color(0xFFF1F5F9); // Very light border
  static const Color borderDark = Color(0xFFCBD5E1); // Medium gray border

  // ============================================
  // SEMANTIC COLORS
  // ============================================
  static const Color success = Color(0xFF10B981); // Green
  static const Color successLight = Color(0xFFD1FAE5); // Light green
  static const Color warning = Color(0xFFF59E0B); // Orange
  static const Color warningLight = Color(0xFFFEF3C7); // Light orange
  static const Color error = Color(0xFFEF4444); // Red
  static const Color errorLight = Color(0xFFFEE2E2); // Light red
  static const Color info = Color(0xFF3B82F6); // Blue
  static const Color infoLight = Color(0xFFDBEAFE); // Light blue

  // ============================================
  // OVERLAY COLORS
  // ============================================
  static const Color overlay = Color(0x80000000); // 50% black
  static const Color overlayLight = Color(0x40000000); // 25% black
  static const Color overlayDark = Color(0xB3000000); // 70% black

  // ============================================
  // GRADIENT COLORS
  // ============================================
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [warning, Color(0xFFFBBF24)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [error, Color(0xFFF87171)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============================================
  // LEGACY COLORS (for backward compatibility)
  // ============================================
  static const Color wihet = white;
  static const Color grey = textSecondary;
  static const Color green = success;
  static const Color black = textPrimary;
  static const Color red = error;
  static const Color backgroundColor = background;

  // ============================================
  // HELPER METHODS
  // ============================================
  
  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  /// Get hover color (slightly darker)
  static Color getHoverColor(Color color) {
    return Color.lerp(color, Colors.black, 0.1) ?? color;
  }

  /// Get pressed color (darker)
  static Color getPressedColor(Color color) {
    return Color.lerp(color, Colors.black, 0.2) ?? color;
  }

  /// Get disabled color
  static Color getDisabledColor(Color color) {
    return withOpacity(color, 0.4);
  }
}
