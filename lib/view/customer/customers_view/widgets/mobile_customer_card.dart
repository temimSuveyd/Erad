import 'package:erad/data/model/customers/customers_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/customers_view/customers_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileCustomerCard extends GetView<CustomersControllerImp> {
  const MobileCustomerCard({super.key, required this.customerModel});

  final CustomersModel customerModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: DesignTokens.spacing8,
        horizontal: DesignTokens.spacing16,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: DesignTokens.borderRadiusMedium,
        border: Border.all(
          color: AppColors.border,
          width: DesignTokens.borderWidthThin,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textLight.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: DesignTokens.borderRadiusMedium,
          onTap: () {
            // Navigate to customer details if needed
          },
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row: Customer Name and Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customerModel.customer_name ?? 'غير محدد',
                            style: DesignTokens.getHeadlineMedium(
                              context,
                            ).copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacing8,
                        vertical: DesignTokens.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 14,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: DesignTokens.spacing4),
                          Text(
                            'نشط',
                            style: DesignTokens.getBodySmall(context).copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing12),

                // Contact Information

                // Row(
                //   children: [
                //     Icon(
                //       Icons.phone_outlined,
                //       size: 16,
                //       color: AppColors.textSecondary,
                //     ),
                //     const SizedBox(width: DesignTokens.spacing4),
                //     Text(
                //       customerModel.customer_phone!,
                //       style: DesignTokens.getBodyMedium(context).copyWith(
                //         color: AppColors.textSecondary,
                //       ),
                //     ),
                //   ],
                // ),

                // if (customerModel.customer_phone != null)
                // const SizedBox(height: DesignTokens.spacing8),

                // Location Information
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: DesignTokens.spacing4),
                    Text(
                      customerModel.customer_city ?? 'غير محدد',
                      style: DesignTokens.getBodyMedium(
                        context,
                      ).copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing16),

                // Divider
                Container(height: 1, color: AppColors.borderLight),

                const SizedBox(height: DesignTokens.spacing12),

                // Action Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: DesignTokens.minTouchTarget,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            controller.show_edit_dialog(customerModel);
                          },
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: Text(
                            'تعديل',
                            style: DesignTokens.getBodyMedium(
                              context,
                            ).copyWith(fontWeight: FontWeight.w500),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: BorderSide(
                              color: AppColors.primary,
                              width: DesignTokens.borderWidthThin,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: DesignTokens.borderRadiusSmall,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: DesignTokens.spacing12),

                    Expanded(
                      child: SizedBox(
                        height: DesignTokens.minTouchTarget,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            controller.show_delete_dialog(
                              customerModel.customer_id!,
                            );
                          },
                          icon: const Icon(Icons.delete_outline, size: 18),
                          label: Text(
                            'حذف',
                            style: DesignTokens.getBodyMedium(
                              context,
                            ).copyWith(fontWeight: FontWeight.w500),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: BorderSide(
                              color: AppColors.error,
                              width: DesignTokens.borderWidthThin,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: DesignTokens.borderRadiusSmall,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
