import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

Future<dynamic> custom_willPop_dialog(
  bool is_saved,
  void Function() onConfirm,
) {
  return Get.defaultDialog(
    buttonColor: AppColors.primary,
    backgroundColor: AppColors.backgroundColor,
    textConfirm: "حفظ",
    textCancel: "حذف",
    title: "حفظ هذا الفاتورة",
    middleText: "هل تريد حفظ هذه الفاتورة",
    onCancel: () {
      is_saved = false;
      Get.back();
    },
    onConfirm: () {
      onConfirm();
    },
  );
}
