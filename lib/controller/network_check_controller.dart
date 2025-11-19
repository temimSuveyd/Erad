import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

abstract class NetworkCheckController extends GetxController {
  void initData();
  void updateConnectionStatus(ConnectivityResult result);
}

class NetworkCheckControllerImp extends NetworkCheckController {
  final Connectivity _connectivity = Connectivity();

  @override
  void initData() {
    _connectivity.onConnectivityChanged.listen(
      (event) => updateConnectionStatus(event.first),
    );
  }

  // VPN bağlı mı kontrolü için bir yardımcı fonksiyon ekliyoruz
  Future<bool> isVpnActive() async {
    try {
      // Tüm NetworkInterface'leri alıyoruz
      for (var interface in await NetworkInterface.list()) {
        // isVpn tespiti için interface isimleri yaygın olarak 'tun', 'ppp', 'pptp', 'wg' içerir
        final name = interface.name.toLowerCase();
        if (name.contains('tun') ||
            name.contains('ppp') ||
            name.contains('pptp') ||
            name.contains('wg')) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // varsayılan olarak aktif değil diyelim
      return false;
    }
  }

  @override
  void updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      Get.offAllNamed(AppRoutes.home_page);
      custom_snackBar(
        AppColors.red,
        'تنبيه',
        'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة',
      );
    } else {
      // İnternet var görünüyor, VPN bağlı mı kontrol et
      bool vpnActive = await isVpnActive();
      if (!vpnActive) {
        Get.offAllNamed(AppRoutes.home_page);
        custom_snackBar(
          AppColors.red,
          'تنبيه',
          'لا يوجد اتصال VPN، يرجى تفعيل الـVPN.',
        );
      } else {
        ScaffoldMessenger.of(Get.context!)..hideCurrentSnackBar();
      }
    }
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
