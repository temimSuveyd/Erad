import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      await Future.delayed(const Duration(seconds: 5));
      return true;
    });
  }

  Future<void> _checkConnection() async {
    try {
      final firebase = FirebaseFirestore.instance;
      final result = await firebase.collection('connectivity_test').get();

      if (result.docs.isNotEmpty || result.metadata.isFromCache == false) {
        if (!isConnected.value) {
          _showSnackBar(
            title: "معلومات الاتصال",
            message: "تم استعادة الاتصال بالإنترنت.",
            color: Colors.green,
          );
        }
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
      backgroundColor: color.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: false,
      duration: isConnected.value ? const Duration(seconds: 3) : null,
      margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
    );
  }
}
