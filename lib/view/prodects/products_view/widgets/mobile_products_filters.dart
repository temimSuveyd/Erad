import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';

class MobileProductsFilters extends StatelessWidget {
  const MobileProductsFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: DesignTokens.borderRadiusMedium,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: DesignTokens.borderRadiusSmall,
                ),
                child: Icon(
                  Icons.filter_list,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Text(
                'البحث والتصفية',
                style: DesignTokens.getBodyLarge(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing16),

          // Search field
          CustomTextField(
            hintText: 'البحث عن المنتجات',
            suffixIcon: Icons.search,
            validator: (String? validator) => null,
            controller: null,
            onChanged: (value) {
              // Add search functionality
            },
          ),

          const SizedBox(height: DesignTokens.spacing16),

          // Filter dropdowns
          Row(
            children: [
              Expanded(
                child: CustomDropDownButton(
                  value: "",
                  onChanged: (value) {
                    // Add category filter
                  },
                  hint: 'اختر التصنيف',
                  items: const [],
                ),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: CustomDropDownButton(
                  value: "",
                  onChanged: (value) {
                    // Add brand filter
                  },
                  hint: 'اختر العلامة التجارية',
                  items: const [],
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Apply filters
                  },
                  icon: Icon(Icons.search, size: 18, color: AppColors.white),
                  label: Text(
                    'بحث',
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
              OutlinedButton.icon(
                onPressed: () {
                  // Clear filters
                },
                icon: Icon(Icons.clear, size: 18, color: AppColors.primary),
                label: Text(
                  'مسح',
                  style: DesignTokens.getBodyMedium(context).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                    horizontal: DesignTokens.spacing16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
