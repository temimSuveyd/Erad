import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suveyd_ticaret/controller/categorey_type_controller.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/categorey_type_view/widgets/custom_categoreyType_heder.dart';
import 'package:suveyd_ticaret/view/categorey_type_view/widgets/custom_categoreyType_listView.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_appBar.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_search_text_field.dart';

class CategoreyTypeViewPage extends GetView<CategoreyTypeControllerImp> {
  const CategoreyTypeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CategoreyTypeControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "نوع الفئة"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Custom_textfield(
                    hintText: 'ابحث عن نوع الفئة',
                    suffixIcon: Icons.search,
                    validator: (String? validator) {},
                    controller: controller.serach_for_categorey_type_controller,
                    onChanged: (String) {
                      controller.searchForCategoreys_type();
                    },
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),

            SliverToBoxAdapter(
              child: Row(children: [Custom_categoreyType_heder()]),
            ),

            Custom_categoreyType_listView(),
          ],
        ),
      ),
    );
  }
}
