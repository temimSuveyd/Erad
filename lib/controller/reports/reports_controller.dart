
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
  bool includeDebts = true;
  // ui lists
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
                  data['bill_status'] == 'deliveryd'
              // &&data['bill_date'].toDate().year == selectedDate.year
              ;
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
    } on Exception catch (e) {
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
        withdrawnFundList.addAll(docs);
      }
      calculatingTotalWithdrawnFunds();
      calculationTotalMonthlyWithdrawnFunds();
      statusreqest = Statusreqest.success;
    } catch (e) {
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
      totalEraningsMonthly.clear();
      addMonthly(
        "total_profits",
        "bill_date",
        customerBillList,
        totalEraningsMonthly,
      );
      if (includeDebts) {
      groupAndSumMonthlyTotals("amount", totalEraningsMonthly, debts: totalCustomerDepts,expenses: totalExpenses,includeDebts: true);
      }else{
      groupAndSumMonthlyTotals("amount", totalEraningsMonthly,);

      }
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
    if (includeDebts) {
      totalEarning = totalEarning - totalCustomerDepts - totalExpenses;
    }
    if (cardsList.length >= 1) {
      cardsList[0] = totalEarning;
    } else {
      cardsList.add(totalEarning);
    }
  }

  @override
  void calculatingTotalExpenses() {
    totalExpenses = calculateTotalAmount(expensesList, "amount");
    cardsList.add(totalExpenses);
  }

  @override
  void calculatingTotalWithdrawnFunds() {
    totalWithdrawnFunds = 0;
    if (withdrawnFundList.isNotEmpty) {
      for (var data in withdrawnFundList) {
        final amount = data["amount"];
        totalWithdrawnFunds = amount + totalWithdrawnFunds;
      }
      if (cardsList.length >= 5) {
        cardsList[4] = totalWithdrawnFunds;
      } else if (cardsList.length < 5) {
        while (cardsList.length < 4) {
          cardsList.add(0.0);
        }
        cardsList.add(totalWithdrawnFunds);
      }
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
    if (includeDebts == true) {
      includeDebts = false;
    } else {
      includeDebts = true;
    }
    getAllCustomerBills();
    update();
  }

  @override
  void onInit() {
    chartsLists.clear();
    cardsList.clear();
    // monthly
    getAllCustomerBills();
    getAllCustomerDepts();
    getAllSupplierDepts();
    getAllExpenses();
    getAllUsers();
    update();
    super.onInit();
  }
}
