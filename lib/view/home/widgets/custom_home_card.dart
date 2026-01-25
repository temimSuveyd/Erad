import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:erad/controller/home/home_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/widgets/safe_image.dart';
import 'package:erad/data/model/home/home_modle.dart';

class Custom_home_card extends GetView<HomeControllerImp> {
  const Custom_home_card({super.key, required this.homeModle});

  final HomeModle homeModle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        controller.goToPage(homeModle.pageName!);
      },
      splashColor: AppColors.primary.withOpacity(0.1),
      highlightColor: AppColors.primary.withOpacity(0.05),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.cardGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            AppShadows.medium,
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon container with better design
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppGradients.primaryGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  AppShadows.small,
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: (homeModle.imagePath ?? '').toSafeImage(
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                fallbackIcon: _getDefaultIconForPage(homeModle.pageName ?? ''),
                fallbackColor: AppColors.white,
                iconSize: 60,
              ),
            ),
            
            // Title with better styling
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                homeModle.title ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            
            // Subtle indicator
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 8, bottom: 16),
              decoration: BoxDecoration(
                gradient: AppGradients.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper method to provide default icons based on page name
  IconData _getDefaultIconForPage(String pageName) {
    switch (pageName.toLowerCase()) {
      case 'customers':
        return Icons.group;
      case 'suppliers':
        return Icons.local_shipping;
      case 'products':
        return Icons.inventory;
      case 'reports':
        return Icons.bar_chart;
      case 'expenses':
        return Icons.account_balance_wallet;
      case 'withdrawn_funds':
        return Icons.money_off;
      default:
        return Icons.apps;
    }
  }
}
