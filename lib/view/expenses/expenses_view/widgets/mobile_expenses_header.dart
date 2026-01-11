import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/expenses/expenses_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileExpensesHeader extends GetView<ExpensesControllerImp> {
  const MobileExpensesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpensesControllerImp>(
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
                            onPressed: () => controller.getExpenses(),
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
                            onPressed: () => controller.showaddExpensesDialog(),
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
                            Icons.receipt_long_outlined,
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
                                'النفقات',
                                style: DesignTokens.getDisplayMedium(
                                  context,
                                ).copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: DesignTokens.spacing4),
                              Text(
                                'متابعة وإدارة المصروفات',
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

                    // Date range selector
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(DesignTokens.spacing16),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        borderRadius: DesignTokens.borderRadiusMedium,
                      ),
                      child: InkWell(
                        onTap: () => controller.setDateRange(),
                        borderRadius: DesignTokens.borderRadiusMedium,
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: AppColors.white,
                              size: 20,
                            ),
                            const SizedBox(width: DesignTokens.spacing12),
                            Expanded(
                              child: Text(
                                'اختيار فترة زمنية',
                                style: DesignTokens.getBodyLarge(
                                  context,
                                ).copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: DesignTokens.spacing16),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
