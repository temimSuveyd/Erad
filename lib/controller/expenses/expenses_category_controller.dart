import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/expenses/expenses_data.dart';
import 'package:erad/view/custom_widgets/custom_snackBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ExpensesDetailsController extends GetxController {
  Future addExpensesCategory();
  Future editExpensesCategory(String id);
  void getExpenses();
  void showaddExpensesCategoryDailog();
  void showaDeleteExpensesCategoryDailog(String id);
  void deleteExpensesCategory(String id);
  void showEditExpensesCategoryDailog(String id, String title);
  void goTOExpensesPage(String id);
}

class ExpensesCategoryControllerImp extends ExpensesDetailsController {
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  var expensesList = [].obs;
  final ExpensesData _expensesData = ExpensesData();
  TextEditingController categoryTitleController = TextEditingController();

  @override
  Future addExpensesCategory() async {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final title = categoryTitleController.text;
      if (title.isNotEmpty) {
        final String userID =
            services.sharedPreferences.getString(AppShared.userID)!;
        await _expensesData.addExpensesCategory(userID, title);
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
  Future editExpensesCategory(String id) async {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final title = categoryTitleController.text;
      if (title.isNotEmpty) {
        final String userID =
            services.sharedPreferences.getString(AppShared.userID)!;
        await _expensesData.editExpensesCategory(userID, title, id);
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
  void getExpenses() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _expensesData.getExpensesCategory(userID).listen((event) {
        expensesList.value = event.docs;
        if (expensesList.isEmpty) {
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
  void showaddExpensesCategoryDailog() {
    categoryTitleController.clear();
    Get.defaultDialog(
      title: "فئة جديدة",
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
        addExpensesCategory();
        categoryTitleController.clear();
        Get.back();
      },
      onCancel: () {},
      buttonColor: AppColors.primary,
    );
  }

  @override
  void showEditExpensesCategoryDailog(String id, String title) {
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
        editExpensesCategory(id);
        categoryTitleController.clear();
        Get.back();
      },
      onCancel: () {},
      buttonColor: AppColors.primary,
    );
  }

  @override
  void showaDeleteExpensesCategoryDailog(String id) {
    Get.defaultDialog(
      title: "حذف",
      titleStyle: TextStyle(color: AppColors.primary, fontSize: 24),
      backgroundColor: AppColors.background,
      middleText:
          "إذا قمت بحذف هذه الفئة، سيتم حذف جميع المدفوعات المرتبطة بها \nولن تتمكن من استعادتها مرة أخرى. هل أنت متأكد أنك تريد المتابعة؟",
      middleTextStyle: TextStyle(color: AppColors.primary, fontSize: 18),
      onConfirm: () {
        deleteExpensesCategory(id);
        Get.back();
      },
      onCancel: () {},
      buttonColor: AppColors.red,
    );
  }

  @override
  void onInit() {
    getExpenses();
    super.onInit();
  }

  @override
  void deleteExpensesCategory(String id) {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _expensesData.deleteExpensesCategory(userID, id);
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void goTOExpensesPage(String id) {
    Get.toNamed(AppRoutes.expenses_page, arguments: {"category_id": id});
  }
}
