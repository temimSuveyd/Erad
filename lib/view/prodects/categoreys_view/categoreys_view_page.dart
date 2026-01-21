import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/categoreys/categorey_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/prodects/categoreys_view/widgets/mobile_categories_header.dart';
import 'package:erad/view/prodects/categoreys_view/widgets/custom_categoreys_listview.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

class CategoreysViewPage extends GetView<CategoreyControllerImp> {
  const CategoreysViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CategoreyControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile ? null : customAppBar(title: "التصنيفات", context: context),
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
            const SliverToBoxAdapter(child: MobileCategoriesHeader()),

          // Search section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: CustomTextField(
                onChanged: (value) {
                  controller.searchForCategoreys();
                },
                hintText: 'البحث عن التصنيفات',
                suffixIcon: Icons.search,
                validator: (String? validator) => null,
                controller: controller.serach_for_categorey_controller,
              ),
            ),
          ),

          // Categories list
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Custom_categoreys_listView(),
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
