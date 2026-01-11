import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/withdrawn_funds/withdrawn_funds_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileWithdrawnFundsHeader extends GetView<WithdrawnFundsControllerImp> {
  const MobileWithdrawnFundsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawnFundsControllerImp>(
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
                            color: AppColors.white.withValues(alpha: 0.2),
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
                            color: AppColors.white.withValues(alpha: 0.2),
                            borderRadius: DesignTokens.borderRadiusSmall,
                          ),
                          child: IconButton(
                            onPressed: () => controller.setDateRange(),
                            icon: Icon(
                              Icons.date_range,
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
                            color: AppColors.white.withValues(alpha: 0.2),
                            borderRadius: DesignTokens.borderRadiusSmall,
                          ),
                          child: IconButton(
                            onPressed: () => controller.getWithdrawnFunds(),
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
                            color: AppColors.white.withValues(alpha: 0.2),
                            borderRadius: DesignTokens.borderRadiusMedium,
                          ),
                          child: Icon(
                            Icons.account_balance_wallet_outlined,
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
                                'الأموال المسحوبة',
                                style: DesignTokens.getDisplayMedium(
                                  context,
                                ).copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: DesignTokens.spacing4),
                              Text(
                                'متابعة وإدارة المصروفات اليومية',
                                style: DesignTokens.getBodyLarge(
                                  context,
                                ).copyWith(
                                  color: AppColors.white.withValues(alpha: 0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: DesignTokens.spacing20),

                    // Statistics and add button
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'عدد العمليات',
                            '${controller.withdrawnFundsList.length}',
                            Icons.receipt_long_outlined,
                          ),
                        ),
                        const SizedBox(width: DesignTokens.spacing12),
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'إجمالي المبلغ',
                            '${controller.withdrawnFundsTotalAmount.toStringAsFixed(0)} د.ع',
                            Icons.payments_outlined,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: DesignTokens.spacing16),

                    // Add button
                    SizedBox(
                      width: double.infinity,
                      height: DesignTokens.minTouchTarget,
                      child: ElevatedButton.icon(
                        onPressed:
                            () => controller.showaddWithdrawnFundsDialog(),
                        icon: Icon(Icons.add, size: 20),
                        label: Text(
                          'إضافة سحب جديد',
                          style: DesignTokens.getBodyLarge(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: DesignTokens.borderRadiusMedium,
                          ),
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

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.2),
        borderRadius: DesignTokens.borderRadiusMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.white, size: 20),
              const SizedBox(width: DesignTokens.spacing8),
              Expanded(
                child: Text(
                  label,
                  style: DesignTokens.getBodyMedium(
                    context,
                  ).copyWith(color: AppColors.white.withValues(alpha: 0.9)),
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            value,
            style: DesignTokens.getHeadlineMedium(
              context,
            ).copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
