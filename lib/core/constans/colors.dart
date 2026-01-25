import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF2563EB); // Modern blue
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);
  
  // Neutral colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  
  // Text colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  
  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Accent colors
  static const Color accent = Color(0xFF8B5CF6);
  static const Color accentLight = Color(0xFFA78BFA);
  
  // Shadows and overlays
  static const Color shadow = Color(0xFF0F172A);
  static const Color overlay = Color(0x80000000);
  
  // Deprecated - for backward compatibility
  static const Color wihet = white;
  static const Color grey = textSecondary;
  static const Color green = success;
  static const Color black = textPrimary;
  static const Color red = error;
  static const Color backgroundColor = background;
}

// Theme extensions for better organization
class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppColors.primary, AppColors.primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [AppColors.surface, AppColors.surfaceVariant],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppShadows {
  static final BoxShadow small = BoxShadow(
    color: AppColors.shadow.withOpacity(0.05),
    blurRadius: 4,
    offset: const Offset(0, 2),
  );
  
  static final BoxShadow medium = BoxShadow(
    color: AppColors.shadow.withOpacity(0.1),
    blurRadius: 8,
    offset: const Offset(0, 4),
  );
  
  static final BoxShadow large = BoxShadow(
    color: AppColors.shadow.withOpacity(0.15),
    blurRadius: 16,
    offset: const Offset(0, 8),
  );
}
