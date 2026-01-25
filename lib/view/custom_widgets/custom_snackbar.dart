import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    String? title,
    String? message,
    Color? color,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    final context = Get.context;
    if (context == null) return;

    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (title != null && message != null)
            const SizedBox(height: 4),
          if (message != null)
            Text(
              message,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
        ],
      ),
      backgroundColor: color ?? AppColors.primary,
      duration: duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      behavior: SnackBarBehavior.floating,
      action: action,
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      elevation: 6,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void success({String? title, String? message}) {
    show(
      title: title ?? 'نجاح',
      message: message,
      color: AppColors.success,
    );
  }

  static void error({String? title, String? message}) {
    show(
      title: title ?? 'خطأ',
      message: message ?? 'حدث خطأ ما، يرجى المحاولة مرة أخرى',
      color: AppColors.error,
    );
  }

  static void warning({String? title, String? message}) {
    show(
      title: title ?? 'تحذير',
      message: message,
      color: AppColors.warning,
    );
  }

  static void info({String? title, String? message}) {
    show(
      title: title ?? 'معلومة',
      message: message,
      color: AppColors.info,
    );
  }
}

// For backward compatibility
void custom_snackBar([Color? color, String? title, String? message]) {
  CustomSnackbar.show(
    title: title,
    message: message ?? "عليك إدخال جميع المعلومات",
    color: color,
  );
}
