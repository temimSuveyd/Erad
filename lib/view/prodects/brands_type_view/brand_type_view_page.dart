import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/brands/brands_type_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/prodects/brands_type_view/widgets/mobile_brands_type_header.dart';
import 'package:erad/view/prodects/brands_type_view/widgets/custom_brands_type_listView.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

class BrandsTypeViewPage extends GetView<BrandsTypeControllerImp> {
  const BrandsTypeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BrandsTypeControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile ? null : customAppBar(title: "المنتجات", context: context),
      floatingActionButton:
          isMobile
              ? null
              : FloatingActionButton(
                onPressed: () {
                  controller.show_dialog();
                },
                backgroundColor: AppColors.primary,
                child: Icon(Icons.add, color: AppColors.white),
              ),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile)
            const SliverToBoxAdapter(child: MobileBrandsTypeHeader()),

          // Search section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: CustomTextField(
                hintText: "البحث عن أنواع المنتجات",
                suffixIcon: Icons.search,
                validator: (value) => null,
                controller: controller.serach_for_brands_type_controller,
                onChanged: (value) {
                  controller.searchForBrandsType();
                },
              ),
            ),
          ),

          // Brand types list
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Custom_brands_type_listView(),
            ),
          ),

          // Bottom padding for mobile
          if (isMobile)
            const SliverToBoxAdapter(
              child: SizedBox(height: DesignTokens.spacing24),
            ),
        ],
      ),
    );
  }
}
