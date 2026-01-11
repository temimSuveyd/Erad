import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/depts/customer_dept_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/show_date_range_picker.dart';

class MobileDateFilterSection
    extends GetView<CustomerDeptsDetailsControllerImp> {
  const MobileDateFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          // Section header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing8),
                decoration: BoxDecoration(
                  color: AppColors.infoLight,
                  borderRadius: DesignTokens.borderRadiusSmall,
                ),
                child: Icon(
                  Icons.date_range_outlined,
                  color: AppColors.info,
                  size: 20,
                ),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Text(
                'فلترة بالتاريخ',
                style: DesignTokens.getHeadlineMedium(context).copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing16),

          // Date range picker
          GetBuilder<CustomerDeptsDetailsControllerImp>(
            builder:
                (controller) => GestureDetector(
                  onTap: () {
                    show_date_range_picker(context).then((dateRange) {
                      if (dateRange != null) {
                        controller.setDateRenage(dateRange);
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(DesignTokens.spacing16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: DesignTokens.borderRadiusSmall,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        const SizedBox(width: DesignTokens.spacing12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'نطاق التاريخ',
                                style: DesignTokens.getBodySmall(
                                  context,
                                ).copyWith(color: AppColors.textSecondary),
                              ),
                              const SizedBox(height: DesignTokens.spacing4),
                              Text(
                                _getDateRangeText(controller),
                                style: DesignTokens.getBodyLarge(
                                  context,
                                ).copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
          ),

          const SizedBox(height: DesignTokens.spacing12),

          // Quick date filters
          Wrap(
            spacing: DesignTokens.spacing8,
            runSpacing: DesignTokens.spacing8,
            children: [
              _buildQuickFilterChip(
                context,
                'هذا الشهر',
                () => _setCurrentMonth(),
              ),
              _buildQuickFilterChip(
                context,
                'الشهر الماضي',
                () => _setLastMonth(),
              ),
              _buildQuickFilterChip(
                context,
                'آخر 3 أشهر',
                () => _setLast3Months(),
              ),
              _buildQuickFilterChip(
                context,
                'هذا العام',
                () => _setCurrentYear(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilterChip(
    BuildContext context,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing12,
          vertical: DesignTokens.spacing8,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryLighter,
          borderRadius: DesignTokens.borderRadiusSmall,
          border: Border.all(color: AppColors.primary),
        ),
        child: Text(
          label,
          style: DesignTokens.getBodySmall(
            context,
          ).copyWith(color: AppColors.primary, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  String _getDateRangeText(CustomerDeptsDetailsControllerImp controller) {
    final range = controller.selectedDateRange ?? controller.startedDateRange;
    if (range == null) return 'اختر نطاق التاريخ';

    return "${range.start.day}/${range.start.month}/${range.start.year} - ${range.end.day}/${range.end.month}/${range.end.year}";
  }

  void _setCurrentMonth() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 0);
    controller.setDateRenage(DateTimeRange(start: start, end: end));
  }

  void _setLastMonth() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month - 1, 1);
    final end = DateTime(now.year, now.month, 0);
    controller.setDateRenage(DateTimeRange(start: start, end: end));
  }

  void _setLast3Months() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month - 3, 1);
    final end = now;
    controller.setDateRenage(DateTimeRange(start: start, end: end));
  }

  void _setCurrentYear() {
    final now = DateTime.now();
    final start = DateTime(now.year, 1, 1);
    final end = DateTime(now.year, 12, 31);
    controller.setDateRenage(DateTimeRange(start: start, end: end));
  }
}
