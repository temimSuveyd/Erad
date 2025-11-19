import 'package:erad/controller/network_check_controller.dart';
import 'package:erad/core/function/save_started_date.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<Services> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Get.put(NetworkCheckControllerImp());
    return this;
  }
}

Future initailservieses() async {
  await Get.putAsync(() => Services().init());
  await saveCustomDateRange();
}
