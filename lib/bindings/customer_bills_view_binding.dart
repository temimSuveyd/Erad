import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_bill_view_controller.dart';

class CustomerBillsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CustomerBillViewControllerImp>(
      CustomerBillViewControllerImp(),
      permanent: false,
    );
  }
}
