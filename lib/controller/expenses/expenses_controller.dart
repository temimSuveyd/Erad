import 'dart:convert';
import 'dart:developer';

import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/expenses/expenses_data.dart';
import 'package:erad/data/model/expenses/string_to_json_model.dart';
import 'package:erad/view/custom_widgets/custom_set_date_range.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';
import 'package:erad/view/expenses/widgets/custom_add_expenses_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

abstract class ExpensesController extends GetxController {
  Future addExpenses();
  void getExpenses();
  void showaddExpensesDialog();
  void setDate(DateTime date);
  void toggleRepeatExpense();
  void setRepeatDate(DateTime type);
  void saveExpensesInLocal();
  void showEditDialog(
    String title,
    double amount,
    DateTime date,
    bool isRepeat,
    DateTime _date,
    String id,
  );
  void showDeleteDialog(String id);
  Future editDate(String id);
  Future deleteData(String id);
  void setDateRange();
  void calculateTotalExpenditures();
  void addExpensesAutomatically();
  Future saveStartDate();
}

class ExpensesControllerImp extends ExpensesController {
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  DateTime addedDate = DateTime.now();
  DateTime repeatDate = DateTime.now();
  DateTime? startDate;

  DateTimeRange? pickedDateRange;
  double expensesAmount = 0.0;
  double expensesTotalAmount = 0.0;
  var isRepeatExpense = false.obs;
  var expensesList = [].obs;
  ExpensesData _expensesData = ExpensesData();
  TextEditingController addExpensesAmountController = TextEditingController();
  TextEditingController addExpensesTitleController = TextEditingController();

  @override
  Future addExpenses() async {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      if (addExpensesAmountController.text.isEmpty ||
          double.tryParse(addExpensesAmountController.text) == null ||
          addExpensesTitleController.text.isEmpty) {
        custom_snackBar(
          AppColors.red,
          "خطأ",
          "لقد أدخلت قيمة خاطئة ، يرجى المحاولة مرة أخرى",
        );
      } else {
        expensesAmount = double.parse(addExpensesAmountController.text);
        await _expensesData.addExpenses(
          userID,
          addedDate,
          expensesAmount,
          isRepeatExpense.value,
          repeatDate,
          addExpensesTitleController.text,
        );
        await saveExpensesInLocal();
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
      _expensesData.getExpenses(userID).listen((event) {
        expensesList.value =
            event.docs.where((element) {
              final expenseData = element.data();
              if (expenseData.containsKey("date") &&
                  expenseData["date"] != null) {
                final DateTime expenseDate = expenseData["date"].toDate();
                return expenseDate.isAfter(pickedDateRange!.start) &&
                    expenseDate.isBefore(pickedDateRange!.end);
              }
              return false;
            }).toList();
        if (expensesList.isEmpty) {
          statusreqest = Statusreqest.noData;
        } else {
          calculateTotalExpenditures();
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
      onConfirm: () async {
        await addExpenses();
        addExpensesAmountController.clear();
        addExpensesTitleController.clear();
        isRepeatExpense.value = false;
        repeatDate = DateTime.now();
        Get.back();
      },
      onCancel: () {
        addExpensesAmountController.clear();
        addExpensesTitleController.clear();
        isRepeatExpense.value = false;
        repeatDate = DateTime.now();
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
  void setRepeatDate(DateTime date) {
    repeatDate = date;
    update();
  }

  @override
  Future saveExpensesInLocal() async {
    if (isRepeatExpense.value == true) {
      final List<String> localExpensesList =
          services.sharedPreferences.getStringList(AppShared.expenses) ?? [];
      localExpensesList.add(
        {
          "expenses_date":
              "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
          "total_amount": expensesAmount,
          "repeat_date":
              "${repeatDate.year.toString().padLeft(4, '0')}-${repeatDate.month.toString().padLeft(2, '0')}-${repeatDate.day.toString().padLeft(2, '0')}",
          "id": localExpensesList.length - 1,
        }.toString(),
      );
      await services.sharedPreferences.setStringList(
        AppShared.expenses,
        localExpensesList,
      );
    }
  }

  @override
  Future editDate(String id) async {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      expensesAmount = double.parse(addExpensesAmountController.text);
      if (double.parse(addExpensesAmountController.text).isNaN &&
          addExpensesTitleController.text.isEmpty) {
        custom_snackBar(
          AppColors.primary,
          "خطأ",
          "لقد أدخلت قيمة خاطئة ، يرجى المحاولة مرة أخرى",
        );
      } else {
        await _expensesData.editExpenses(
          userID,
          addedDate,
          expensesAmount,
          isRepeatExpense.value,
          repeatDate,
          addExpensesTitleController.text,
          id,
        );
        saveExpensesInLocal();
      }

      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.success;
      update();
    }
  }

  @override
  void showEditDialog(
    String title,
    double amount,
    DateTime date,
    bool isRepeat,
    DateTime _date,
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
    repeatDate = _date;
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
        editDate(id);
        addExpensesAmountController.clear();
        addExpensesTitleController.clear();
        isRepeatExpense.value = false;
        repeatDate = DateTime.now();
        Get.back();
      },
      onCancel: () {
        addExpensesAmountController.clear();
        addExpensesTitleController.clear();
        isRepeatExpense.value = false;
        repeatDate = DateTime.now();
      },
      content: CustomAddExpensesDialog(
        countController: addExpensesAmountController,
        titleController: addExpensesTitleController,
      ),
    );
  }

  @override
  Future deleteData(String id) async {
    statusreqest = Statusreqest.loading;
    update();

    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      await _expensesData.deleteExpenses(userID, id);
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void showDeleteDialog(String id) {
    Get.defaultDialog(
      backgroundColor: AppColors.backgroundColor,
      title: "هل تريد حذف؟",
      titleStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 48),
          SizedBox(height: 12),
          Text(
            "لا يمكنك استعادة هذه العملية!",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.grey, fontSize: 18),
          ),
        ],
      ),
      onConfirm: () {
        deleteData(id);
        Get.back();
      },
      onCancel: () {},
      textConfirm: "حذف",
      textCancel: "إلغاء",
      buttonColor: AppColors.primary,
    );
  }

