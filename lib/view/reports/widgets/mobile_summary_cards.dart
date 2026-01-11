import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:erad/controller/reports/reports_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileSummaryCards extends GetView<ReportsControllerImpl> {
  const MobileSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportsControllerImpl>(
      builder:
          (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ملخص مالي',
                style: DesignTokens.getHeadlineLarge(context).copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: DesignTokens.spacing16),

              // Main financial cards
              _buildMainCard(
                context,
                'صافي الأرباح',
                controller.cardsList.isNotEmpty ? controller.cardsList[0] : 0.0,
                Icons.trending_up,
                AppColors.success,
                'الأرباح بعد خصم المصاريف',
              ),

              const SizedBox(height: DesignTokens.spacing12),

              // Secondary cards in grid
              Row(
                children: [
                  Expanded(
                    child: _buildSecondaryCard(
                      context,
                      'ديون العملاء',
                      controller.cardsList.length > 2
                          ? controller.cardsList[2]
                          : 0.0,
                      Icons.account_balance_wallet_outlined,
                      AppColors.warning,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing12),
                  Expanded(
                    child: _buildSecondaryCard(
                      context,
                      'ديون الموردين',
                      controller.cardsList.length > 1
                          ? controller.cardsList[1]
                          : 0.0,
                      Icons.business_outlined,
                      AppColors.error,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing12),

              Row(
                children: [
                  Expanded(
                    child: _buildSecondaryCard(
                      context,
                      'إجمالي المصاريف',
                      controller.cardsList.length > 3
                          ? controller.cardsList[3]
                          : 0.0,
                      Icons.receipt_long_outlined,
                      AppColors.info,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing12),
                  Expanded(
                    child: _buildSecondaryCard(
                      context,
                      'المبالغ المسحوبة',
                      controller.cardsList.length > 4
                          ? controller.cardsList[4]
                          : 0.0,
                      Icons.money_off_outlined,
                      AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing16),

              // Net profit toggle
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  color: AppColors.infoLight,
                  borderRadius: DesignTokens.borderRadiusMedium,
                  border: Border.all(
                    color: AppColors.info.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.info, size: 20),
                    const SizedBox(width: DesignTokens.spacing8),
                    Expanded(
                      child: Text(
                        'احتساب صافي الأرباح',
                        style: DesignTokens.getBodyMedium(context).copyWith(
                          color: AppColors.info,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Switch(
                      value: controller.includeDebts,
                      onChanged: (value) => controller.debtCheckChanged(),
                      activeThumbColor: AppColors.info,
                      activeTrackColor: AppColors.info.withValues(alpha: 0.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildMainCard(
    BuildContext context,
    String title,
    double value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withValues(alpha: 0.8)],
        ),
        borderRadius: DesignTokens.borderRadiusMedium,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing8),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  borderRadius: DesignTokens.borderRadiusSmall,
                ),
                child: Icon(icon, color: AppColors.white, size: 24),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: DesignTokens.getHeadlineMedium(context).copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: DesignTokens.getBodyMedium(
                        context,
                      ).copyWith(color: AppColors.white.withValues(alpha: 0.9)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing16),

          Text(
            NumberFormat("#,##0", "ar").format(value),
            style: DesignTokens.getDisplayLarge(
              context,
            ).copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryCard(
    BuildContext context,
    String title,
    double value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: DesignTokens.borderRadiusSmall,
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: DesignTokens.spacing8),
              Expanded(
                child: Text(
                  title,
                  style: DesignTokens.getBodyMedium(context).copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing8),

          Text(
            NumberFormat("#,##0", "ar").format(value),
            style: DesignTokens.getHeadlineMedium(
              context,
            ).copyWith(color: color, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
