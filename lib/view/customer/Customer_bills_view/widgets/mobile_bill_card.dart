import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_bill_view_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/customer_bills_view/bill_model.dart';
import 'package:erad/view/custom_widgets/custom_bill_status_dialog.dart';

class MobileBillCard extends GetView<CustomerBillViewControllerImp> {
  const MobileBillCard({super.key, required this.billModel});

  final BillModel billModel;

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
          onTap: () => controller.goToDetailsPage(billModel.bill_id!),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row: Customer Name and Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        billModel.customer_name ?? 'غير محدد',
                        style: DesignTokens.getHeadlineMedium(context).copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacing12,
                        vertical: DesignTokens.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLighter,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Text(
                        '${billModel.total_price ?? 0}',
                        style: DesignTokens.getHeadlineMedium(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing12),

                // Secondary Information Row
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: DesignTokens.spacing4),
                    Text(
                      billModel.customer_city ?? 'غير محدد',
                      style: DesignTokens.getBodyMedium(
                        context,
                      ).copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: DesignTokens.spacing16),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: DesignTokens.spacing4),
                    Text(
                      billModel.bill_date != null
                          ? "${billModel.bill_date!.day}/${billModel.bill_date!.month}/${billModel.bill_date!.year}"
                          : 'غير محدد',
                      style: DesignTokens.getBodyMedium(
                        context,
                      ).copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing8),

                // Payment Type Row
                Row(
                  children: [
                    Icon(
                      billModel.payment_type == "Religion"
                          ? Icons.schedule_outlined
                          : Icons.payments_outlined,
                      size: 16,
                      color:
                          billModel.payment_type == "Religion"
                              ? AppColors.warning
                              : AppColors.success,
                    ),
                    const SizedBox(width: DesignTokens.spacing4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacing8,
                        vertical: DesignTokens.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            billModel.payment_type == "Religion"
                                ? AppColors.warningLight
                                : AppColors.successLight,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Text(
                        billModel.payment_type == "Religion" ? "دِين" : "نقدي",
                        style: DesignTokens.getBodySmall(context).copyWith(
                          color:
                              billModel.payment_type == "Religion"
                                  ? AppColors.warning
                                  : AppColors.success,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                        child: ElevatedButton.icon(
                          onPressed:
                              () => controller.goToDetailsPage(
                                billModel.bill_id!,
                              ),
                          icon: const Icon(Icons.visibility_outlined, size: 18),
                          label: Text(
                            'تفاصيل',
                            style: DesignTokens.getBodyMedium(
                              context,
                            ).copyWith(fontWeight: FontWeight.w500),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            elevation: 0,
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
                            custom_bill_status_dialog(billModel.bill_status!, (
                              value,
                            ) {
                              controller.updateBillStaus(
                                value,
                                billModel.bill_id!,
                                billModel,
                              );
                            });
                          },
                          icon: Icon(
                            _getStatusIcon(billModel.bill_status),
                            size: 18,
                          ),
                          label: Text(
                            _getStatusText(billModel.bill_status),
                            style: DesignTokens.getBodyMedium(
                              context,
                            ).copyWith(fontWeight: FontWeight.w500),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _getStatusColor(
                              billModel.bill_status,
                            ),
                            side: BorderSide(
                              color: _getStatusColor(billModel.bill_status),
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

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle_outline;
      case 'pending':
        return Icons.schedule_outlined;
      case 'cancelled':
        return Icons.cancel_outlined;
      default:
        return Icons.help_outline;
    }
  }

  String _getStatusText(String? status) {
    switch (status) {
      case 'completed':
        return 'مكتملة';
      case 'pending':
        return 'معلقة';
      case 'cancelled':
        return 'ملغية';
      default:
        return 'حالة';
    }
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'completed':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }
}
