import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/core/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

AppBar customHomeAppBar(BuildContext context) {
  final isMobile = DesignTokens.isMobile(context);
  
  return AppBar(
    elevation: DesignTokens.elevationLow,
    backgroundColor: AppColors.primary,
    surfaceTintColor: Colors.transparent,
    toolbarHeight: isMobile ? 60 : 70,
    title: Row(
      children: [
        // Logo and app name with animation
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: DesignTokens.durationNormal,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(isMobile ? 6 : 8),
            decoration: BoxDecoration(
              borderRadius: DesignTokens.borderRadiusSmall,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: isMobile ? 28 : 32,
                  height: isMobile ? 28 : 32,
                  child: Image.asset(AppImages.logo, fit: BoxFit.cover),
                ),
                SizedBox(width: isMobile ? 6 : 8),
                Text(
                  "اراد",
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

        // Time display with modern styling
        StreamBuilder<DateTime>(
          stream: Stream.periodic(
            const Duration(seconds: 1),
            (_) => DateTime.now(),
          ),
          builder: (context, snapshot) {
            final now = snapshot.data ?? DateTime.now();
            final formatted = DateFormat('HH:mm', 'ar').format(now);
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 10 : 12,
                vertical: isMobile ? 5 : 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.withOpacity(AppColors.white, 0.15),
                borderRadius: DesignTokens.borderRadiusSmall,
                border: Border.all(
                  color: AppColors.withOpacity(AppColors.white, 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: isMobile ? 14 : 16,
                    color: AppColors.white,
                  ),
                  SizedBox(width: isMobile ? 4 : 6),
                  Text(
                    formatted,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
