import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/withdrawn_funds/withdrawn_funds_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:intl/intl.dart';

class MobileWithdrawnFundsSummary extends GetView<WithdrawnFundsControllerImp> {
  const MobileWithdrawnFundsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawnFundsControllerImp>(
      builder:
          (controller) => Container(
            width: double.infinity,
            padding: const EdgeInsets.all(DesignTokens.spacing20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: DesignTokens.borderRadiusMedium,
              border: Border.all(
                color: AppColors.border,
                width: DesignTokens.borderWidthThin,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLighter,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Icon(
                        Icons.analytics_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Text(
                      'ملخص الفترة',
                      style: DesignTokens.getHeadlineMedium(context).copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing20),

                // Date range
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLighter,
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الفترة المحددة',
                        style: DesignTokens.getBodySmall(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacing8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.primary,
                            size: 16,
                          ),
                          const SizedBox(width: DesignTokens.spacing8),
                          Text(
                            '${DateFormat('dd/MM/yyyy').format(controller.pickedDateRange.start)} - ${DateFormat('dd/MM/yyyy').format(controller.pickedDateRange.end)}',
                            style: DesignTokens.getBodyLarge(context).copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: DesignTokens.spacing20),

                // Summary cards
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        context,
                        'عدد العمليات',
                        '${controller.withdrawnFundsList.length}',
                        Icons.receipt_long_outlined,
                        AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: _buildSummaryCard(
                        context,
                        'متوسط السحب',
                        controller.withdrawnFundsList.isNotEmpty
                            ? '${(controller.withdrawnFundsTotalAmount / controller.withdrawnFundsList.length).toStringAsFixed(0)} د.ع'
                            : '0 د.ع',
                        Icons.trending_up_outlined,
                        AppColors.success,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing16),

                // Total amount card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(DesignTokens.spacing20),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: DesignTokens.borderRadiusMedium,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            color: AppColors.white,
                            size: 24,
                          ),
                          const SizedBox(width: DesignTokens.spacing12),
                          Text(
                            'إجمالي الأموال المسحوبة',
                            style: DesignTokens.getBodyLarge(context).copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: DesignTokens.spacing12),
                      Text(
                        '${controller.withdrawnFundsTotalAmount.toStringAsFixed(0)} د.ع',
                        style: DesignTokens.getDisplayMedium(context).copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: DesignTokens.spacing16),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        context,
                        'تغيير الفترة',
                        Icons.date_range_outlined,
                        () => controller.setDateRange(),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: _buildActionButton(
                        context,
                        'تحديث البيانات',
                        Icons.refresh_outlined,
                        () => controller.getWithdrawnFunds(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: DesignTokens.borderRadiusMedium,
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            label,
            style: DesignTokens.getBodySmall(
              context,
            ).copyWith(color: color, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: DesignTokens.spacing4),
          Text(
            value,
            style: DesignTokens.getHeadlineMedium(
              context,
            ).copyWith(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(DesignTokens.spacing12),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: DesignTokens.borderRadiusSmall,
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(width: DesignTokens.spacing8),
            Text(
              title,
              style: DesignTokens.getBodyMedium(
                context,
              ).copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
