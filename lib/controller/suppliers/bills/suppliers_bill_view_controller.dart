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
  searchForBillBayCity(String city_name);
  searchByDate(DateTime searchStartDate, DateTime searchEndDate);
  goToDetailsPage(String bill_id);
  updateBillStaus(String bill_status, String bill_id);
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
  searchForBillsBaySupplierName() {
    String search = searchBillsTextController.text;
    if (search.isEmpty) {
      getSuppliersBills();
    } else {
      supplier_bills_list.value =
          supplier_bills_list.where((doc) {
            final data = doc.data();
            final supplier_name =
                data["supplier_name"].toString().toLowerCase();

            final bill_id = data["bill_no"].toString().toLowerCase();
            if (supplier_name.contains(search.toLowerCase()) ||
                bill_id.contains(search.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          }).toList();
      if (supplier_bills_list.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
      update();
    }
  }

  @override
  searchForBillBayCity(String city_name) {
    if (city_name.isEmpty || city_name == "جميع المدن") {
      getSuppliersBills();
    } else {
      supplier_bills_list.value =
          supplier_bills_list.where((doc) {
            final data = doc.data();
            final fileView = data["supplier_city"].toLowerCase();
            return fileView.contains(city_name.toLowerCase());
          }).toList();
      if (supplier_bills_list.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
      selectedSupplierCity = city_name;
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
        statusreqest = Statusreqest.noData;
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
  goToDetailsPage(String bill_id) {
    Get.toNamed(
      AppRoutes.supplier_bill_details_page,
      arguments: {"bill_id": bill_id},
    );
  }

  @override
  Future updateBillStaus(String bill_status, String bill_id) async {
    try {
      String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      statusreqest = Statusreqest.loading;
      update();

      await supplierBillData.updateBillStatus(userID, bill_id, bill_status);
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
