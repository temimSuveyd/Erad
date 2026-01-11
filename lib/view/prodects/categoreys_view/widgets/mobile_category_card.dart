import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/categoreys/categorey_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileCategoryCard extends GetView<CategoreyControllerImp> {
  const MobileCategoryCard({super.key, required this.title, required this.id});

  final String title;
  final String id;

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
          // Header with icon and title
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
                // Category icon
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                  child: Icon(
                    Icons.category_outlined,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing12),

                // Title
                Expanded(
                  child: Text(
                    title,
                    style: DesignTokens.getBodyLarge(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Actions menu
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      controller.show_delete_dialog(id);
                    } else if (value == 'details') {
                      controller.go_to_gategorey_type_page(title);
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'details',
                          child: Row(
                            children: [
                              Icon(
                                Icons.open_in_new,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: DesignTokens.spacing8),
                              Text('تفاصيل'),
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

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: Row(
              children: [
                // Details button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        () => controller.go_to_gategorey_type_page(title),
                    icon: Icon(
                      Icons.open_in_new,
                      size: 18,
                      color: AppColors.white,
                    ),
                    label: Text(
                      'عرض التفاصيل',
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
                    onPressed: () => controller.show_delete_dialog(id),
                    icon: Icon(Icons.delete, color: Colors.red, size: 20),
                    constraints: const BoxConstraints(
                      minWidth: DesignTokens.minTouchTarget,
                      minHeight: DesignTokens.minTouchTarget,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
