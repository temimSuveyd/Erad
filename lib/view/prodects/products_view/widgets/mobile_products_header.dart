import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileProductsHeader extends StatelessWidget {
  const MobileProductsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(DesignTokens.radiusLarge),
          bottomRight: Radius.circular(DesignTokens.radiusLarge),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and actions row
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.white,
                        size: 20,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: DesignTokens.minTouchTarget,
                        minHeight: DesignTokens.minTouchTarget,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Add refresh functionality
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: AppColors.white,
                        size: 20,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: DesignTokens.minTouchTarget,
                        minHeight: DesignTokens.minTouchTarget,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing24),

              // Header content
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing16),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: DesignTokens.borderRadiusMedium,
                    ),
                    child: Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'المنتجات',
                          style: DesignTokens.getDisplayMedium(
                            context,
                          ).copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: DesignTokens.spacing4),
                        Text(
                          'إدارة وعرض جميع المنتجات',
                          style: DesignTokens.getBodyLarge(
                            context,
                          ).copyWith(color: AppColors.white.withOpacity(0.9)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing20),

              // Quick actions
              Row(
                children: [
                  Expanded(
                    child: _buildQuickAction(
                      context,
                      'العلامات التجارية',
                      Icons.branding_watermark_outlined,
                      () => Get.toNamed('/brands'),
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing12),
                  Expanded(
                    child: _buildQuickAction(
                      context,
                      'التصنيفات',
                      Icons.category_outlined,
                      () => Get.toNamed('/categories'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: DesignTokens.borderRadiusMedium,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.2),
          borderRadius: DesignTokens.borderRadiusMedium,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.white, size: 20),
            const SizedBox(width: DesignTokens.spacing8),
            Expanded(
              child: Text(
                title,
                style: DesignTokens.getBodyMedium(
                  context,
                ).copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
