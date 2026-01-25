import 'package:erad/controller/suppliers/depts/supplier_depts_details_controller.dart';
import 'package:erad/core/class/handling_data_view.dart';
import 'package:erad/data/model/customer_depts/customer_dept_payments_model.dart';
import 'package:erad/view/supplier/depts/suppliers_debt_details/widgets/custom_debt_payments_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Custom_debt_payments_listView extends StatelessWidget {
  const Custom_debt_payments_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupplierDeptsDetailsControllerImpl>(
      builder:
          (controller) => HandlingDataView(
            statusreqest: controller.paymentsStatus,
            onPressed: () => controller.getPayments(),
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...List.generate(
                  controller.paymentsList.length,
                  (index) => Custom_debt_payments_card(
                    deptPaymentsModel: DeptPaymentsModel.fromJson(
                      controller.paymentsList[index],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
