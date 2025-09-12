import 'dart:convert';
import 'dart:developer';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/expenses/expenses_data.dart';
import 'package:erad/view/custom_widgets/custom_set_date_range.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';
import 'package:erad/view/expenses/expenses_view/widgets/custom_add_expenses_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

abstract class ExpensesController extends GetxController {
  Future addExpenses(
    String title,
    double amount,
    DateTime addDate,
    bool isRepeat,
    DateTime repeatedDate,
  );
  void getExpenses();
  void showaddExpensesDialog();
  void setDate(DateTime date);
  void toggleRepeatExpense();
  void setRepeatDate(DateTime type);
  void saveExpensesInLocal();
  void showEditDialog(
    String title,
    double amount,
    DateTime addDate,
    bool isRepeat,
    DateTime date,
    String id,
  );
  void showDeleteDialog(String id);
  Future editDate(String id);
  Future deleteData(String id);
  void setDateRange();
  void calculateTotalExpenditures();
  void addExpensesAutomatically();
  Future saveStartDate();
  Future deleteFromLocal(String id);
  void editLocalData(String id, String title, double amount, DateTime date);
  void initData();
}

class ExpensesControllerImp extends ExpensesController {
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  DateTime addedDate = DateTime.now();
  DateTime repeatDate = DateTime.now();
  DateTime? startDate;
  DateTimeRange pickedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  double expensesAmount = 0.0;
  double expensesTotalAmount = 0.0;
  var isRepeatExpense = false.obs;
  var expensesList = [].obs;
  List localExpesesList = [];
  final ExpensesData _expensesData = ExpensesData();
  TextEditingController addExpensesAmountController = TextEditingController();
  TextEditingController addExpensesTitleController = TextEditingController();
  String? categoryID;
  String? expensesID;
  @override
  Future addExpenses(
    String title,
    double amount,
    DateTime addDate,
    bool isRepeat,
    DateTime repeatedDate,
  ) async {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      final docId = await _expensesData.addExpenses(
        userID,
        addDate,
        amount,
        isRepeat,
        repeatedDate,
        title,
        categoryID!,
      );
      expensesID = docId;
      await saveExpensesInLocal();
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
      _expensesData.getExpenses(userID, categoryID!).listen((event) {
        expensesList.value =
            event.docs.where((element) {
              final expenseData = element.data();
              if (expenseData.containsKey("date") &&
                  expenseData["date"] != null) {
                final DateTime expenseDate = expenseData["date"].toDate();
                return (expenseDate.isAtSameMomentAs(pickedDateRange.start) ||
                        expenseDate.isAfter(pickedDateRange.start)) &&
                    (expenseDate.isAtSameMomentAs(pickedDateRange.end) ||
                        expenseDate.isBefore(pickedDateRange.end));
              }
              return false;
            }).toList();
        if (expensesList.isEmpty) {
          statusreqest = Statusreqest.empty;
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
          await addExpenses(
            addExpensesTitleController.text,
            expensesAmount,
            addedDate,
            isRepeatExpense.value,
            repeatDate,
          );
        }

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
      final List<Map<String, dynamic>> localExpensesList =
          services.sharedPreferences
              .getStringList(AppShared.expenses)
              ?.map((e) => Map<String, dynamic>.from(json.decode(e)))
              .toList() ??
          [];

      final title = addExpensesTitleController.text;
      localExpensesList.add({
        "expenses_date":
            "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
        "total_amount": expensesAmount, // double türünde
        "repeat_date":
            "${repeatDate.year.toString().padLeft(4, '0')}-${repeatDate.month.toString().padLeft(2, '0')}-${repeatDate.day.toString().padLeft(2, '0')}",
        "id": expensesID,
        "title": title,
        "category_id": categoryID,
      });

      await services.sharedPreferences.setStringList(
        AppShared.expenses,
        localExpensesList.map((e) => json.encode(e)).toList(),
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
          AppColors.red,
          "خطأ",
          "لقد أدخلت قيمة خاطئة ، يرجى المحاولة مرة أخرى",
        );
      } else {
        editLocalData(
          id,
          addExpensesTitleController.text,
          expensesAmount,
          repeatDate,
        );
        await _expensesData.editExpenses(
          userID,
          addedDate,
          expensesAmount,
          isRepeatExpense.value,
          repeatDate,
          addExpensesTitleController.text,
          id,
          categoryID!,
        );
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
    DateTime addDate,
    bool isRepeat,
    DateTime date,
    String id,
  ) {
    // title
    addExpensesTitleController.text = title;
    // amount
    addExpensesAmountController.text = amount.toString();
    // date
    addedDate = addDate;
    // isRepeatExpense
    isRepeatExpense.value = isRepeat;
    // date type
    repeatDate = date;
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
      deleteFromLocal(id);
      await _expensesData.deleteExpenses(userID, id, categoryID!);
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
  Future addExpensesAutomatically() async {
    if (services.sharedPreferences.getStringList(AppShared.expenses) != null) {
      final expenses = services.sharedPreferences.getStringList(
        AppShared.expenses,
      );

      try {
        if (expenses != null) {
          localExpesesList =
              expenses
                  .map((e) => Map<String, dynamic>.from(json.decode(e)))
                  .toList();

          for (var expensesElement in localExpesesList) {
            final amount = expensesElement["total_amount"];
            final addedDate = expensesElement["expenses_date"];
            final repeatDate = expensesElement["repeat_date"];
            final title = expensesElement["title"];
            categoryID = expensesElement["category_id"];
            final rDate = DateTime.parse(repeatDate);
            final aDate = DateTime.parse(addedDate);
            if (rDate.day == DateTime.now().day) {
              await addExpenses(title, amount, aDate, false, rDate);
            } else {
              break;
            }
          }
        }

        statusreqest = Statusreqest.success;
        update();
      } on Exception {
        statusreqest = Statusreqest.faliure;
        update();
      }
    }
  }

  @override
  Future saveStartDate() async {
    statusreqest = Statusreqest.loading;
    update();
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
    statusreqest = Statusreqest.success;
    update();
  }

  @override
  Future deleteFromLocal(String id) async {
    if (services.sharedPreferences.getStringList(AppShared.expenses) != null) {
      final expenses = services.sharedPreferences.getStringList(
        AppShared.expenses,
      );
      try {
        if (expenses != null) {
          localExpesesList =
              expenses
                  .map((e) => Map<String, dynamic>.from(json.decode(e)))
                  .toList();

          localExpesesList =
              localExpesesList.where((expensesElement) {
                final localId = expensesElement["id"];
                return localId != id;
              }).toList();

          await services.sharedPreferences.setStringList(
            AppShared.expenses,
            localExpesesList.map((e) => json.encode(e)).toList(),
          );
        }
      } on Exception {
        statusreqest = Statusreqest.faliure;
        update();
      }
    }
  }

  @override
  void initData() async {
    final args = Get.arguments;
    if (args != null &&
        args.containsKey("category_id") &&
        args["category_id"] != null) {
      categoryID = await args["category_id"];
      await saveStartDate();
      getExpenses();
    }
  }

  @override
  void editLocalData(
    String id,
    String title,
    double amount,
    DateTime date,
  ) async {
    if (services.sharedPreferences.getStringList(AppShared.expenses) != null) {
      final expenses = services.sharedPreferences.getStringList(
        AppShared.expenses,
      );
      try {
        if (expenses != null) {
          localExpesesList =
              expenses
                  .map((e) => Map<String, dynamic>.from(json.decode(e)))
                  .toList();

          for (int i = 0; i < localExpesesList.length; i++) {
            if (localExpesesList[i]["id"] == id) {
              localExpesesList[i]["title"] = title;
              localExpesesList[i]["total_amount"] = amount;
              localExpesesList[i]["expenses_date"] =
                  "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
              break;
            }
          }

          await services.sharedPreferences.setStringList(
            AppShared.expenses,
            localExpesesList.map((e) => json.encode(e)).toList(),
          );
          log(
            services.sharedPreferences
                .getStringList(AppShared.expenses)
                .toString(),
          );
        }
      } on Exception {
        statusreqest = Statusreqest.faliure;
        update();
      }
    }
  }

  @override
  void onInit() async {
    initData();
    super.onInit();
  }
}
