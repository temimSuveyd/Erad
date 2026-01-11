import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/brands/brands_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/prodects/brands_view/widgets/custom_brands_heder.dart';
import 'package:erad/view/prodects/brands_view/widgets/custom_brands_listView.dart';
import 'package:erad/view/prodects/brands_view/widgets/mobile_brands_header.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

class BrandsViewPage extends GetView<BrandsControllerImp> {
  const BrandsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BrandsControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile
              ? null
              : customAppBar(title: "العلامات التجارية", context: context),
      floatingActionButton:
          isMobile
              ? null
              : FloatingActionButton(
                onPressed: () => controller.show_dialog(),
                backgroundColor: AppColors.primary,
                child: Icon(Icons.add, color: AppColors.white),
              ),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile) const SliverToBoxAdapter(child: MobileBrandsHeader()),

          // Search section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: CustomTextField(
                hintText: 'البحث عن العلامات التجارية',
                suffixIcon: Icons.search,
                validator: (String? validator) => null,
                controller: controller.serach_for_brands_controller,
                onChanged: (value) {
                  controller.searchForBrands();
                },
              ),
            ),
          ),

          // Desktop header - only show on desktop
          if (!isMobile)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Row(children: [Custom_Brands_heder()]),
              ),
            ),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(
              height: isMobile ? DesignTokens.spacing8 : DesignTokens.spacing16,
            ),
          ),

          // Brands list
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: CustomBrandsListView(),
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
