import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Erad/controller/brands/brands_type_controller.dart';
import 'package:Erad/controller/categoreys/categorey_type_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/prodects/brands_type_view/widgets/custom_brands_type_heder.dart';
import 'package:Erad/view/prodects/brands_type_view/widgets/custom_brands_type_listView.dart';
import 'package:Erad/view/custom_widgets/custom_appBar.dart';
import 'package:Erad/view/custom_widgets/custom_search_text_field.dart';

class BrandsTypeViewPage extends GetView<BrandsTypeControllerImp> {
  const BrandsTypeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BrandsTypeControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "منتجات"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Custom_textfield(
                    hintText: "ابحث عن منتج",
                    suffixIcon: Icons.search,
                    validator: (p0) {},
                    controller: controller.serach_for_brands_type_controller,
                    onChanged: (p0) {
                      controller.searchForBrandsType();
                    },
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),

            SliverToBoxAdapter(
              child: Row(children: [Custom_brands_type_heder()]),
            ),

            Custom_brands_type_listView(),
          ],
        ),
      ),
    );
  }
}
