import 'package:erad/controller/suppliers/suppliers_view/suppliers_view_controller.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/supplier/suppliers_view/widgets/custom_suppliers_heder.dart';
import 'package:erad/view/supplier/suppliers_view/widgets/custom_suppliers_listView.dart';
import 'package:erad/view/supplier/suppliers_view/widgets/mobile_suppliers_header.dart';
import 'package:get/get.dart';

class SuppliersViewPage extends GetView<SuppliersControllerImp> {
  const SuppliersViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuppliersControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile ? null : customAppBar(title: "الموردين", context: context),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile)
            const SliverToBoxAdapter(child: MobileSuppliersHeader()),

          // Filters section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: _buildFiltersSection(context, isMobile),
            ),
          ),

          // Desktop header - only show on desktop
          if (!isMobile)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Row(children: [CustomSuppliersHeader()]),
              ),
            ),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(
              height: isMobile ? DesignTokens.spacing8 : DesignTokens.spacing16,
            ),
          ),

          // Suppliers list
          const CustomSuppliersListView(),

          // Bottom padding for mobile
          if (isMobile)
            const SliverToBoxAdapter(
              child: SizedBox(height: DesignTokens.spacing24),
            ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(BuildContext context, bool isMobile) {
    if (isMobile) {
      // Mobile: Vertical stack with improved spacing
      return Column(
        children: [
          CustomTextField(
            hintText: "البحث عن الموردين",
            suffixIcon: Icons.search_sharp,
            validator: (String? validator) => null,
            controller: controller.search_controller,
            onChanged: (p0) => controller.searchForSuppliersBayName(),
          ),
          const SizedBox(height: DesignTokens.spacing12),
          GetBuilder<SuppliersControllerImp>(
            builder:
                (controller) => CustomDropDownButton(
                  onChanged:
                      (value) => controller.searchForSuppliersBayCity(value),
                  hint: controller.suppliers_city,
                  items: city_data,
                  value: '',
                ),
          ),
        ],
      );
    } else {
      // Desktop: Horizontal row (existing implementation)
      return Row(
        spacing: DesignTokens.spacing12,
        children: [
          Expanded(
            child: CustomTextField(
              hintText: "اسم المورد",
              suffixIcon: Icons.search_sharp,
              validator: (String? validator) => null,
              controller: controller.search_controller,
              onChanged: (p0) => controller.searchForSuppliersBayName(),
            ),
          ),
          Expanded(
            child: GetBuilder<SuppliersControllerImp>(
              builder:
                  (controller) => CustomDropDownButton(
                    onChanged:
                        (value) => controller.searchForSuppliersBayCity(value),
                    hint: controller.suppliers_city,
                    items: city_data,
                    value: '',
                  ),
            ),
          ),
        ],
      );
    }
  }
}
