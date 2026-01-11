import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/withdrawn_fund/withdrawn_fund_data.dart';
import 'package:erad/view/custom_widgets/custom_snackBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class WithdrawnFundsCategoryController extends GetxController {
  Future addWithdrawnFundsCategory();
  Future editWithdrawnFundsCategory(String id);
  void getWithdrawnFunds();
  void showaddWithdrawnFundsCategoryDailog();
  void showaDeleteWithdrawnFundsCategoryDailog(String id);
  void deleteWithdrawnFundsCategory(String id);
  void showEditWithdrawnFundsCategoryDailog(String id, String title);
  void goTOWithdrawnFundsPage(String id);
}

class WithdrawnFundsCategoryControllerImp
    extends WithdrawnFundsCategoryController {
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  var withdrawnFundDataList = [].obs;
  final WithdrawnFundData _withdrawnFundDataData = WithdrawnFundData();
  TextEditingController categoryTitleController = TextEditingController();

  @override
  Future addWithdrawnFundsCategory() async {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final title = categoryTitleController.text;
      if (title.isNotEmpty) {
        final String userID =
            services.sharedPreferences.getString(AppShared.userID)!;
        await _withdrawnFundDataData.addWithdrawnFundCategory(userID, title);
      } else {
        custom_snackBar(AppColors.red, "خطأ", "من فضلك لا تترك العنوان فارغ");
      }

      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  Future editWithdrawnFundsCategory(String id) async {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final title = categoryTitleController.text;
      if (title.isNotEmpty) {
        final String userID =
            services.sharedPreferences.getString(AppShared.userID)!;
        await _withdrawnFundDataData.editWithdrawnFundCategory(
          userID,
          title,
          id,
        );
      } else {
        custom_snackBar(AppColors.red, "خطأ", "من فضلك لا تترك العنوان فارغ");
      }

      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void getWithdrawnFunds() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _withdrawnFundDataData.getWithdrawnFundCategory(userID).listen((event) {
        withdrawnFundDataList.value = event.docs;
        if (withdrawnFundDataList.isEmpty) {
          statusreqest = Statusreqest.empty;
        } else {
          statusreqest = Statusreqest.success;
        }
        update();
      });
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void showaddWithdrawnFundsCategoryDailog() {
    categoryTitleController.clear();
    Get.defaultDialog(
      title: "مستخدم جديد",
      titleStyle: TextStyle(color: AppColors.primary, fontSize: 24),
      backgroundColor: AppColors.background,
      middleText: "يرجى إدخال اسم مستخدم",
      middleTextStyle: TextStyle(color: AppColors.primary, fontSize: 18),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            height: 43,
            maxLines: 1,
            hintText: "أدخل اسم المستخدم",
            suffixIcon: Icons.title,
            validator: (v) {
              return null;
            },
            controller: categoryTitleController,
            onChanged: (change) {},
          ),
        ],
      ),
      onConfirm: () {
        addWithdrawnFundsCategory();
        categoryTitleController.clear();
        Get.back();
      },
      onCancel: () {},
      buttonColor: AppColors.primary,
    );
  }

  @override
  void showEditWithdrawnFundsCategoryDailog(String id, String title) {
    categoryTitleController.text = title;

    Get.defaultDialog(
      title: "تعديل الفئة",
      titleStyle: TextStyle(color: AppColors.primary, fontSize: 24),
      backgroundColor: AppColors.background,
      middleText: "يرجى إدخال اسم الفئة",
      middleTextStyle: TextStyle(color: AppColors.primary, fontSize: 18),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            height: 120,
            maxLines: 3,
            hintText: "أدخل اسم الفئة",
            suffixIcon: Icons.title,
            validator: (v) {
              return null;
            },
            controller: categoryTitleController,
            onChanged: (change) {},
          ),
        ],
      ),
      onConfirm: () {
        editWithdrawnFundsCategory(id);
        categoryTitleController.clear();
        Get.back();
      },
      onCancel: () {},
      buttonColor: AppColors.primary,
    );
  }

  @override
  void showaDeleteWithdrawnFundsCategoryDailog(String id) {
    Get.defaultDialog(
      title: "حذف",
      titleStyle: TextStyle(color: AppColors.primary, fontSize: 24),
      backgroundColor: AppColors.background,
      middleText:
          "سيتم حذف جميع الأموال المسحوبة المرتبطة بهذه الفئة. هل أنت متأكد أنك تريد المتابعة؟",
      middleTextStyle: TextStyle(color: AppColors.primary, fontSize: 18),
      onConfirm: () {
        deleteWithdrawnFundsCategory(id);
        Get.back();
      },
      onCancel: () {},
      buttonColor: AppColors.red,
    );
  }

  @override
  void deleteWithdrawnFundsCategory(String id) {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _withdrawnFundDataData.deleteWithdrawnFundCategory(userID, id);
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void goTOWithdrawnFundsPage(String id) {
    Get.toNamed(AppRoutes.withdrawn_fund_page, arguments: {"category_id": id});
  }

  @override
  void onInit() {
    getWithdrawnFunds();
    super.onInit();
  }
}
