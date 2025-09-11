import 'dart:developer';

import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/customer/customer_bill_data.dart';
import 'package:get/get.dart';

abstract class ReportsController extends GetxController {
  void getAllCustomerBills();
  void totalMonthlyEarningCalculation();
}

class ReportsControllerImpl extends ReportsController {
  CustomerBillData customerBillData = CustomerBillData();
  var customerBillList = [].obs;
  List chartsLists = [];
  List totalERaningsMonthly = [];
  Statusreqest statusreqest = Statusreqest.loading;
  Services services = Get.find();
  DateTime selectedDate = DateTime.now();
  double totalEarning = 0.0;

  @override
  void getAllCustomerBills() {
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
        totalMonthlyEarningCalculation();
        statusreqest = Statusreqest.success;
      });
    } on Exception catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void totalMonthlyEarningCalculation() {
    if (customerBillList.isNotEmpty) {
      _addMonthly("total_profits", customerBillList, totalERaningsMonthly);
      _groupAndSumMonthlyTotals("amount", totalERaningsMonthly);
      chartsLists.add(totalERaningsMonthly);
      update();
    }
  }

  @override
  void onInit() {
    getAllCustomerBills();
    super.onInit();
  }
}

void _addMonthly(String dataType, List dataList, List totalList) {
  for (var data in dataList) {
    final int month = data["bill_date"].toDate().month;
    totalList.add({"index": month, "amount": data[dataType]});
    totalList.sort((a, b) => a["index"].compareTo(b["index"]));
  }
}

_groupAndSumMonthlyTotals(String dataType, List totalList) {
  Map<int, double> monthlyTotals = {};

  for (var item in totalList) {
    final int monthIndex = item["index"];
    final double amount =
        (item[dataType] is int)
            ? (item[dataType] as int).toDouble()
            : (item[dataType] is double)
            ? item[dataType]
            : 0.0;
    if (monthlyTotals.containsKey(monthIndex)) {
      monthlyTotals[monthIndex] = monthlyTotals[monthIndex]! + amount;
    } else {
      monthlyTotals[monthIndex] = amount;
    }
  }

  totalList.clear();
  monthlyTotals.forEach((month, amount) {
    totalList.add({"index": month, dataType: amount});
  });

  log(totalList.toString());
}
