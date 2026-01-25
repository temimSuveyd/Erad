import 'dart:developer';

import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/function/add_monthly.dart';
import 'package:erad/core/function/calculate_total_amount.dart';
import 'package:erad/core/function/group_and_sum_monthly_totals.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/customer/customer_bill_data.dart';
import 'package:erad/data/data_score/remote/depts/customer_depts_data.dart';
import 'package:erad/data/data_score/remote/depts/supplier_depts_data.dart';
import 'package:erad/data/data_score/remote/expenses/expenses_data.dart';
import 'package:erad/data/data_score/remote/withdrawn_fund/withdrawn_fund_data.dart';
import 'package:get/get.dart';

abstract class ReportsController extends GetxController {
  void changeUser(String userId);
  void debtCheckChanged();
  // get data
  void getAllCustomerBills();
  void getAllExpenses();
  void getWithdrawnFunds();
  void getAllCustomerDepts();
  void getAllSupplierDepts();
  void getAllUsers();
  // calculate monthly amount
  void calculationTotalMonthlyEarning();
  void calculationTotalMonthlyExpenses();
  void calculationTotalMonthlyWithdrawnFunds();

  // calculate total amount
  void calculatingTotalCustomerDepts();
  void calculatingTotalSupplierDepts();
  void calculatingTotalErnings();
  void calculatingTotalExpenses();
  void calculatingTotalWithdrawnFunds();
  void setYear(int year);
}

class ReportsControllerImpl extends ReportsController {
  CustomerBillData customerBillData = CustomerBillData();
  CustomerDeptsData customerDeptsData = CustomerDeptsData();
  SupplierDeptsData supplierDeptsData = SupplierDeptsData();

  ExpensesData expensesData = ExpensesData();
  WithdrawnFundData withdrawnFundData = WithdrawnFundData();

  var customerBillList = [].obs;
  var expensesList = [].obs;
  var withdrawnFundList = [].obs;
  var customerDeptsList = [].obs;
  var supplierDeptsList = [].obs;
  var allUsersList = ["all"].obs;
  List allUsersNameList = ["الكل"];
  // calculated list
  List totalEraningsMonthly = [];
  List totalExpensesMonthly = [];
  List totalWithdrawnFundsMonthly = [];

  // calculated double
  double totalCustomerDepts = 0.0;
  double totalSupplierDepts = 0.0;
  double totalEarning = 0.0;
  double totalExpenses = 0.0;
  double totalWithdrawnFunds = 0.0;
  // page data
  Statusreqest statusreqest = Statusreqest.loading;
  Services services = Get.find();
  DateTime selectedDate = DateTime.now();
  String? selectedUserId;
  bool includeDebts = false;
  // ui lists
  List chartsLists = [];
  List cardsList = [0.0, 0.0, 0.0, 0.0, 0.0];

