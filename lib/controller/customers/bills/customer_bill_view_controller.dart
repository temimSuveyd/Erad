import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/customer/customer_bill_data.dart';

abstract class CustomerBillViewController extends GetxController {
  getCustomersBills();
  searchForBillsBayCustomerName();
  searchForBillBayCity(String cityName);
  searchByDate(DateTime searchStartDate, DateTime searchEndDate);
  goToDetailsPage(String billId);
  updateBillStaus(String billStatus, String billId);
}

class CustomerBillViewControllerImp extends CustomerBillViewController {
  CustomerBillData customerBillData = CustomerBillData();
  var customer_bills_list = [].obs;
  Services services = Get.find();
  Statusreqest statusreqest = Statusreqest.success;
  late TextEditingController searchBillsTextController =
      TextEditingController();
  String? selectedCustomerCity;
  String? selectedStartDate;
  String? selectedEndDate;

  @override
  getCustomersBills() {
    statusreqest = Statusreqest.loading;
    update();
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      customerBillData.getAllBils(userID).listen((event) {
        customer_bills_list.value = event.docs;
        if (customer_bills_list.isEmpty) {
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
  searchForBillsBayCustomerName() {
    String search = searchBillsTextController.text;
    if (search.isEmpty) {
      getCustomersBills();
    } else {
      customer_bills_list.value =
          customer_bills_list.where((doc) {
            final data = doc.data();
            final customerName =
                data["customer_name"].toString().toLowerCase();

            final billId = data["bill_no"].toString().toLowerCase();
            if (customerName.contains(search.toLowerCase()) ||
                billId.contains(search.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          }).toList();
      if (customer_bills_list.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
      update();
    }
  }

  @override
  searchForBillBayCity(String cityName) {
    if (cityName.isEmpty || cityName == "جميع المدن") {
      getCustomersBills();
    } else {
      customer_bills_list.value =
          customer_bills_list.where((doc) {
            final data = doc.data();
            final fileView = data["customer_city"].toLowerCase();
            return fileView.contains(cityName.toLowerCase());
          }).toList();
      if (customer_bills_list.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
      selectedCustomerCity = cityName;
    }
    update();
  }

  @override
  searchByDate(DateTime searchStartDate, DateTime searchEndDate) {
    () async {
      Future.microtask(() async {
        try {
          // Reset to all bills first and bekle
          await getCustomersBills();

          // Format dates for display
          selectedStartDate = _formatDate(searchStartDate);
          selectedEndDate = _formatDate(searchEndDate);

          // Filter bills within date range
          customer_bills_list.value =
              customer_bills_list.where((doc) {
                final data = doc.data();
                final billDateRaw = data["bill_date"];
                DateTime? billDate;

                // bill_date null veya yanlış tipte olabilir, kontrol et
                if (billDateRaw is Timestamp) {
                  billDate = billDateRaw.toDate();
                } else if (billDateRaw is DateTime) {
                  billDate = billDateRaw;
                } else {
                  // Hatalı veri, filtreye dahil etme
                  return false;
                }

                // Check if bill date is within range (inclusive)
                return !billDate.isBefore(searchStartDate) &&
                    !billDate.isAfter(searchEndDate);
              }).toList();

          // Update status if no results found
          if (customer_bills_list.isEmpty) {
            statusreqest = Statusreqest.noData;
            update();
          }

          update();
        } catch (e) {
          statusreqest = Statusreqest.faliure;
          update();
          // Hata bildirimi için log ekle
          print("searchByDate hata: $e");
        }
      });
    };
  }

  // Helper method to format dates consistently
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
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
      String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
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
  void onInit() {
    getCustomersBills();
    super.onInit();
  }
}
