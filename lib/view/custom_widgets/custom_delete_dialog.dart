import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

Future<dynamic> custom_delete_dialog(void Function() onConfirm) {
  return Get.defaultDialog(
    title: "حذف المنتج",
    middleText: "هل أنت متأكد من أنك تريد حذف هذا المنتج؟",
    onConfirm: () {
      onConfirm();
      Get.close(0);
    },
    onCancel: () {},
    buttonColor: AppColors.primary,
    backgroundColor: AppColors.background,
  );
}
