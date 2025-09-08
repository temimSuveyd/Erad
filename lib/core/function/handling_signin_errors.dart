import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

// ignore: non_constant_identifier_names
void handling_sigin_errors(FirebaseAuthException e) {
  String errorMessage;
  switch (e.code) {
    case 'invalid-credential':
      errorMessage =
          'بيانات اعتماد المصادقة المقدمة غير صحيحة أو مشوهة أو انتهت صلاحيتها';
      Get.defaultDialog(
        title: "خطأ",
        middleText: errorMessage,
        backgroundColor: AppColors.backgroundColor,
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          Get.back();
        },
        buttonColor: AppColors.primary,
      );

      break;
    case 'user-not-found':
      errorMessage = 'لم يتم العثور على مستخدم مع عنوان البريد الإلكتروني هذا';

      Get.defaultDialog(
        title: "خطأ",
        middleText: errorMessage,
        backgroundColor: AppColors.backgroundColor,
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          Get.back();
        },
        buttonColor: AppColors.primary,
      );

      break;
    case 'wrong-password':
      errorMessage = 'كلمة مرور غير صحيحة ، يرجى المحاولة مرة أخرى';
      Get.defaultDialog(
        title: "خطأ",
        middleText: errorMessage,
        backgroundColor: AppColors.backgroundColor,
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          Get.back();
        },
        buttonColor: AppColors.primary,
      );
      break;
    case 'invalid-email':
      errorMessage = 'عنوان البريد الإلكتروني غير صالح';
      Get.defaultDialog(
        title: "خطأ",
        middleText: errorMessage,
        backgroundColor: AppColors.backgroundColor,
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          Get.back();
        },
        buttonColor: AppColors.primary,
      );
      break;
    case 'user-disabled':
      errorMessage = 'تم تعطيل هذا الحساب';
      Get.defaultDialog(
        title: "خطأ",
        middleText: errorMessage,
        backgroundColor: AppColors.backgroundColor,
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          Get.back();
        },
        buttonColor: AppColors.primary,
      );
      break;
    case 'too-many-requests':
      errorMessage = 'Tالكثير من المحاولات ، يرجى المحاولة مرة أخرى لاحقًا';
      Get.defaultDialog(
        title: "خطأ",
        middleText: errorMessage,
        backgroundColor: AppColors.backgroundColor,
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          Get.back();
        },
        buttonColor: AppColors.primary,
      );
      break;
    case 'operation-not-allowed':
      errorMessage =
          'لم يتم تمكين تسجيل الدخول عبر البريد الإلكتروني/كلمة المرور';
      Get.defaultDialog(
        title: "خطأ",
        middleText: errorMessage,
        backgroundColor: AppColors.backgroundColor,
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          Get.back();
        },
        buttonColor: AppColors.primary,
      );

      break;
    default:
      errorMessage = 'Sign-in failed: ${e.message}';
  }
}
