import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Erad/controller/brands/brands_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/brands_view/widgets/custom_brands_heder.dart';
import 'package:Erad/view/brands_view/widgets/custom_brands_listView.dart';
import 'package:Erad/view/custom_widgets/custom_appBar.dart';
import 'package:Erad/view/custom_widgets/custom_search_text_field.dart';

class BrandsViewPage extends GetView<BrandsControllerImp> {
  const BrandsViewPage({super.key});

  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => BrandsControllerImp(),);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "العلامات التجارية"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(children: [Custom_textfield(hintText: 'ابحث عن العلامات التجارية', suffixIcon: Icons.search, validator: (String?validator ) {  }, controller: controller.serach_for_brands_controller, onChanged: (String ) { 

                controller.searchForBrands();
               },)]),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),

            SliverToBoxAdapter(child: Row(children: [Custom_Brands_heder()])),

            Custom_Brands_listView(),
          ],
        ),
      ),
    );
  }
}
