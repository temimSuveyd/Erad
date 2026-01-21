import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/depts/customer_dept_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MonthSelectorWidget extends GetView<CustomerDeptsDetailsControllerImp> {
  const MonthSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDeptsDetailsControllerImp>(
      builder:
          (controller) => Container(
            margin: const EdgeInsets.symmetric(
              vertical: DesignTokens.spacing12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اختر الشهر',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing8),

                // إضافة زر "جميع الأشهر"
                Container(
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // زر جميع الأشهر
                        _buildMonthChip(
                          context: context,
                          monthKey: '',
                          displayName: 'جميع الأشهر',
                          isSelected: controller.selectedMonth.value.isEmpty,
                          onTap: () => controller.selectMonth(''),
                        ),
                        const SizedBox(width: DesignTokens.spacing8),

                        // أزرار الأشهر
                        ...controller.availableMonths.map(
                          (monthKey) => Padding(
                            padding: const EdgeInsets.only(
                              right: DesignTokens.spacing8,
                            ),
                            child: _buildMonthChip(
                              context: context,
                              monthKey: monthKey,
                              displayName: controller.getMonthDisplayName(
                                monthKey,
                              ),
                              isSelected:
                                  controller.selectedMonth.value == monthKey,
                              onTap: () => controller.selectMonth(monthKey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildMonthChip({
    required BuildContext context,
    required String monthKey,
    required String displayName,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing16,
          vertical: DesignTokens.spacing8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grey,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          displayName,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
