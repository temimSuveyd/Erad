import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_add_bill_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/core/class/handling_data.dart';

class MobileBillActions extends GetView<CustomerBiilAddControllerImp> {
  const MobileBillActions({super.key});

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
                // Section header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLighter,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Icon(
                        Icons.settings_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Text(
                      'إجراءات الفاتورة',
                      style: DesignTokens.getHeadlineMedium(context).copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing20),

                // Action buttons
                if (controller.statusreqest == Statusreqest.loading)
                  _buildLoadingState(context)
                else
                  _buildActionButtons(context),
              ],
            ),
          ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignTokens.spacing24),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: DesignTokens.borderRadiusSmall,
      ),
      child: Column(
        children: [
          CircularProgressIndicator(color: AppColors.primary, strokeWidth: 3),
          const SizedBox(height: DesignTokens.spacing16),
          Text(
            'جاري معالجة الفاتورة...',
            style: DesignTokens.getBodyLarge(context).copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            'يرجى الانتظار',
            style: DesignTokens.getBodyMedium(
              context,
            ).copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Primary actions row
        Row(
          children: [
            // Save button
            if (!controller.is_saved)
              Expanded(
                child: _buildActionButton(
                  context,
                  label: 'حفظ الفاتورة',
                  icon: Icons.save_outlined,
                  onPressed:
                      _canSave() ? () => controller.saveBillData() : null,
                  backgroundColor: AppColors.success,
                  foregroundColor: AppColors.white,
                ),
              ),
            // const SizedBox(width: DesignTokens.spacing12),
            // // Print button
            // Expanded(
            //   child: _buildActionButton(
            //     context,
            //     label: 'طباعة',
            //     icon: Icons.print_outlined,
            //     onPressed: _canPrint() ? () => controller.printPdf() : null,
            //     backgroundColor: AppColors.primary,
            //     foregroundColor: AppColors.white,
            //   ),
            // ),
          ],
        ),

        const SizedBox(height: DesignTokens.spacing12),

        // Secondary actions row
        Row(
          children: [
            // // Create PDF button
            // Expanded(
            //   child: _buildActionButton(
            //     context,
            //     label: 'إنشاء PDF',
            //     icon: Icons.picture_as_pdf_outlined,
            //     onPressed:
            //         controller.is_saved ? () => controller.createPdf() : null,
            //     backgroundColor: AppColors.info,
            //     foregroundColor: AppColors.white,
            //   ),
            // ),
            // const SizedBox(width: DesignTokens.spacing12),
            // // Delete button
            // Expanded(
            //   child: _buildActionButton(
            //     context,
            //     label: 'حذف',
            //     icon: Icons.delete_outline,
            //     onPressed: () => controller.showDleteBillDialog(),
            //     backgroundColor: AppColors.error,
            //     foregroundColor: AppColors.white,
            //   ),
            // ),
          ],
        ),

        const SizedBox(height: DesignTokens.spacing20),

        // Status indicator
        _buildStatusIndicator(context),

        const SizedBox(height: DesignTokens.spacing16),

        // Validation messages
        if (!_canSave()) _buildValidationMessages(context),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    final isEnabled = onPressed != null;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: DesignTokens.getBodyMedium(
          context,
        ).copyWith(fontWeight: FontWeight.w500),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isEnabled
                ? backgroundColor
                : AppColors.getDisabledColor(backgroundColor),
        foregroundColor: isEnabled ? foregroundColor : AppColors.textDisabled,
        padding: const EdgeInsets.symmetric(
          vertical: DesignTokens.spacing12,
          horizontal: DesignTokens.spacing16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.borderRadiusSmall,
        ),
        elevation: isEnabled ? DesignTokens.elevationLow : 0,
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    final isSaved = controller.is_saved;
    final statusColor = isSaved ? AppColors.success : AppColors.warning;
    final statusBgColor =
        isSaved ? AppColors.successLight : AppColors.warningLight;
    final statusIcon =
        isSaved ? Icons.check_circle_outline : Icons.pending_outlined;
    final statusText = isSaved ? 'تم حفظ الفاتورة' : 'لم يتم حفظ الفاتورة';
    final statusSubtext =
        isSaved
            ? 'يمكنك الآن طباعة الفاتورة أو إنشاء PDF'
            : 'احفظ الفاتورة أولاً للوصول لجميع الخيارات';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: statusBgColor,
        borderRadius: DesignTokens.borderRadiusSmall,
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: DesignTokens.borderWidthThin,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              borderRadius: DesignTokens.borderRadiusSmall,
            ),
            child: Icon(statusIcon, color: statusColor, size: 20),
          ),
          const SizedBox(width: DesignTokens.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: DesignTokens.getBodyMedium(
                    context,
                  ).copyWith(color: statusColor, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Text(
                  statusSubtext,
                  style: DesignTokens.getBodySmall(
                    context,
                  ).copyWith(color: statusColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationMessages(BuildContext context) {
    final messages = <String>[];

    if (controller.customer_name == null) {
      messages.add('يجب اختيار العميل');
    }
    if (controller.bill_payment_type == null) {
      messages.add('يجب اختيار طريقة الدفع');
    }
    if (controller.bill_prodects_list.isEmpty) {
      messages.add('يجب إضافة منتج واحد على الأقل');
    }

    if (messages.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: DesignTokens.borderRadiusSmall,
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.3),
          width: DesignTokens.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: AppColors.error, size: 20),
              const SizedBox(width: DesignTokens.spacing8),
              Text(
                'يجب إكمال البيانات التالية:',
                style: DesignTokens.getBodyMedium(
                  context,
                ).copyWith(color: AppColors.error, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing8),
          ...messages.map(
            (message) => Padding(
              padding: const EdgeInsets.only(
                left: DesignTokens.spacing28,
                bottom: DesignTokens.spacing4,
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing8),
                  Text(
                    message,
                    style: DesignTokens.getBodySmall(
                      context,
                    ).copyWith(color: AppColors.error),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _canSave() {
    return controller.customer_name != null &&
        controller.bill_payment_type != null &&
        controller.bill_prodects_list.isNotEmpty;
  }

  bool _canPrint() {
    return _canSave() || controller.is_saved;
  }
}
