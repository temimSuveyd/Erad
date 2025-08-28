import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:Erad/controller/categoreys/categorey_type_controller.dart';
import 'package:Erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:Erad/view/prodects/categorey_type_view/widgets/custom_categoreyType_Card.dart';

class Custom_categoreyType_listView extends StatelessWidget {
  const Custom_categoreyType_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoreyTypeControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.categoreyTypeList.length,
              itemBuilder:
                  (context, index) => Custom_categoreyType_Card(
                    title:
                        controller.categoreyTypeList[index]["categorey_type"],
                  ),
            ),
            onPressed: () => controller.getCategoreysType(),
          ),
    );
  }
}
