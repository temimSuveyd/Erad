import 'dart:developer';

import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/expenses/expenses_data.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';
import 'package:erad/view/expenses/widgets/custom_add_expenses_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

abstract class ExpensesController extends GetxController {
  void addExpenses();
  void getExpenses();
  void showaddExpensesDialog();
  void setDate(DateTime date);
  void toggleRepeatExpense();
  void setDateType(String type);
  void saveExpensesInLocal();
  void showEditDialog(
    String title,
    double amount,
    DateTime date,
    bool isRepeat,
    String dateType,
    String id,
  );
  void editDate();
}

class ExpensesControllerImp extends ExpensesController {
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  DateTime addedDate = DateTime.now();
  double totalAmount = 0.0;
  var isRepeatExpense = false.obs;
  var expensesList = [].obs;
  String dateType = "week";
  ExpensesData _expensesData = ExpensesData();
  TextEditingController addExpensesAmountController = TextEditingController();
  TextEditingController addExpensesTitleController = TextEditingController();

  @override
  void addExpenses() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      totalAmount = double.parse(addExpensesAmountController.text);
      if (double.parse(addExpensesAmountController.text).isNaN &&
          addExpensesTitleController.text.isEmpty) {
        custom_snackBar(
          AppColors.primary,
          "خطأ",
          "لقد أدخلت قيمة خاطئة ، يرجى المحاولة مرة أخرى",
        );
      } else {
        _expensesData.addExpenses(
          user_email,
          addedDate,
          totalAmount,
          isRepeatExpense.value,
          dateType,
          addExpensesTitleController.text,
        );
        saveExpensesInLocal();
      }
      addExpensesAmountController.clear();
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.success;
      update();
    }
  }

  @override
  void getExpenses() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      _expensesData.getExpenses(user_email).listen((event) {
        expensesList.value = event.docs;
        if (expensesList.isEmpty) {
          statusreqest = Statusreqest.noData;
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
  void showaddExpensesDialog() {
    Get.defaultDialog(
      backgroundColor: AppColors.backgroundColor,
      buttonColor: AppColors.primary,
      title: "إضافة نفقة",
      titleStyle: TextStyle(
        color: AppColors.grey,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      onConfirm: () {
        addExpenses();
        Get.back();
      },
      onCancel: () {
        addExpensesAmountController.clear();
      },
      content: CustomAddExpensesDialog(
        countController: addExpensesAmountController,
        titleController: addExpensesTitleController,
      ),
    );
  }

  @override
  void setDate(DateTime date) {
    addedDate = date;
    update();
  }

  @override
  void toggleRepeatExpense() {
    isRepeatExpense.value = !isRepeatExpense.value;
    update();
  }

  @override
  void setDateType(String type) {
    dateType = type;
    update();
  }

  @override
  void saveExpensesInLocal() {
    if (isRepeatExpense.value == true) {
      final List<String> localExpensesList =
          services.sharedPreferences.getStringList("expenses") ?? [];
      localExpensesList.add(
        {
          "expenses_date": addedDate,
          "total_amount": totalAmount,
          "date_type": dateType,
        }.toString(),
      );
      services.sharedPreferences.setStringList("expenses", localExpensesList);
    }
  }

  @override
  void onInit() async {
    getExpenses();
    super.onInit();
  }

  @override
  void editDate() {
    // TODO: implement editDate
  }

  @override
  void showEditDialog(
    String title,
    double amount,
    DateTime date,
    bool isRepeat,
    String _dateType,
    String id,
  ) {
    // title
    addExpensesTitleController.text = title;
    // amount
    addExpensesAmountController.text = amount.toString();
    // date
    addedDate = date;
    // isRepeatExpense
    isRepeatExpense.value = isRepeat;
    // date type
    dateType = _dateType;
    Get.defaultDialog(
      backgroundColor: AppColors.backgroundColor,
      buttonColor: AppColors.primary,
      title: "تعديل المصروف",
      titleStyle: TextStyle(
        color: AppColors.grey,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      onConfirm: () {
        // addExpenses();
        Get.back();
      },
      onCancel: () {
        addExpensesAmountController.clear();
      },
      content: CustomAddExpensesDialog(
        countController: addExpensesAmountController,
        titleController: addExpensesTitleController,
      ),
    );
  }
}
