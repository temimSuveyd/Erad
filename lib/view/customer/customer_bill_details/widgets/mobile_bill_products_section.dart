import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_bill_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/core/class/handling_data.dart';

class MobileBillProductsSection
    extends GetView<CustomerBillDetailsControllerImp> {
  const MobileBillProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerBillDetailsControllerImp>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(DesignTokens.spacing20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: DesignTokens.borderRadiusLarge,
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section title
              Row(
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: DesignTokens.spacing8),
                  Text(
                    'المنتجات',
                    style: DesignTokens.getHeadlineMedium(context).copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing20),

              // Products list
              if (controller.statusreqest == Statusreqest.loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(DesignTokens.spacing32),
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                )
              else if (controller.statusreqest == Statusreqest.empty ||
                  controller.productList.isEmpty)
                _buildEmptyState(context)
              else
                Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.productList.length,
                    separatorBuilder:
                        (context, index) =>
                            const SizedBox(height: DesignTokens.spacing12),
                    itemBuilder: (context, index) {
                      final product = controller.productList[index];
                      return _buildProductCard(context, product, controller);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing32),
      child: Column(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: DesignTokens.spacing16),
          Text(
            'لا توجد منتجات في هذه الفاتورة',
            style: DesignTokens.getBodyLarge(
              context,
            ).copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    dynamic product,
    CustomerBillDetailsControllerImp controller,
  ) {
    final productData = product as Map<String, dynamic>;
    final productName = productData['product_name']?.toString() ?? '';
    final productNumber = productData['product_number']?.toString() ?? '0';
    final productPrice = productData['product_price']?.toString() ?? '0';
    final totalPrice = productData['total_product_price']?.toString() ?? '0';
    final productId = product['id'];

    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: DesignTokens.borderRadiusMedium,
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name and actions
          Row(
            children: [
              Expanded(
                child: Text(
                  productName,
                  style: DesignTokens.getBodyLarge(context).copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => controller.editProductData(productId),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing8),
                  GestureDetector(
                    onTap:
                        () => controller.show_delete_product_dialog(productId),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: AppColors.error,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing12),

          // Product details
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  context,
                  'الكمية',
                  productNumber,
                  Icons.numbers,
                ),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: _buildDetailItem(
                  context,
                  'السعر',
                  '$productPrice د.ع',
                  Icons.attach_money,
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing12),

          // Total price
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(DesignTokens.spacing12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: DesignTokens.borderRadiusSmall,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الإجمالي',
                  style: DesignTokens.getBodyMedium(context).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$totalPrice د.ع',
                  style: DesignTokens.getBodyLarge(context).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: DesignTokens.borderRadiusSmall,
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.textSecondary, size: 16),
              const SizedBox(width: DesignTokens.spacing4),
              Text(
                label,
                style: DesignTokens.getBodySmall(
                  context,
                ).copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing4),
          Text(
            value,
            style: DesignTokens.getBodyMedium(context).copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
