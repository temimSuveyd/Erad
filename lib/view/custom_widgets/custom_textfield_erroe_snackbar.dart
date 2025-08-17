  import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:Erad/core/constans/colors.dart';

SnackbarController custom_empty_data_erroe_snackbar() {
    return Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.primary,
        animationDuration: Duration(milliseconds: 400),
        duration: Duration(seconds: 3),
        title: "خطأ",
        message: "عليك إدخال جميع المعلومات",
    snackStyle: SnackStyle.GROUNDED,
    dismissDirection: DismissDirection.endToStart,
    snackPosition: SnackPosition.TOP,

      ),
    );
  }