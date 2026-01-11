import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/brands/brands_type_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/prodect/prodect_model.dart';

class MobileBrandsTypeCard extends GetView<BrandsTypeControllerImp> {
  const MobileBrandsTypeCard({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: DesignTokens.borderRadiusMedium,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and product info
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(DesignTokens.radiusMedium),
                topRight: Radius.circular(DesignTokens.radiusMedium),
              ),
            ),
            child: Row(
              children: [
                // Product icon
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing12),

                // Product info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.size ?? 'منتج',
                        style: DesignTokens.getBodyLarge(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: DesignTokens.spacing4),
                      Text(
                        'الربح: ${productModel.profits ?? '0'} د.ع',
                        style: DesignTokens.getBodyMedium(context).copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Actions menu
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      controller.show_edit_dialog(
                        productModel.sales_pice ?? '',
                        productModel.buiyng_price ?? '',
                        productModel.size ?? '',
                        productModel.title ?? '',
                      );
                    } else if (value == 'delete') {
                      controller.show_delete_dialog(productModel.title ?? '');
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: DesignTokens.spacing8),
                              Text('تعديل'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 20),
                              const SizedBox(width: DesignTokens.spacing8),
                              Text('حذف'),
                            ],
                          ),
                        ),
                      ],
                  child: Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: Icon(
                      Icons.more_vert,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product details
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: Column(
              children: [
                // Price info
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        context,
                        'سعر الشراء',
                        '${productModel.buiyng_price ?? '0'} د.ع',
                        Icons.shopping_cart_outlined,
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: _buildInfoCard(
                        context,
                        'سعر البيع',
                        '${productModel.sales_pice ?? '0'} د.ع',
                        Icons.sell_outlined,
                        Colors.green,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing16),

                // Action buttons
                Row(
                  children: [
                    // Edit button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed:
                            () => controller.show_edit_dialog(
                              productModel.sales_pice ?? '',
                              productModel.buiyng_price ?? '',
                              productModel.size ?? '',
                              productModel.title ?? '',
                            ),
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                          color: AppColors.white,
                        ),
                        label: Text(
                          'تعديل',
                          style: DesignTokens.getBodyMedium(context).copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: DesignTokens.spacing12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: DesignTokens.borderRadiusSmall,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),

                    // Delete button
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: IconButton(
                        onPressed:
                            () => controller.show_delete_dialog(
                              productModel.title ?? '',
                            ),
                        icon: Icon(Icons.delete, color: Colors.red, size: 20),
                        constraints: const BoxConstraints(
                          minWidth: DesignTokens.minTouchTarget,
                          minHeight: DesignTokens.minTouchTarget,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: DesignTokens.borderRadiusSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: DesignTokens.spacing4),
              Expanded(
                child: Text(
                  label,
                  style: DesignTokens.getBodySmall(
                    context,
                  ).copyWith(color: color, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing4),
          Text(
            value,
            style: DesignTokens.getBodyMedium(
              context,
            ).copyWith(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
