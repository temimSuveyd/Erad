import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMiddleware extends GetMiddleware {
  Services appService = Get.find();  RouteSettings? redirect(String? route) {
    final bool isLogin =
        appService.sharedPreferences.getBool(AppShared.isLoging)!;
    if (isLogin) {
      return RouteSettings(name: AppRoutes.home_page);
    } else {
      return RouteSettings(name: AppRoutes.login_page);
    }
  }
}
