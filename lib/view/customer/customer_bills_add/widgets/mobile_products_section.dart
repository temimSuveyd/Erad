import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_add_bill_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileProductsSection extends GetView<CustomerBiilAddControllerImp> {
  const MobileProductsSection({super.key});

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
                        Icons.inventory_2_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: Text(
                        'المنتجات',
                        style: DesignTokens.getHeadlineMedium(context).copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
                        '${controller.bill_prodects_list.length}',
                        style: DesignTokens.getBodyMedium(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing20),

                // Product search and add section
                _buildProductAddSection(context),

                const SizedBox(height: DesignTokens.spacing20),

                // Products list
                if (controller.bill_prodects_list.isNotEmpty)
                  _buildProductsList(context)
                else
                  _buildEmptyState(context),
              ],
            ),
          ),
    );
  }

  Widget _buildProductAddSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: DesignTokens.borderRadiusSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'إضافة منتج',
            style: DesignTokens.getBodyLarge(context).copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing12),

          // Product search field
          TextFormField(
            controller: controller.serach_for_product_controller,
            focusNode: controller.focusNode1,
            onChanged: (value) => controller.searchForProduct(),
            decoration: InputDecoration(
              hintText: 'البحث عن منتج...',
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              border: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusSmall,
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusSmall,
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusSmall,
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              filled: true,
              fillColor: AppColors.white,
            ),
          ),

          const SizedBox(height: DesignTokens.spacing12),

          // Quantity field
          TextFormField(
            controller: controller.number_of_products_controller,
            focusNode: controller.focusNode2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'الكمية',
              prefixIcon: Icon(Icons.numbers, color: AppColors.textSecondary),
              border: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusSmall,
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusSmall,
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusSmall,
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              filled: true,
              fillColor: AppColors.white,
            ),
          ),

          const SizedBox(height: DesignTokens.spacing16),

          // Add product button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (controller.product_id != null) {
                  controller.addProduct(controller.product_id!);
                }
              },
              icon: Icon(Icons.add, size: 20),
              label: Text('إضافة المنتج'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: DesignTokens.spacing12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: DesignTokens.borderRadiusSmall,
                ),
              ),
            ),
          ),

          // Search results popup
          if (controller.show_search_popupMenu &&
              controller.all_product_list.isNotEmpty)
            _buildSearchResults(context),
        ],
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: DesignTokens.spacing8),
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: DesignTokens.borderRadiusSmall,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlay.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.all_product_list.length,
        itemBuilder: (context, index) {
          final product = controller.all_product_list[index];
          return ListTile(
            dense: true,
            leading: Container(
              padding: const EdgeInsets.all(DesignTokens.spacing4),
              decoration: BoxDecoration(
                color: AppColors.primaryLighter,
                borderRadius: DesignTokens.borderRadiusSmall,
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                color: AppColors.primary,
                size: 16,
              ),
            ),
            title: Text(
              product['product_name'] ?? '',
              style: DesignTokens.getBodyMedium(
                context,
              ).copyWith(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              '${product['product_sales_price'] ?? 0} د.ع',
              style: DesignTokens.getBodySmall(
                context,
              ).copyWith(color: AppColors.textSecondary),
            ),
            onTap: () {
              controller.product_id = controller.all_product_list[index]['id'];
              controller.product_name = product['product_name'];
              controller.setProductFromSearch(product['product_name']);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المنتجات المضافة',
          style: DesignTokens.getBodyLarge(
            context,
          ).copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: DesignTokens.spacing12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.bill_prodects_list.length,
          separatorBuilder:
              (context, index) => const SizedBox(height: DesignTokens.spacing8),
          itemBuilder: (context, index) {
            final product = controller.bill_prodects_list[index];
            return _buildProductCard(context, product, index);
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    Map<String, dynamic> product,
    int index,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: DesignTokens.borderRadiusSmall,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing8),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: DesignTokens.borderRadiusSmall,
                ),
                child: Icon(
                  Icons.inventory_2,
                  color: AppColors.success,
                  size: 16,
                ),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: Text(
                  product['product_name'] ?? '',
                  style: DesignTokens.getBodyLarge(context).copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => controller.deleteProduct(index),
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                  size: 20,
                ),
                constraints: const BoxConstraints(
                  minWidth: DesignTokens.minTouchTarget,
                  minHeight: DesignTokens.minTouchTarget,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing12),
          Row(
            children: [
              Expanded(
                child: _buildProductInfo(
                  context,
                  'الكمية',
                  '${product['product_number']}',
                  Icons.numbers,
                  AppColors.info,
                ),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: _buildProductInfo(
                  context,
                  'السعر',
                  '${product['product_price']} د.ع',
                  Icons.attach_money,
                  AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(DesignTokens.spacing12),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: DesignTokens.borderRadiusSmall,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المجموع:',
                  style: DesignTokens.getBodyMedium(context).copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${product['total_product_price']} د.ع',
                  style: DesignTokens.getBodyLarge(context).copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing8),
      decoration: BoxDecoration(
        color: AppColors.withOpacity(color, 0.1),
        borderRadius: DesignTokens.borderRadiusSmall,
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: DesignTokens.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: DesignTokens.getBodySmall(
                    context,
                  ).copyWith(color: color),
                ),
                Text(
                  value,
                  style: DesignTokens.getBodyMedium(
                    context,
                  ).copyWith(color: color, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignTokens.spacing32),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: DesignTokens.borderRadiusSmall,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            decoration: BoxDecoration(
              color: AppColors.primaryLighter,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.primary,
              size: 32,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing16),
          Text(
            'لا توجد منتجات',
            style: DesignTokens.getHeadlineMedium(context).copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            'ابدأ بإضافة المنتجات إلى الفاتورة',
            style: DesignTokens.getBodyMedium(
              context,
            ).copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