  @override
  void setDateRange() {
    selectDateRange(Get.context!).then((value) {
      pickedDateRange = value!;
      getExpenses();
    });
  }

  @override
  void calculateTotalExpenditures() {
    expensesTotalAmount = 0.0;
    for (var total in expensesList) {
      final amount = total["amount"];
      expensesTotalAmount = amount + expensesTotalAmount;
    }
  }

  @override
  void addExpensesAutomatically() {
    if (services.sharedPreferences.getStringList(AppShared.expenses) != null) {
      final expenses = services.sharedPreferences.getStringList(
        AppShared.expenses,
      );
      final data = fromStringToList(expenses);
      for (var expensesElement in data) {
        final amount = expensesElement["total_amount"];
        final addedDate = expensesElement["expenses_date"];
        final repeatDate = expensesElement["repeat_date"];
      
        addExpenses();
      }
    }
  }

  @override
  Future saveStartDate() async {
    if (services.sharedPreferences.getString("start_date") != null) {
      final String startDateParse =
          services.sharedPreferences.getString("start_date")!;

      final DateTime start = DateTime.parse(startDateParse);

      if (DateTime.now().difference(start).inDays >= 30) {
        await services.sharedPreferences.setString(
          "start_date",
          DateTime.now().toString(),
        );
        pickedDateRange = DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        );
      } else {
        pickedDateRange = DateTimeRange(start: start, end: DateTime.now());
      }
    } else {
      pickedDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now(),
      );
      await services.sharedPreferences.setString(
        "start_date",
        DateTime.now().toString(),
      );
    }
  }

  @override
  void onInit() async {
    await saveStartDate();
    getExpenses();
    addExpensesAutomatically();
    super.onInit();
  }
}
