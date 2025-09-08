import 'package:erad/controller/expenses/expenses_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<Services> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

Future initailservieses() async {
  await Get.putAsync(() => Services().init());
  ExpensesControllerImp controller = Get.put(ExpensesControllerImp());
  await controller.addExpensesAutomatically();
  Get.delete<ExpensesControllerImp>();
 
}
