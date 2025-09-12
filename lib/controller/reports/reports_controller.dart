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
import 'package:get/get.dart';

abstract class ReportsController extends GetxController {
  // get data from api
  void getAllCustomerBills();
  void getAllExpenses();
  void getAllCustomerDepts();
  void getAllSupplierDepts();
  // calculate monthly data
  void calculationTotalMonthlyEarning();
  void calculationTotalMonthlyExpenses();
  // calculate total data
  void calculatingTotalCustomerDepts();
  void calculatingTotalSupplierDepts();
  void calculatingTotalErnings();
  void calculatingTotalExpenses();
}

class ReportsControllerImpl extends ReportsController {
  CustomerBillData customerBillData = CustomerBillData();
  CustomerDeptsData customerDeptsData = CustomerDeptsData();
  SupplierDeptsData supplierDeptsData = SupplierDeptsData();

  ExpensesData expensesData = ExpensesData();

  var customerBillList = [].obs;
  var expensesList = [].obs;
  var customerDeptsList = [].obs;
  var supplierDeptsList = [].obs;

  // calculated list
  List totalEraningsMonthly = [];
  List totalExpensesMonthly = [];
  // calculated double
  double totalCustomerDepts = 0.0;
  double totalSupplierDepts = 0.0;
  double totalEarning = 0.0;
  double totalExpenses = 0.0;

  Statusreqest statusreqest = Statusreqest.loading;

  Services services = Get.find();
  DateTime selectedDate = DateTime.now();
  List chartsLists = [];
  List cardsList = [];
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
    } on Exception catch (e) {
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
      expensesData.getExpensesCategory(userID).listen((event) {
        for (var data in event.docs) {
          final String categoryID = data.id;
          expensesData.getExpenses(userID, categoryID).listen((event) {
            expensesList.value = event.docs;
            calculationTotalMonthlyExpenses();
            calculatingTotalExpenses();
            statusreqest = Statusreqest.success;
            update();
          });
        }
      });
    } on Exception catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
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
        calculatingTotalCustomerDepts();
        statusreqest = Statusreqest.success;
        update();
      });
    } on Exception catch (e) {
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
    } on Exception catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  // monthly
  @override
  void calculationTotalMonthlyEarning() {
    if (customerBillList.isNotEmpty) {
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

  // total
  @override
  void calculatingTotalCustomerDepts() {
    totalCustomerDepts = calculateTotalAmount(customerDeptsList, "total_price");
    cardsList.add(totalCustomerDepts);
  }

  @override
  void calculatingTotalSupplierDepts() {
    totalSupplierDepts = calculateTotalAmount(supplierDeptsList, "total_price");
    cardsList.add(totalSupplierDepts);
  }

  @override
  void calculatingTotalErnings() {
    totalEarning = calculateTotalAmount(customerBillList, "total_profits");
    cardsList.add(totalEarning);
  }

  @override
  void calculatingTotalExpenses() {
    totalExpenses = calculateTotalAmount(expensesList, "amount");
    cardsList.add(totalExpenses);
  }

  @override
  void onInit() {
    chartsLists.clear();
    // monthly
    getAllCustomerBills();
    getAllCustomerDepts();
    getAllSupplierDepts();
    getAllExpenses();

    update();
    super.onInit();
  }
}
















  // @override
  // void getAllSupplierDepts() {
  //   statusreqest = Statusreqest.loading;
  //   update();
  //   final String userID =
  //       services.sharedPreferences.getString(AppShared.userID)!;
  //   try {
  //     supplierDeptsData.getAllDepts(userID).listen((event) {
  //       supplierDeptsList.value = event.docs;
  //       calculatingTotalSupplierDepts();
  //       statusreqest = Statusreqest.success;
  //       update();
  //     });
  //   } on Exception catch (e) {
  //     statusreqest = Statusreqest.faliure;
  //     update();
  //   }
  // }

  // @override
  // void calculatingMyTotalMoney() {
  //   if (customerBillList.isNotEmpty) {
  //     _addMonthly(
  //       "total_product_price",
  //       "bill_date",
  //       customerBillList,
  //       totalMyMoneyList,
  //     );
  //     _groupAndSumMonthlyTotals("amount", totalMyMoneyList);
  //     chartsLists.add(totalMyMoneyList);
  //     update();
  //   }
  // }



  // @override
  // void calculatingTotalSupplierDepts() {
  //   if (supplierDeptsList.isNotEmpty) {
  //     _addMonthly(
  //       "total_price",
  //       "bill_date",
  //       supplierDeptsList,
  //       totalSupplierDeptsList,
  //     );
  //     _groupAndSumMonthlyTotals("amount", totalSupplierDeptsList);
  //     chartsLists.add(totalSupplierDeptsList);
  //     update();
  //   }
  // }