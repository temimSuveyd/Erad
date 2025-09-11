import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/Supplier/Supplier_bill_data.dart';

abstract class SuppliersBillViewController extends GetxController {
  getSuppliersBills();
  searchForBillsBaySupplierName();
  searchForBillBayCity(String cityName);
  searchByDate(DateTime searchStartDate, DateTime searchEndDate);
  goToDetailsPage(String billId);
  updateBillStaus(String billStatus, String billId);
}

class SuppliersBillViewControllerImp extends SuppliersBillViewController {
  SupplierBillData supplierBillData = SupplierBillData();
  var supplier_bills_list = [].obs;
  Services services = Get.find();
  Statusreqest statusreqest = Statusreqest.success;
  late TextEditingController searchBillsTextController =
      TextEditingController();
  String? selectedSupplierCity;
  String? selectedStartDate;
  String? selectedEndDate;

  @override
  getSuppliersBills() {
    statusreqest = Statusreqest.loading;
    update();
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      supplierBillData.getAllBils(userID).listen((event) {
        supplier_bills_list.value = event.docs;
        if (supplier_bills_list.isEmpty) {
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
  searchForBillsBaySupplierName() {
    String search = searchBillsTextController.text;
    if (search.isEmpty) {
      getSuppliersBills();
    } else {
      supplier_bills_list.value =
          supplier_bills_list.where((doc) {
            final data = doc.data();
            final supplierName =
                data["supplier_name"].toString().toLowerCase();

            final billId = data["bill_no"].toString().toLowerCase();
            if (supplierName.contains(search.toLowerCase()) ||
                billId.contains(search.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          }).toList();
      if (supplier_bills_list.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
      update();
    }
  }

  @override
  searchForBillBayCity(String cityName) {
    if (cityName.isEmpty || cityName == "جميع المدن") {
      getSuppliersBills();
    } else {
      supplier_bills_list.value =
          supplier_bills_list.where((doc) {
            final data = doc.data();
            final fileView = data["supplier_city"].toLowerCase();
            return fileView.contains(cityName.toLowerCase());
          }).toList();
      if (supplier_bills_list.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
      selectedSupplierCity = cityName;
    }
    update();
  }

  @override
  searchByDate(DateTime searchStartDate, DateTime searchEndDate) {
    try {
      getSuppliersBills();
      selectedStartDate = _formatDate(searchStartDate);
      selectedEndDate = _formatDate(searchEndDate);


      supplier_bills_list.value =
          supplier_bills_list.where((doc) {
            final data = doc.data();
            final DateTime billDate = (data["bill_date"] as Timestamp).toDate();

            // Check if bill date is within range (inclusive)
            return billDate.isAfter(
                  searchStartDate.subtract(const Duration(days: 1)),
                ) &&
                billDate.isBefore(searchEndDate.add(const Duration(days: 1)));
          }).toList();

      if (supplier_bills_list.isEmpty) {
        statusreqest = Statusreqest.empty;
      }

      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  // Helper method to format dates consistently
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  goToDetailsPage(String billId) {
    Get.toNamed(
      AppRoutes.supplier_bill_details_page,
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

      await supplierBillData.updateBillStatus(userID, billId, billStatus);
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.success;
    }

    update();
  }

  @override
  void onInit() {
    getSuppliersBills();
    super.onInit();
  }
}
