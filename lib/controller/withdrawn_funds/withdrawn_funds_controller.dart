import 'dart:convert';
import 'dart:developer';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/withdrawn_fund/withdrawn_fund_data.dart';
import 'package:erad/view/custom_widgets/custom_set_date_range.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_view/widgets/custom_add_withdrawn_funds_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

abstract class WithdrawnFundsController extends GetxController {
  Future addWithdrawnFunds(
    String userName,
    double amount,
    DateTime addDate,
    bool isRepeat,
    DateTime repeatedDate,
  );
  void getWithdrawnFunds();
  void showaddWithdrawnFundsDialog();
  void setDate(DateTime date);
  void toggleRepeatWithdrawnFunds();
  void setRepeatDate(DateTime type);
  void saveWithdrawnFundsInLocal();
  void showEditDialog(
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
  void calculateTotalWithdrawnFunds();
  void addWithdrawnFundsAutomatically();
  Future saveStartDate();
  Future deleteFromLocal(String id);
  void editLocalData(String id, String userName, double amount, DateTime date);
  void initData();
}

class WithdrawnFundsControllerImp extends WithdrawnFundsController {
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  DateTime addedDate = DateTime.now();
  DateTime repeatDate = DateTime.now();
  DateTime? startDate;
  DateTimeRange pickedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  double withdrawnFundsAmount = 0.0;
  double withdrawnFundsTotalAmount = 0.0;
  var isRepeatWithdrawnFunds = false.obs;
  var withdrawnFundsList = [].obs;
  List localWithdrawnFundsList = [];
  final WithdrawnFundData _withdrawnFundData = WithdrawnFundData();
  TextEditingController addWithdrawnFundAmountController =
      TextEditingController();
  String? categoryID;
  String? withdrawnFundsID;
  @override
  Future addWithdrawnFunds(
    String userName,
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
      final docId = await _withdrawnFundData.addWithdrawnFund(
        userID,
        addDate,
        amount,
        isRepeat,
        repeatedDate,
        userName,
        categoryID!,
      );
      withdrawnFundsID = docId;
      await saveWithdrawnFundsInLocal();
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
      _withdrawnFundData.getWithdrawnFund(userID, categoryID!).listen((event) {
        withdrawnFundsList.value =
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
        if (withdrawnFundsList.isEmpty) {
          statusreqest = Statusreqest.empty;
        } else {
          calculateTotalWithdrawnFunds();
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
  void showaddWithdrawnFundsDialog() {
    Get.defaultDialog(
      backgroundColor: AppColors.backgroundColor,
      buttonColor: AppColors.primary,
      title: "أضف سحب الأموال",
      titleStyle: TextStyle(
        color: AppColors.grey,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      onConfirm: () async {
        if (addWithdrawnFundAmountController.text.isEmpty ||
            double.tryParse(addWithdrawnFundAmountController.text) == null) {
          custom_snackBar(
            AppColors.red,
            "خطأ",
            "لقد أدخلت قيمة خاطئة ، يرجى المحاولة مرة أخرى",
          );
        } else {
          withdrawnFundsAmount = double.parse(
            addWithdrawnFundAmountController.text,
          );
          await addWithdrawnFunds(
            categoryID!,
            withdrawnFundsAmount,
            addedDate,
            isRepeatWithdrawnFunds.value,
            repeatDate,
          );
        }

        addWithdrawnFundAmountController.clear();
        isRepeatWithdrawnFunds.value = false;
        repeatDate = DateTime.now();
        Get.back();
      },
      onCancel: () {
        addWithdrawnFundAmountController.clear();

        isRepeatWithdrawnFunds.value = false;
        repeatDate = DateTime.now();
      },
      content: CustomAddExpensesDialog(
        countController: addWithdrawnFundAmountController,
      ),
    );
  }

  @override
  void setDate(DateTime date) {
    addedDate = date;
    update();
  }

  @override
  void toggleRepeatWithdrawnFunds() {
    isRepeatWithdrawnFunds.value = !isRepeatWithdrawnFunds.value;
    update();
  }

  @override
  void setRepeatDate(DateTime date) {
    repeatDate = date;
    update();
  }

  @override
  Future saveWithdrawnFundsInLocal() async {
    if (isRepeatWithdrawnFunds.value == true) {
      final List<Map<String, dynamic>> localExpensesList =
          services.sharedPreferences
              .getStringList(AppShared.expenses)
              ?.map((e) => Map<String, dynamic>.from(json.decode(e)))
              .toList() ??
          [];

      localExpensesList.add({
        "expenses_date":
            "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
        "total_amount": withdrawnFundsAmount, // double türünde
        "repeat_date":
            "${repeatDate.year.toString().padLeft(4, '0')}-${repeatDate.month.toString().padLeft(2, '0')}-${repeatDate.day.toString().padLeft(2, '0')}",
        "id": withdrawnFundsID,
        "userName": categoryID!,
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
      withdrawnFundsAmount = double.parse(
        addWithdrawnFundAmountController.text,
      );
      if (double.parse(addWithdrawnFundAmountController.text).isNaN) {
        custom_snackBar(
          AppColors.red,
          "خطأ",
          "لقد أدخلت قيمة خاطئة ، يرجى المحاولة مرة أخرى",
        );
      } else {
        editLocalData(id, categoryID!, withdrawnFundsAmount, repeatDate);
        await _withdrawnFundData.editWithdrawnFund(
          userID,
          addedDate,
          withdrawnFundsAmount,
          isRepeatWithdrawnFunds.value,
          repeatDate,
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
    double amount,
    DateTime addDate,
    bool isRepeat,
    DateTime date,
    String id,
  ) {
    // amount
    addWithdrawnFundAmountController.text = amount.toString();
    // date
    addedDate = addDate;
    // isRepeatExpense
    isRepeatWithdrawnFunds.value = isRepeat;
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
        addWithdrawnFundAmountController.clear();
        isRepeatWithdrawnFunds.value = false;
        repeatDate = DateTime.now();
        Get.back();
      },
      onCancel: () {
        addWithdrawnFundAmountController.clear();
        isRepeatWithdrawnFunds.value = false;
        repeatDate = DateTime.now();
      },
      content: CustomAddExpensesDialog(
        countController: addWithdrawnFundAmountController,
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
      await _withdrawnFundData.deleteWithdrawnFund(userID, id, categoryID!);
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
      getWithdrawnFunds();
    });
  }

  @override
  void calculateTotalWithdrawnFunds() {
    withdrawnFundsTotalAmount = 0.0;
    for (var total in withdrawnFundsList) {
      final amount = total["amount"];
      withdrawnFundsTotalAmount = amount + withdrawnFundsTotalAmount;
    }
  }

  @override
  Future addWithdrawnFundsAutomatically() async {
    if (services.sharedPreferences.getStringList(AppShared.expenses) != null) {
      final expenses = services.sharedPreferences.getStringList(
        AppShared.expenses,
      );

      try {
        if (expenses != null) {
          localWithdrawnFundsList =
              expenses
                  .map((e) => Map<String, dynamic>.from(json.decode(e)))
                  .toList();

          for (var expensesElement in localWithdrawnFundsList) {
            final amount = expensesElement["total_amount"];
            final addedDate = expensesElement["expenses_date"];
            final repeatDate = expensesElement["repeat_date"];
            final userName = expensesElement["userName"];
            categoryID = expensesElement["category_id"];
            final rDate = DateTime.parse(repeatDate);
            final aDate = DateTime.parse(addedDate);
            if (rDate.day == DateTime.now().day) {
              await addWithdrawnFunds(userName, amount, aDate, false, rDate);
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
          localWithdrawnFundsList =
              expenses
                  .map((e) => Map<String, dynamic>.from(json.decode(e)))
                  .toList();

          localWithdrawnFundsList =
              localWithdrawnFundsList.where((expensesElement) {
                final localId = expensesElement["id"];
                return localId != id;
              }).toList();

          await services.sharedPreferences.setStringList(
            AppShared.expenses,
            localWithdrawnFundsList.map((e) => json.encode(e)).toList(),
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
      getWithdrawnFunds();
    }
  }

  @override
  void editLocalData(
    String id,
    String userName,
    double amount,
    DateTime date,
  ) async {
    if (services.sharedPreferences.getStringList(AppShared.expenses) != null) {
      final expenses = services.sharedPreferences.getStringList(
        AppShared.expenses,
      );
      try {
        if (expenses != null) {
          localWithdrawnFundsList =
              expenses
                  .map((e) => Map<String, dynamic>.from(json.decode(e)))
                  .toList();

          for (int i = 0; i < localWithdrawnFundsList.length; i++) {
            if (localWithdrawnFundsList[i]["id"] == id) {
              localWithdrawnFundsList[i]["userName"] = userName;
              localWithdrawnFundsList[i]["total_amount"] = amount;
              localWithdrawnFundsList[i]["expenses_date"] =
                  "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
              break;
            }
          }

          await services.sharedPreferences.setStringList(
            AppShared.expenses,
            localWithdrawnFundsList.map((e) => json.encode(e)).toList(),
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