  @override
  void getAllCustomerBills() {
    statusreqest = Statusreqest.loading;
    update();
    final String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      customerBillData.getAllBils(userID).listen((event) {
        customerBillList.value = event.docs;
        customerBillList.value =
            customerBillList.where((data) {
              return data['paymet_type'] == 'monetary' &&
                  data['bill_status'] == 'deliveryd' &&
                  data['bill_date'].toDate().year == selectedDate.year;
            }).toList();
        calculationTotalMonthlyEarning();
        calculatingTotalErnings();
        statusreqest = Statusreqest.success;
        update();
      });
    } on Exception {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void getAllExpenses() {
    statusreqest = Statusreqest.loading;
    update();
    final String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      expensesList.clear();
      expensesData.getExpensesCategory(userID).listen((event) async {
        List allExpenses = [];
        for (var data in event.docs) {
          final String categoryID = data.id;
          final docs =
              (await expensesData.getExpenses(userID, categoryID).first).docs;
          final filteredDocs =
              docs.where((exp) {
                final expDate = exp['date'].toDate();
                return expDate.year == selectedDate.year;
              }).toList();
          allExpenses.addAll(filteredDocs);
        }
        expensesList.value = allExpenses;
        calculationTotalMonthlyExpenses();
        calculatingTotalExpenses();
        calculatingTotalErnings();
        statusreqest = Statusreqest.success;
        update();
      });
    } on Exception catch (_) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void getAllUsers() {
    statusreqest = Statusreqest.loading;
    update();
    final String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      withdrawnFundData.getWithdrawnFundCategory(userID).listen((event) {
        for (var data in event.docs) {
          final String categoryID = data.id;
          final userName = data["userId"];
          allUsersList.add(categoryID);
          allUsersNameList.add(userName);
        }
        getWithdrawnFunds();
      });
    } on Exception catch (_) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void getWithdrawnFunds() async {
    withdrawnFundList.clear();
    statusreqest = Statusreqest.loading;
    update();
    final userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      final users =
          (selectedUserId == null || selectedUserId == "all")
              ? allUsersList
              : [selectedUserId!];
      for (var user in users) {
        final docs =
            (await withdrawnFundData.getWithdrawnFund(userID, user).first).docs;
        final filteredDocs =
            docs.where((doc) {
              final docDate = doc['date'].toDate();
              return docDate.year == selectedDate.year;
            }).toList();
        withdrawnFundList.addAll(filteredDocs);
      }
      calculatingTotalWithdrawnFunds();
      calculationTotalMonthlyWithdrawnFunds();
      statusreqest = Statusreqest.success;
    } catch (_) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  void getAllCustomerDepts() {
    statusreqest = Statusreqest.loading;
    update();
    final String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      customerDeptsData.getAllDepts(userID).listen((event) {
        customerDeptsList.value = event.docs;
        log(customerDeptsList.toString());
        calculatingTotalCustomerDepts();
        statusreqest = Statusreqest.success;
        update();
      });
    } on Exception catch (_) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void getAllSupplierDepts() {
    statusreqest = Statusreqest.loading;
    update();
    final String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      supplierDeptsData.getAllDepts(userID).listen((event) {
        supplierDeptsList.value = event.docs;
        calculatingTotalSupplierDepts();
        statusreqest = Statusreqest.success;
        update();
      });
    } on Exception catch (_) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  // monthly
  @override
  void calculationTotalMonthlyEarning() {
    if (customerBillList.isNotEmpty) {
      totalEraningsMonthly.clear();
      addMonthly(
        "total_profits",
        "bill_date",
        customerBillList,
        totalEraningsMonthly,
      );
      groupAndSumMonthlyTotals("amount", totalEraningsMonthly);
      update();
    }
  }

  @override
  void calculationTotalMonthlyExpenses() {
    if (expensesList.isNotEmpty) {
      addMonthly("amount", "date", expensesList, totalExpensesMonthly);
      groupAndSumMonthlyTotals("amount", totalExpensesMonthly);
      chartsLists.add(totalExpensesMonthly);
      update();
    }
  }

  @override
  void calculationTotalMonthlyWithdrawnFunds() {
    totalWithdrawnFundsMonthly.clear();
    if (withdrawnFundList.isNotEmpty) {
      addMonthly(
        "amount",
        "date",
        withdrawnFundList,
        totalWithdrawnFundsMonthly,
      );
      groupAndSumMonthlyTotals("amount", totalWithdrawnFundsMonthly);
      if (chartsLists.length > 1) {
        chartsLists[1] = totalWithdrawnFundsMonthly;
      } else if (chartsLists.length == 1) {
        chartsLists.add(totalWithdrawnFundsMonthly);
      } else {
        chartsLists.add([]);
        chartsLists.add(totalWithdrawnFundsMonthly);
      }

      update();
    }
  }

  // total
  @override
  void calculatingTotalCustomerDepts() {
    totalCustomerDepts = calculateTotalAmount(customerDeptsList, "total_price");
    cardsList[2] = totalCustomerDepts;
  }

  @override
  void calculatingTotalSupplierDepts() {
    totalSupplierDepts = calculateTotalAmount(supplierDeptsList, "total_price");
    cardsList[1] = totalSupplierDepts;
    update();
  }

  @override
  void calculatingTotalExpenses() {
    totalExpenses = calculateTotalAmount(expensesList, "amount");
    cardsList[3] = totalExpenses;
  }

  @override
  void calculatingTotalErnings() {
    totalEarning = calculateTotalAmount(customerBillList, "total_profits");
    totalEarning = totalEarning - totalExpenses;
    if (includeDebts == true) {
      totalEarning = totalEarning - totalCustomerDepts;
    }
    cardsList[0] = totalEarning;
    update();
  }

  @override
  void calculatingTotalWithdrawnFunds() {
    totalWithdrawnFunds = 0;
    if (withdrawnFundList.isNotEmpty) {
      for (var data in withdrawnFundList) {
        final amount = data["amount"];
        totalWithdrawnFunds = amount + totalWithdrawnFunds;
      }
      cardsList[4] = totalWithdrawnFunds;
    }
    update();
  }

  @override
  void changeUser(String userId) {
    selectedUserId = userId;
    getWithdrawnFunds();
    update();
  }

  @override
  void debtCheckChanged() {
    includeDebts = !includeDebts;
    calculatingTotalErnings();
    update();
  }

  @override
  void onInit() {
    chartsLists.clear();
    cardsList = [0.0, 0.0, 0.0, 0.0, 0.0];
    getAllCustomerBills();
    getAllSupplierDepts();
    getAllCustomerDepts();
    getAllExpenses();
    getAllUsers();
    update();

    super.onInit();
  }

  @override
  void setYear(int year) {
    selectedDate = DateTime(year);
    chartsLists.clear();
    cardsList = [0.0, 0.0, 0.0, 0.0, 0.0];
    getAllCustomerBills();
    getAllSupplierDepts();
    getAllCustomerDepts();
    getAllExpenses();
    getAllUsers();
    update();
  }
}
