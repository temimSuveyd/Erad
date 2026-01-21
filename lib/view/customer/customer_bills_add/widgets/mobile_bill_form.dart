import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_add_bill_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';

class MobileBillForm extends GetView<CustomerBiilAddControllerImp> {
  const MobileBillForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerBiilAddControllerImp>(
      builder:
          (controller) => Container(
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
                // Section title
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLighter,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Icon(
                        Icons.edit_document,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Text(
                      'بيانات الفاتورة',
                      style: DesignTokens.getHeadlineMedium(context).copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing20),

                // Customer selection
                _buildFormField(
                  context,
                  'العميل',
                  Icons.person_outline,
                  CustomDropDownButton(
                    items: controller.customers_list_dropdownItrm,
                    onChanged: (value) => controller.setCustomer(value),
                    hint: controller.customer_name ?? "اختر العميل",
                    value: "",
                  ),
                ),

                const SizedBox(height: DesignTokens.spacing16),

                // Date selection
                _buildFormField(
                  context,
                  'تاريخ الفاتورة',
                  Icons.calendar_today_outlined,
                  GestureDetector(
                    onTap: () => _showDatePicker(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacing16,
                        vertical: DesignTokens.spacing12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(width: DesignTokens.spacing8),
                          Expanded(
                            child: Text(
                              "${controller.bill_add_date.day}/${controller.bill_add_date.month}/${controller.bill_add_date.year}",
                              style: DesignTokens.getBodyLarge(
                                context,
                              ).copyWith(color: AppColors.textPrimary),
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

                const SizedBox(height: DesignTokens.spacing16),

                // Payment type selection
                _buildFormField(
                  context,
                  'طريقة الدفع',
                  Icons.payment_outlined,
                  CustomDropDownButton(
                    items: [
                      DropdownMenuItem(
                        value: "Religion",
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule_outlined,
                              color: AppColors.warning,
                              size: 16,
                            ),
                            const SizedBox(width: DesignTokens.spacing8),
                            Text("دَين"),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "monetary",
                        child: Row(
                          children: [
                            Icon(
                              Icons.payments_outlined,
                              color: AppColors.success,
                              size: 16,
                            ),
                            const SizedBox(width: DesignTokens.spacing8),
                            Text("نقدي"),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) => controller.setPaymentType(value),
                    hint: "اختر طريقة الدفع",
                    value: controller.bill_payment_type ?? "",
                  ),
                ),

                const SizedBox(height: DesignTokens.spacing16),

                // Payment status indicator
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing12),
                  decoration: BoxDecoration(
                    color:
                        controller.bill_payment_type == "Religion"
                            ? AppColors.warningLight
                            : AppColors.successLight,
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        controller.bill_payment_type == "Religion"
                            ? Icons.schedule_outlined
                            : Icons.check_circle_outline,
                        color:
                            controller.bill_payment_type == "Religion"
                                ? AppColors.warning
                                : AppColors.success,
                        size: 20,
                      ),
                      const SizedBox(width: DesignTokens.spacing8),
                      Expanded(
                        child: Text(
                          controller.bill_payment_type == "Religion"
                              ? 'سيتم إضافة هذا المبلغ إلى ديون العميل'
                              : 'سيتم تحصيل المبلغ نقداً',
                          style: DesignTokens.getBodyMedium(context).copyWith(
                            color:
                                controller.bill_payment_type == "Religion"
                                    ? AppColors.warning
                                    : AppColors.success,
                            fontWeight: FontWeight.w500,
                          ),
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

  Widget _buildFormField(
    BuildContext context,
    String label,
    IconData icon,
    Widget field,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 16),
            const SizedBox(width: DesignTokens.spacing8),
            Text(
              label,
              style: DesignTokens.getBodyLarge(context).copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: DesignTokens.spacing8),
        field,
      ],
    );
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: controller.bill_add_date,
      firstDate: DateTime(2026),
      lastDate: DateTime(2050),
      // locale: const Locale('ar'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    ).then((date) {
      if (date != null) {
        controller.setBillDate(date);
      }
    });
  }
}
