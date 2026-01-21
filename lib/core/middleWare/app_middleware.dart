import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/core/config/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    try {
      final Services appService = Get.find<Services>();
      final bool isLogin =
          appService.sharedPreferences.getBool(AppShared.isLoging) ?? false;

      // Also check if user is authenticated with Supabase
      final isSupabaseAuthenticated = SupabaseConfig.auth.currentUser != null;

      if (isLogin && isSupabaseAuthenticated) {
        return const RouteSettings(name: AppRoutes.home_page);
      } else {
        return const RouteSettings(name: AppRoutes.login_page);
      }
    } catch (e) {
      // If service is not found, redirect to login
      return const RouteSettings(name: AppRoutes.login_page);
    }
  }
}
