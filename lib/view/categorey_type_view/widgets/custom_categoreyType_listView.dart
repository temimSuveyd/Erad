import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:suveyd_ticaret/controller/categorey_type_controller.dart';
import 'package:suveyd_ticaret/core/class/handling_data_view_with_sliverBox.dart';
import 'package:suveyd_ticaret/view/categorey_type_view/widgets/custom_categoreyType_Card.dart';

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
