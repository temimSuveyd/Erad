import 'package:erad/core/function/is_date_in_range.dart';
import 'package:erad/core/function/save_started_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/customer/customer_bill_data.dart';

abstract class CustomerBillViewController extends GetxController {
  void getCustomersBills();
  void searchForBillsBayCustomerName();
  void searchForBillBayCity(String cityName);
  void searchByDate(DateTimeRange dateRange);
  void goToDetailsPage(String billId);
  void updateBillStaus(String billStatus, String billId);
}

class CustomerBillViewControllerImp extends CustomerBillViewController {
  CustomerBillData customerBillData = CustomerBillData();
  var customer_bills_list = [].obs;
  Services services = Get.find();
  Statusreqest statusreqest = Statusreqest.success;
  late TextEditingController searchBillsTextController =
      TextEditingController();
  String? selectedCustomerCity;
  DateTimeRange? selectedDateRange;
  DateTime startedDate = DateTime.now();

  @override
  getCustomersBills() {
    statusreqest = Statusreqest.loading;
    update();
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      customerBillData.getAllBils(userID).listen((event) {
        customer_bills_list.value = event.docs;
        customer_bills_list.value =
            customer_bills_list.where((doc) {
              final data = doc.data();
              final DateTime billDate = data["bill_date"].toDate();
              if (selectedDateRange == null) {
                return (billDate.year == startedDate.year &&
                    billDate.month == startedDate.month &&
                    billDate.day == startedDate.day);
              } else {
                return isDateInRange(
                  billDate: billDate,
                  range: selectedDateRange!,
                );
              }
            }).toList();
        if (customer_bills_list.isEmpty) {
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
  searchForBillsBayCustomerName() {
    String search = searchBillsTextController.text;
    if (search.isEmpty) {
      getCustomersBills();
    } else {
      customer_bills_list.value =
          customer_bills_list.where((doc) {
            final data = doc.data();
            final customerName = data["customer_name"].toString().toLowerCase();

            final billId = data["bill_no"].toString().toLowerCase();
            if (customerName.contains(search.toLowerCase()) ||
                billId.contains(search.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          }).toList();
      if (customer_bills_list.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
      update();
    }
  }

  @override
  searchForBillBayCity(String cityName) {
    if (cityName.isEmpty || cityName == "جميع المدن") {
      getCustomersBills();
    } else {
      String userID = services.sharedPreferences.getString(AppShared.userID)!;

      customerBillData.getAllBils(userID).listen((event) {
        customer_bills_list.value = event.docs;
        customer_bills_list.value =
            customer_bills_list.where((doc) {
              final data = doc.data();
              final fileView = data["customer_city"].toLowerCase();
              return fileView.contains(cityName.toLowerCase());
            }).toList();
        if (customer_bills_list.isEmpty) {
          statusreqest = Statusreqest.empty;
        }
        selectedCustomerCity = cityName;
        update();
      });
    }
  }

  @override
  searchByDate(DateTimeRange dateRange) async {
    // String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      selectedDateRange = dateRange;
      getCustomersBills();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  goToDetailsPage(String billId) {
    Get.toNamed(
      AppRoutes.customer_bills_details_page,
      arguments: {"bill_id": billId},
    );
  }

  @override
  Future updateBillStaus(String billStatus, String billId) async {
    try {
      String userID = services.sharedPreferences.getString(AppShared.userID)!;
      statusreqest = Statusreqest.loading;
      update();

      await customerBillData.updateBillStatus(userID, billId, billStatus);
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.success;
    }

    update();
  }

  @override
  void onInit() async {
    getCustomersBills();
    super.onInit();
  }
}




  // customerBillData.getAllBils(userID).listen((event) {
      //   customer_bills_list.value = event.docs;
      //   customer_bills_list.value =
      //       customer_bills_list.where((doc) {
      //         final data = doc.data();
      //         final billDate = data["bill_date"].toDate();
      //         // Tarih aralığı tek bir günse, o günün tüm faturalarını dahil et
      //         if (selectedDateRange!.start.year == selectedDateRange!.end.year &&
      //             selectedDateRange!.start.month == dateRange.end.month &&
      //             dateRange.start.day == dateRange.end.day) {
      //           return billDate.year == dateRange.start.year &&
      //               billDate.month == dateRange.start.month &&
      //               billDate.day == dateRange.start.day;
      //         } else {
      //           // Tarih aralığı ise, başlangıç ve bitiş dahil aradaki tüm faturaları dahil et
      //           final billDateOnly = DateTime(
      //             billDate.year,
      //             billDate.month,
      //             billDate.day,
      //           );
      //           final startOnly = DateTime(
      //             dateRange.start.year,
      //             dateRange.start.month,
      //             dateRange.start.day,
      //           );
      //           final endOnly = DateTime(
      //             dateRange.end.year,
      //             dateRange.end.month,
      //             dateRange.end.day,
      //           );
      //           return (billDateOnly.isAtSameMomentAs(startOnly) ||
      //                   billDateOnly.isAfter(startOnly)) &&
      //               (billDateOnly.isAtSameMomentAs(endOnly) ||
      //                   billDateOnly.isBefore(endOnly));
      //         }
      //       }).toList();
      //   if (customer_bills_list.isEmpty) {
      //     statusreqest = Statusreqest.empty;
      //   }
      //   selectedDateRange = dateRange;
      //   update();
      // });