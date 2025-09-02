import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:erad/controller/brands/brands_type_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/data/model/prodect/prodect_model.dart';
import 'package:erad/view/prodects/brands_type_view/widgets/custom_brands_type_Card.dart';

// ignore: camel_case_types
class Custom_brands_type_listView extends StatelessWidget {
  const Custom_brands_type_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandsTypeControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.brandsTypeList.length,
              itemBuilder:
                  (context, index) => Custom_brands_type_Card(
                    productModel: ProductModel.formateJson(
                      controller.brandsTypeList[index],
                    ),
                  ),
            ),
            onPressed: () => controller.get_brands_type(),
          ),
    );
  }
}
