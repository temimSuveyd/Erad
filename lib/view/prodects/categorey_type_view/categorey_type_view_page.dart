import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/categoreys/categorey_type_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/prodects/categorey_type_view/widgets/mobile_category_type_header.dart';
import 'package:erad/view/prodects/categorey_type_view/widgets/custom_categoreyType_listView.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

class CategoreyTypeViewPage extends GetView<CategoreyTypeControllerImp> {
  const CategoreyTypeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CategoreyTypeControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile
              ? null
              : customAppBar(title: "أنواع التصنيفات", context: context),
      floatingActionButton:
          isMobile
              ? null
              : FloatingActionButton(
                onPressed: () {
                  // Add category type functionality
                },
                backgroundColor: AppColors.primary,
                child: Icon(Icons.add, color: AppColors.white),
              ),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile)
            const SliverToBoxAdapter(child: MobileCategoryTypeHeader()),

          // Search section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: CustomTextField(
                hintText: 'البحث عن أنواع التصنيفات',
                suffixIcon: Icons.search,
                validator: (String? validator) => null,
                controller: controller.serach_for_categorey_type_controller,
                onChanged: (value) {
                  controller.searchForCategoreys_type();
                },
              ),
            ),
          ),

          // Category types list
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Custom_categoreyType_listView(),
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
