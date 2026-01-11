import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/reports/reports_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileReportsHeader extends GetView<ReportsControllerImpl> {
  const MobileReportsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing16,
        vertical: DesignTokens.spacing16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: DesignTokens.borderRadiusMedium,
                  ),
                  child: Icon(
                    Icons.analytics_outlined,
                    color: AppColors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'التقارير السنوية',
                        style: DesignTokens.getDisplayMedium(context).copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacing4),
                      Text(
                        'تحليل شامل للأداء المالي',
                        style: DesignTokens.getBodyLarge(context).copyWith(
                          color: AppColors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: DesignTokens.spacing20),

            // Quick stats row
            GetBuilder<ReportsControllerImpl>(
              builder:
                  (controller) => Row(
                    children: [
                      Expanded(
                        child: _buildQuickStat(
                          context,
                          'إجمالي الأرباح',
                          '${controller.cardsList.isNotEmpty ? controller.cardsList[0] : 0}',
                          Icons.trending_up,
                          AppColors.success,
                        ),
                      ),
                      const SizedBox(width: DesignTokens.spacing12),
                      Expanded(
                        child: _buildQuickStat(
                          context,
                          'إجمالي المصاريف',
                          '${controller.cardsList.length > 3 ? controller.cardsList[3] : 0}',
                          Icons.trending_down,
                          AppColors.error,
                        ),
                      ),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.15),
        borderRadius: DesignTokens.borderRadiusSmall,
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: DesignTokens.spacing4),
              Expanded(
                child: Text(
                  label,
                  style: DesignTokens.getBodySmall(
                    context,
                  ).copyWith(color: AppColors.white.withValues(alpha: 0.9)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing4),
          Text(
            value,
            style: DesignTokens.getHeadlineMedium(
              context,
            ).copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
