import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  goToPage(String pageName);
}

class HomeControllerImp extends HomeController {
  @override
  goToPage(String pageName) {
    Get.toNamed(pageName);
  }
}
