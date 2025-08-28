import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:Erad/controller/customers/customers_controller.dart';
import 'package:Erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:Erad/data/model/customers/customers_model.dart';
import 'package:Erad/view/customer/customers_view/widgets/custom_brands_Card.dart';

class Custom_customers_listView extends StatelessWidget {
  const Custom_customers_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomersControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.customersList.length,
              itemBuilder:
                  (context, index) => Custom_customers_Card(
                    customersModel: CustomersModel.formatJson(
                      controller.customersList[index],
                    ),
                  ),
            ),
            onPressed: () => controller.getCustomers(),
          ),
    );
  }
}
