import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/reports/reports_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileYearSelector extends GetView<ReportsControllerImpl> {
  const MobileYearSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportsControllerImpl>(
      builder:
          (controller) => Container(
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
                  'اختر السنة للتقرير',
                  style: DesignTokens.getHeadlineMedium(context).copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: DesignTokens.spacing12),

                // Year selection buttons
                Wrap(
                  spacing: DesignTokens.spacing8,
                  runSpacing: DesignTokens.spacing8,
                  children: List.generate(5, (index) {
                    final year = DateTime.now().year - index;
                    final isSelected = controller.selectedDate.year == year;

                    return SizedBox(
                      height: DesignTokens.minTouchTarget,
                      child: ElevatedButton(
                        onPressed: () => controller.setYear(year),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isSelected
                                  ? AppColors.primary
                                  : AppColors.surfaceVariant,
                          foregroundColor:
                              isSelected
                                  ? AppColors.white
                                  : AppColors.textSecondary,
                          elevation: isSelected ? 2 : 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: DesignTokens.borderRadiusSmall,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: DesignTokens.spacing16,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected) ...[
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: AppColors.white,
                              ),
                              const SizedBox(width: DesignTokens.spacing4),
                            ],
                            Text(
                              year.toString(),
                              style: DesignTokens.getBodyMedium(
                                context,
                              ).copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: DesignTokens.spacing12),

                // Custom year input
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'أدخل سنة مخصصة',
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: AppColors.textSecondary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: DesignTokens.borderRadiusSmall,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: DesignTokens.spacing12,
                            vertical: DesignTokens.spacing8,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          final year = int.tryParse(value);
                          if (year != null &&
                              year >= 2000 &&
                              year <= DateTime.now().year + 1) {
                            controller.setYear(year);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing8),
                    SizedBox(
                      height: DesignTokens.minTouchTarget,
                      child: ElevatedButton(
                        onPressed: () {
                          // Show year picker dialog
                          showDialog(
                            context: context,
                            builder:
                                (context) => _buildYearPickerDialog(context),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: DesignTokens.borderRadiusSmall,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: DesignTokens.spacing12,
                          ),
                        ),
                        child: Icon(Icons.more_horiz),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildYearPickerDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: DesignTokens.borderRadiusMedium,
      ),
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing20),
        constraints: const BoxConstraints(maxHeight: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'اختر السنة',
              style: DesignTokens.getHeadlineMedium(context).copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: DesignTokens.spacing16),

            Expanded(
              child: ListView.builder(
                itemCount: 25, // Last 25 years
                itemBuilder: (context, index) {
                  final year = DateTime.now().year - index;
                  return ListTile(
                    title: Text(
                      year.toString(),
                      style: DesignTokens.getBodyLarge(context),
                    ),
                    leading: Icon(
                      Icons.calendar_today,
                      color: AppColors.primary,
                    ),
                    onTap: () {
                      controller.setYear(year);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: DesignTokens.spacing16),

            SizedBox(
              width: double.infinity,
              height: DesignTokens.minTouchTarget,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('إلغاء'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
