import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

Future<dynamic> custom_willPop_dialog(
  bool isSaved,
  void Function() onConfirm,
) {
  return Get.defaultDialog(
    buttonColor: AppColors.primary,
    backgroundColor: AppColors.background,
    textConfirm: "حفظ",
    textCancel: "حذف",
    title: "حفظ هذا الفاتورة",
    middleText: "هل تريد حفظ هذه الفاتورة",
    onCancel: () {
      isSaved = false;
      Get.back();
    },
    onConfirm: () {
      onConfirm();
    },
  );
}
