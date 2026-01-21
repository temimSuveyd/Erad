import 'package:get/get.dart';
import 'package:erad/controller/customers/depts/customer_depts_view_controller.dart';

class CustomerDebtsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CustomerDeptsViewControllerImp>(
      CustomerDeptsViewControllerImp(),
      permanent: false,
    );
  }
}
