import 'package:erad/controller/suppliers/depts/supplier_depts_details_controller.dart';
import 'package:erad/data/model/customer_depts/customer_dept_bills_model.dart';
import 'package:erad/view/supplier/depts/suppliers_debt_details/widgets/custom_debts_bills_card.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';

class Custom_debts_bills_listView extends StatelessWidget {
  const Custom_debts_bills_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupplierDeptsDetailsControllerImpl>(
      builder:
          (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...List.generate(
                controller.deptsList.length,
                  (index) => Custom_debts_bills_card(
                    deptsBillsModel: DeptBillsModel.fromJson(
                      controller.deptsList[index],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
