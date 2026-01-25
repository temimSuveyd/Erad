import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

/// Safe image loading widget that handles null values and errors gracefully
class SafeImage extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? fallback;
  final IconData fallbackIcon;
  final Color fallbackColor;
  final double iconSize;

  const SafeImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.fallback,
    this.fallbackIcon = Icons.image,
    this.fallbackColor = AppColors.textTertiary,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    // Handle null or empty image path
    if (imagePath == null || imagePath!.isEmpty) {
      return _buildFallback();
    }

    return Image.asset(
      imagePath!,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        // Log the error for debugging
        // print('Image loading error: $error');
        return _buildFallback();
      },
    );
  }

  Widget _buildFallback() {
    if (fallback != null) {
      return fallback!;
    }
    
    return Icon(
      fallbackIcon,
      size: iconSize,
      color: fallbackColor,
    );
  }
}

/// Extension to make Image.asset safer
extension SafeImageExtension on String {
  Widget toSafeImage({
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? fallback,
    IconData fallbackIcon = Icons.image,
    Color fallbackColor = AppColors.textTertiary,
    double iconSize = 24,
  }) {
    return SafeImage(
      imagePath: this,
      width: width,
      height: height,
      fit: fit,
      fallback: fallback,
      fallbackIcon: fallbackIcon,
      fallbackColor: fallbackColor,
      iconSize: iconSize,
    );
  }
}