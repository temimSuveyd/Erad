import 'package:Erad/controller/customers/customer_dept_details_controller.dart';
import 'package:Erad/data/model/customer_depts/customer_dept_payments_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:Erad/view/customer_debt_details/widgets/custom_debt_payments_card.dart';
import 'package:get/get.dart';

class Custom_debt_payments_listView extends StatelessWidget {
  const Custom_debt_payments_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDeptsDetailsControllerImp>(
      builder:
          (controller) => Column(
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
    );
  }
}
