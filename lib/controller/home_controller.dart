import 'dart:developer';

import 'package:get/get.dart';
import 'package:suveyd_ticaret/core/constans/routes.dart';
import 'package:suveyd_ticaret/data/data_score/static/home/home_buying_data.dart';
import 'package:suveyd_ticaret/data/data_score/static/home/home_pages.dart';
import 'package:suveyd_ticaret/data/data_score/static/home/home_sales_data.dart';

abstract class HomeController extends GetxController {
  setPage(int index);
  goToPage(String pageName);
}

class HomeControllerImp extends HomeController {
  int buttonIndex = 0;
  List homeData = home_sales_data;

  @override
  setPage(int index) {
    buttonIndex = index;
    homeData = home_pages[index];
    update();
  }

  @override
  goToPage(String pageName) {
    Get.toNamed(pageName);
  }
}
