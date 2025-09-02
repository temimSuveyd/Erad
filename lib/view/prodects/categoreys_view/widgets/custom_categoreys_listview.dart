import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:erad/controller/categoreys/categorey_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/view/prodects/categoreys_view/widgets/custom_categorey_card.dart';

class Custom_categoreys_listView extends StatelessWidget {
  const Custom_categoreys_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoreyControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.categoreys_list.length,
              itemBuilder:
                  (context, index) => Custom_categorey_card(
                    count: controller.categoreys_list.length.toString(),
                    title: controller.categoreys_list[index]["categorey_name"],
                  ),
            ),
            onPressed: () => controller.getCategoreys(),
          ),
    );
  }
}
