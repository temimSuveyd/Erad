import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/withdrawn_funds/withdrawn_funds_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/withdrawn_fund/withdrawn_fund_card_model.dart';
import 'package:intl/intl.dart';

class MobileWithdrawnFundsCard extends GetView<WithdrawnFundsControllerImp> {
  const MobileWithdrawnFundsCard({
    super.key,
    required this.withdrawnFundCardModel,
  });

  final WithdrawnFundCardModel withdrawnFundCardModel;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy', 'ar');

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
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Amount and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مبلغ السحب',
                        style: DesignTokens.getBodySmall(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: DesignTokens.spacing4),
                      Text(
                        '${withdrawnFundCardModel.amount?.toStringAsFixed(0) ?? '0'} د.ع',
                        style: DesignTokens.getHeadlineLarge(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing12,
                    vertical: DesignTokens.spacing6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        withdrawnFundCardModel.isRepeatWithdrawnFund == true
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        withdrawnFundCardModel.isRepeatWithdrawnFund == true
                            ? Icons.repeat
                            : Icons.repeat_one,
                        color:
                            withdrawnFundCardModel.isRepeatWithdrawnFund == true
                                ? AppColors.success
                                : AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: DesignTokens.spacing4),
                      Text(
                        withdrawnFundCardModel.isRepeatWithdrawnFund == true
                            ? 'متكرر'
                            : 'مرة واحدة',
                        style: DesignTokens.getBodySmall(context).copyWith(
                          color:
                              withdrawnFundCardModel.isRepeatWithdrawnFund ==
                                      true
                                  ? AppColors.success
                                  : AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: DesignTokens.spacing16),

            // Date information
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: DesignTokens.spacing8),
                Text(
                  'تاريخ السحب: ',
                  style: DesignTokens.getBodyMedium(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),
                Text(
                  withdrawnFundCardModel.date != null
                      ? dateFormat.format(withdrawnFundCardModel.date!)
                      : 'غير محدد',
                  style: DesignTokens.getBodyMedium(context).copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            // Repeat date if applicable
            if (withdrawnFundCardModel.isRepeatWithdrawnFund == true &&
                withdrawnFundCardModel.repeatDate != null) ...[
              const SizedBox(height: DesignTokens.spacing8),
              Row(
                children: [
                  Icon(Icons.event_repeat, color: AppColors.success, size: 16),
                  const SizedBox(width: DesignTokens.spacing8),
                  Text(
                    'تاريخ التكرار: ',
                    style: DesignTokens.getBodyMedium(
                      context,
                    ).copyWith(color: AppColors.textSecondary),
                  ),
                  Text(
                    dateFormat.format(withdrawnFundCardModel.repeatDate!),
                    style: DesignTokens.getBodyMedium(context).copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: DesignTokens.spacing16),

            // Divider
            Container(height: 1, color: AppColors.borderLight),

            const SizedBox(height: DesignTokens.spacing12),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    'تعديل',
                    Icons.edit_outlined,
                    AppColors.primary,
                    () => controller.showEditDialog(
                      withdrawnFundCardModel.amount ?? 0.0,
                      withdrawnFundCardModel.date ?? DateTime.now(),
                      withdrawnFundCardModel.isRepeatWithdrawnFund ?? false,
                      withdrawnFundCardModel.repeatDate ?? DateTime.now(),
                      withdrawnFundCardModel.id ?? "",
                    ),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing8),
                Expanded(
                  child: _buildActionButton(
                    context,
                    'حذف',
                    Icons.delete_outline,
                    AppColors.error,
                    () =>
                        controller.showDeleteDialog(withdrawnFundCardModel.id!),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing12,
          vertical: DesignTokens.spacing8,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: DesignTokens.borderRadiusSmall,
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: DesignTokens.spacing6),
            Text(
              title,
              style: DesignTokens.getBodyMedium(
                context,
              ).copyWith(color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
