import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class NetworkCheckController extends GetxController {
  void initData();
  void listenNetworkStatus();
}

class NetworkCheckControllerImp extends NetworkCheckController {
  RxBool isConnected = true.obs;

  @override
  void initData() {
    listenNetworkStatus();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void listenNetworkStatus() {
    ever(isConnected, (_) {});
    _startChecking();
  }

  void _startChecking() async {
    Future.doWhile(() async {
      await _checkConnection();
      await Future.delayed(
        const Duration(seconds: 30),
      ); // Reduced from 5 to 30 seconds for battery optimization
      return true;
    });
  }

  Future<void> _checkConnection() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('connectivity_test')
          .select('*')
          .limit(1);

      if (response.isNotEmpty) {
        isConnected.value = true;
      } else {
        if (isConnected.value) {
          _showSnackBar(
            title: "خطأ في الاتصال",
            message: "تم فقدان الاتصال بالإنترنت.",
            color: Colors.red,
          );
        }
        isConnected.value = false;
      }
    } catch (e) {
      if (isConnected.value) {
        _showSnackBar(
          title: "خطأ في الاتصال",
          message: "تم فقدان الاتصال بالإنترنت.",
          color: Colors.red,
        );
      }
      isConnected.value = false;
    }
  }

  void _showSnackBar({
    required String title,
    required String message,
    required Color color,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color.withValues(alpha: 0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: false,
      duration: isConnected.value ? const Duration(seconds: 3) : null,
      margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
    );
  }
}
