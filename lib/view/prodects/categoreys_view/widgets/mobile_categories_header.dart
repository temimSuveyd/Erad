import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/categoreys/categorey_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileCategoriesHeader extends GetView<CategoreyControllerImp> {
  const MobileCategoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoreyControllerImp>(
      builder:
          (controller) => Container(
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
                            onPressed: () => controller.getCategoreys(),
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
                        const SizedBox(width: DesignTokens.spacing8),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.2),
                            borderRadius: DesignTokens.borderRadiusSmall,
                          ),
                          child: IconButton(
                            onPressed: () => controller.show_dialog(),
                            icon: Icon(
                              Icons.add,
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
                            Icons.category_outlined,
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
                                'التصنيفات',
                                style: DesignTokens.getDisplayMedium(
                                  context,
                                ).copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: DesignTokens.spacing4),
                              Text(
                                'إدارة وتنظيم تصنيفات المنتجات',
                                style: DesignTokens.getBodyLarge(
                                  context,
                                ).copyWith(
                                  color: AppColors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: DesignTokens.spacing20),

                    // Statistics card
                    _buildStatisticsCard(context),

                    const SizedBox(height: DesignTokens.spacing16),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildStatisticsCard(BuildContext context) {
    final totalCategories = controller.categoreys_list.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.2),
        borderRadius: DesignTokens.borderRadiusMedium,
      ),
      child: Row(
        children: [
          Icon(Icons.folder_outlined, color: AppColors.white, size: 24),
          const SizedBox(width: DesignTokens.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إجمالي التصنيفات',
                  style: DesignTokens.getBodyMedium(
                    context,
                  ).copyWith(color: AppColors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Text(
                  '$totalCategories تصنيف',
                  style: DesignTokens.getHeadlineMedium(context).copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
