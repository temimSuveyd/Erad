import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:suveyd_ticaret/controller/categorey_controller.dart';
import 'package:suveyd_ticaret/core/class/handling_data_view_with_sliverBox.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/categoreys_view/widgets/custom_categorey_card.dart';
import 'package:suveyd_ticaret/view/categoreys_view/widgets/custom_categorey_heder.dart';
import 'package:suveyd_ticaret/view/categoreys_view/widgets/custom_categoreys_listview.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_appBar.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_search_text_field.dart';

class CategoreysViewPage extends GetView<CategoreyControllerImp> {
  const CategoreysViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CategoreyControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "تصنيف"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Custom_textfield(
                    onChanged: (p0) {
                      controller.searchForCategoreys();
                    },
                    hintText: 'ابحث عن الفئة',
                    suffixIcon: Icons.search,
                    validator: (String? validator) {},
                    controller: controller.serach_for_categorey_controller,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(child: Custom_categorey_heder()),
            Custom_categoreys_listView(),
          ],
        ),
      ),
    );
  }
}
