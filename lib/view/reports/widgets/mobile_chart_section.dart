import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:erad/controller/reports/reports_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileChartSection extends GetView<ReportsControllerImpl> {
  const MobileChartSection({super.key});

  static const List<String> arabicMonths = [
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportsControllerImpl>(
      builder:
          (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'التحليل الشهري',
                style: DesignTokens.getHeadlineLarge(context).copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: DesignTokens.spacing12),

              // Scroll hint for mobile charts
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacing12,
                  vertical: DesignTokens.spacing8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: DesignTokens.borderRadiusSmall,
                  border: Border.all(
                    color: AppColors.info.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.swipe_left, color: AppColors.info, size: 16),
                    const SizedBox(width: DesignTokens.spacing8),
                    Expanded(
                      child: Text(
                        'اسحب الرسوم البيانية يميناً ويساراً لعرض جميع الأشهر بوضوح',
                        style: DesignTokens.getBodySmall(context).copyWith(
                          color: AppColors.info,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: DesignTokens.spacing16),

              // Main earnings chart
              _buildChartCard(
                context,
                'إجمالي الأرباح الشهرية',
                controller.totalEraningsMonthly,
                AppColors.success,
                Icons.trending_up,
              ),

              const SizedBox(height: DesignTokens.spacing16),

              // Expenses chart
              if (controller.chartsLists.isNotEmpty)
                _buildChartCard(
                  context,
                  'إجمالي المصاريف الشهرية',
                  controller.chartsLists[0],
                  AppColors.error,
                  Icons.trending_down,
                ),

              const SizedBox(height: DesignTokens.spacing16),

              // Withdrawn funds chart
              if (controller.chartsLists.length > 1)
                _buildChartCard(
                  context,
                  'المبالغ المسحوبة الشهرية',
                  controller.chartsLists[1],
                  AppColors.warning,
                  Icons.money_off,
                ),
            ],
          ),
    );
  }

  Widget _buildChartCard(
    BuildContext context,
    String title,
    List data,
    Color color,
    IconData icon,
  ) {
    final maxAmount =
        data.isNotEmpty
            ? data
                .map((e) => (e['amount'] ?? 0) as num)
                .reduce((a, b) => a > b ? a : b)
            : 1;
    final safeMax = maxAmount == 0 ? 1 : maxAmount;

    return Container(
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
          // Chart header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: DesignTokens.borderRadiusSmall,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: Text(
                  title,
                  style: DesignTokens.getHeadlineMedium(context).copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing20),

          // Chart area - Fixed height to prevent overflow
          Container(
            height: 240, // Fixed height
            width: double.infinity,
            child:
                data.isEmpty
                    ? _buildEmptyState(context, color)
                    : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 2.0,
                        padding: const EdgeInsets.all(DesignTokens.spacing12),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.05),
                          borderRadius: DesignTokens.borderRadiusSmall,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(12, (i) {
                            final monthIndex = i + 1;
                            final item = data.firstWhere(
                              (e) => e["index"] == monthIndex,
                              orElse: () => null,
                            );
                            final amount =
                                item != null ? (item["amount"] ?? 0) as num : 0;

                            final double minBarHeight = 8;
                            final double maxBarHeight = 140;
                            final double barHeight =
                                amount > 0
                                    ? ((amount / safeMax) *
                                            (maxBarHeight - minBarHeight)) +
                                        minBarHeight
                                    : minBarHeight;

                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Amount label
                                    if (amount > 0)
                                      Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 4,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Text(
                                          NumberFormat.compact(
                                            locale: "ar",
                                          ).format(amount),
                                          style: DesignTokens.getBodySmall(
                                            context,
                                          ).copyWith(
                                            color: color,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                    // Bar
                                    GestureDetector(
                                      onTap:
                                          () => _showMonthDetails(
                                            context,
                                            monthIndex,
                                            amount,
                                            color,
                                          ),
                                      child: Container(
                                        height: barHeight,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              color,
                                              color.withValues(alpha: 0.7),
                                            ],
                                          ),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(4),
                                                bottom: Radius.circular(2),
                                              ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: color.withValues(
                                                alpha: 0.3,
                                              ),
                                              blurRadius: 3,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    // Month label
                                    Text(
                                      arabicMonths[monthIndex],
                                      style: DesignTokens.getBodySmall(
                                        context,
                                      ).copyWith(
                                        color: AppColors.textSecondary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
          ),

          const SizedBox(height: DesignTokens.spacing12),

          // Total for the year
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: DesignTokens.borderRadiusSmall,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الإجمالي السنوي:',
                  style: DesignTokens.getBodyMedium(context).copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  NumberFormat("#,##0", "ar").format(
                    data.fold<num>(
                      0,
                      (sum, item) => sum + (item['amount'] ?? 0),
                    ),
                  ),
                  style: DesignTokens.getHeadlineMedium(
                    context,
                  ).copyWith(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: DesignTokens.borderRadiusSmall,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bar_chart_outlined, color: color, size: 48),
            ),
            const SizedBox(height: DesignTokens.spacing16),
            Text(
              'لا توجد بيانات لعرضها',
              style: DesignTokens.getHeadlineMedium(
                context,
              ).copyWith(color: color, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: DesignTokens.spacing8),
            Text(
              'سيتم عرض البيانات هنا عند توفرها',
              style: DesignTokens.getBodyMedium(
                context,
              ).copyWith(color: AppColors.textLight),
            ),
          ],
        ),
      ),
    );
  }

  void _showMonthDetails(
    BuildContext context,
    int month,
    num amount,
    Color color,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: DesignTokens.borderRadiusMedium,
            ),
            child: Container(
              padding: const EdgeInsets.all(DesignTokens.spacing20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.bar_chart, color: color, size: 32),
                  ),

                  const SizedBox(height: DesignTokens.spacing16),

                  Text(
                    'تفاصيل شهر ${arabicMonths[month]}',
                    style: DesignTokens.getHeadlineMedium(context).copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: DesignTokens.spacing16),

                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing16),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المبلغ:',
                          style: DesignTokens.getBodyLarge(
                            context,
                          ).copyWith(color: AppColors.textPrimary),
                        ),
                        Text(
                          NumberFormat("#,##0", "ar").format(amount),
                          style: DesignTokens.getHeadlineMedium(
                            context,
                          ).copyWith(color: color, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: DesignTokens.spacing20),

                  SizedBox(
                    width: double.infinity,
                    height: DesignTokens.minTouchTarget,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('إغلاق'),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
