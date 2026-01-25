import 'package:get/get.dart';
import 'package:erad/controller/customers/depts/customer_dept_details_controller.dart';

class CustomerDebtDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CustomerDeptsDetailsControllerImp>(
      CustomerDeptsDetailsControllerImp(),
      permanent: false,
    );
  }
}
