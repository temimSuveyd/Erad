import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/customers_view/customers_controller.dart';
import 'package:erad/core/class/handling_data_view.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/customers/customers_model.dart';
import 'package:erad/view/customer/customers_view/widgets/custom_brands_Card.dart';
import 'package:erad/view/customer/customers_view/widgets/mobile_customer_card.dart';

class CustomCustomersListView extends StatelessWidget {
  const CustomCustomersListView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = DesignTokens.isMobile(context);

    return GetBuilder<CustomersControllerImp>(
      builder:
          (controller) => HandlingDataView(
            statusreqest: controller.statusreqest,
            onPressed: () => controller.getCustomers(),
            widget: ListView.builder(
              itemCount: controller.customersList.length,
              itemBuilder: (context, index) {
                final customerModel = CustomersModel.formatJson(
                  controller.customersList[index],
                );

                // Use mobile card for mobile screens, desktop card for larger screens
                return isMobile
                    ? MobileCustomerCard(customerModel: customerModel)
                    : CustomCustomersCard(customersModel: customerModel);
              },
            ),
          ),
    );
  }
}
