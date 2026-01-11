import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:erad/controller/reports/reports_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileDetailedStats extends GetView<ReportsControllerImpl> {
  const MobileDetailedStats({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportsControllerImpl>(
      builder:
          (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إحصائيات تفصيلية',
                style: DesignTokens.getHeadlineLarge(context).copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: DesignTokens.spacing16),

              // Performance indicators
              _buildPerformanceCard(context, controller),

              const SizedBox(height: DesignTokens.spacing16),

              // Monthly comparison
              _buildMonthlyComparison(context, controller),

              const SizedBox(height: DesignTokens.spacing16),

              // Financial ratios
              _buildFinancialRatios(context, controller),

              const SizedBox(height: DesignTokens.spacing16),

              // Export options
              _buildExportOptions(context),
            ],
          ),
    );
  }

  Widget _buildPerformanceCard(
    BuildContext context,
    ReportsControllerImpl controller,
  ) {
    final totalRevenue =
        controller.cardsList.isNotEmpty ? controller.cardsList[0] : 0.0;
    final totalExpenses =
        controller.cardsList.length > 3 ? controller.cardsList[3] : 0.0;
    final profitMargin =
        totalRevenue > 0
            ? ((totalRevenue - totalExpenses) / totalRevenue * 100)
            : 0.0;

    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.primaryLight.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: DesignTokens.borderRadiusMedium,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
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
                'مؤشرات الأداء',
                style: DesignTokens.getHeadlineMedium(context).copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing16),

          Row(
            children: [
              Expanded(
                child: _buildKPI(
                  context,
                  'هامش الربح',
                  '${profitMargin.toStringAsFixed(1)}%',
                  profitMargin >= 20
                      ? AppColors.success
                      : profitMargin >= 10
                      ? AppColors.warning
                      : AppColors.error,
                  Icons.percent,
                ),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: _buildKPI(
                  context,
                  'نسبة المصاريف',
                  totalRevenue > 0
                      ? '${(totalExpenses / totalRevenue * 100).toStringAsFixed(1)}%'
                      : '0%',
                  AppColors.info,
                  Icons.pie_chart_outline,
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing12),

          Row(
            children: [
              Expanded(
                child: _buildKPI(
                  context,
                  'متوسط شهري',
                  NumberFormat.compact(locale: "ar").format(totalRevenue / 12),
                  AppColors.primary,
                  Icons.calendar_month,
                ),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: _buildKPI(
                  context,
                  'أفضل شهر',
                  _getBestMonth(controller.totalEraningsMonthly),
                  AppColors.success,
                  Icons.star_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKPI(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: DesignTokens.borderRadiusSmall,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
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
                  ).copyWith(color: AppColors.textSecondary),
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
            ).copyWith(color: color, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyComparison(
    BuildContext context,
    ReportsControllerImpl controller,
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
          Text(
            'مقارنة شهرية',
            style: DesignTokens.getHeadlineMedium(context).copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: DesignTokens.spacing12),

          _buildComparisonRow(
            context,
            'أعلى إيرادات',
            _getHighestMonth(controller.totalEraningsMonthly),
            AppColors.success,
          ),

          const SizedBox(height: DesignTokens.spacing8),

          _buildComparisonRow(
            context,
            'أعلى مصاريف',
            controller.chartsLists.isNotEmpty
                ? _getHighestMonth(controller.chartsLists[0])
                : 'لا توجد بيانات',
            AppColors.error,
          ),

          const SizedBox(height: DesignTokens.spacing8),

          _buildComparisonRow(
            context,
            'أقل نشاط',
            _getLowestMonth(controller.totalEraningsMonthly),
            AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: DesignTokens.getBodyMedium(
            context,
          ).copyWith(color: AppColors.textSecondary),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing8,
            vertical: DesignTokens.spacing4,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: DesignTokens.borderRadiusSmall,
          ),
          child: Text(
            value,
            style: DesignTokens.getBodyMedium(
              context,
            ).copyWith(color: color, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialRatios(
    BuildContext context,
    ReportsControllerImpl controller,
  ) {
    final customerDebts =
        controller.cardsList.length > 2 ? controller.cardsList[2] : 0.0;
    final supplierDebts =
        controller.cardsList.length > 1 ? controller.cardsList[1] : 0.0;
    final netDebt = customerDebts - supplierDebts;

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
          Text(
            'النسب المالية',
            style: DesignTokens.getHeadlineMedium(context).copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: DesignTokens.spacing12),

          _buildRatioRow(
            context,
            'صافي الديون',
            NumberFormat("#,##0", "ar").format(netDebt),
            netDebt >= 0 ? AppColors.success : AppColors.error,
            netDebt >= 0 ? Icons.trending_up : Icons.trending_down,
          ),

          const SizedBox(height: DesignTokens.spacing8),

          _buildRatioRow(
            context,
            'نسبة السيولة',
            customerDebts > 0
                ? '${(supplierDebts / customerDebts * 100).toStringAsFixed(1)}%'
                : '0%',
            AppColors.info,
            Icons.water_drop_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildRatioRow(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: DesignTokens.spacing8),
        Expanded(
          child: Text(
            label,
            style: DesignTokens.getBodyMedium(
              context,
            ).copyWith(color: AppColors.textSecondary),
          ),
        ),
        Text(
          value,
          style: DesignTokens.getBodyMedium(
            context,
          ).copyWith(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildExportOptions(BuildContext context) {
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
          Text(
            'تصدير التقرير',
            style: DesignTokens.getHeadlineMedium(context).copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: DesignTokens.spacing12),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: DesignTokens.minTouchTarget,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement PDF export
                      Get.snackbar('تصدير PDF', 'سيتم إضافة هذه الميزة قريباً');
                    },
                    icon: Icon(Icons.picture_as_pdf, size: 18),
                    label: Text('PDF'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: DesignTokens.spacing8),
              Expanded(
                child: SizedBox(
                  height: DesignTokens.minTouchTarget,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement Excel export
                      Get.snackbar(
                        'تصدير Excel',
                        'سيتم إضافة هذه الميزة قريباً',
                      );
                    },
                    icon: Icon(Icons.table_chart, size: 18),
                    label: Text('Excel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getBestMonth(List data) {
    if (data.isEmpty) return 'لا توجد بيانات';

    final maxItem = data.reduce(
      (a, b) => (a['amount'] ?? 0) > (b['amount'] ?? 0) ? a : b,
    );

    const months = [
      '',
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    final monthIndex = maxItem['index'] ?? 0;
    return monthIndex > 0 && monthIndex < months.length
        ? months[monthIndex]
        : 'غير محدد';
  }

  String _getHighestMonth(List data) {
    return _getBestMonth(data);
  }

  String _getLowestMonth(List data) {
    if (data.isEmpty) return 'لا توجد بيانات';

    final minItem = data.reduce(
      (a, b) => (a['amount'] ?? 0) < (b['amount'] ?? 0) ? a : b,
    );

    const months = [
      '',
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    final monthIndex = minItem['index'] ?? 0;
    return monthIndex > 0 && monthIndex < months.length
        ? months[monthIndex]
        : 'غير محدد';
  }
}
