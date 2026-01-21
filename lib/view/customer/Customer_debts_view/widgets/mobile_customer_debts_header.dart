import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/depts/customer_depts_view_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileCustomerDebtsHeader
    extends GetView<CustomerDeptsViewControllerImp> {
  const MobileCustomerDebtsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDeptsViewControllerImp>(
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
                            onPressed: () => controller.getDepts(),
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
                                'ديون العملاء',
                                style: DesignTokens.getDisplayMedium(
                                  context,
                                ).copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: DesignTokens.spacing4),
                              Text(
                                'متابعة وإدارة المبالغ المستحقة',
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

                    // Statistics cards
                    _buildStatisticsCards(context),

                    const SizedBox(height: DesignTokens.spacing16),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildStatisticsCards(BuildContext context) {
    // Calculate statistics
    final totalDebts = controller.customersDeptsList.length;
    final totalAmount = controller.customersDeptsList.fold<double>(0.0, (
      sum,
      debt,
    ) {
      final data = debt as Map<String, dynamic>;
      return sum + (data['dept_amount']?.toDouble() ?? 0.0);
    });

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            'عدد الديون',
            '$totalDebts',
            Icons.receipt_long_outlined,
            AppColors.white.withValues(alpha: 0.2),
          ),
        ),
        const SizedBox(width: DesignTokens.spacing12),
        Expanded(
          child: _buildStatCard(
            context,
            'إجمالي المبلغ',
            '${totalAmount.toStringAsFixed(0)} د.ع',
            Icons.payments_outlined,
            AppColors.white.withValues(alpha: 0.2),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color backgroundColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: backgroundColor,
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
