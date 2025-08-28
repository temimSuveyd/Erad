import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:Erad/controller/brands/brands_controller.dart';
import 'package:Erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:Erad/view/prodects/brands_view/widgets/custom_brands_Card.dart';

class Custom_Brands_listView extends StatelessWidget {
  const Custom_Brands_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandsControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.brandsList.length,
              itemBuilder:
                  (context, index) => Custom_Brands_Card(
                    title: controller.brandsList[index]["brand_name"],
                  ),
            ),
            onPressed: () => controller.getBrands(),
          ),
    );
  }
}
