import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/depts/supplier_depts_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class SupplierDeptsViewController extends GetxController {
  searchForBillsBaySupplierName();
  searchForBillBayCity(String city_name);
  searchByDate(DateTime searchStartDate, DateTime searchEndDate);
  getDepts();
  goTODetailsPage(String dept_id);
}

class SupplierDeptsViewControllerImp extends SupplierDeptsViewController {
  final SupplierDeptsData _supplierDeptsData = SupplierDeptsData();
  final Services services = Get.find();
  var supplierDeptsList = [].obs;
  String selectedSupplierCity = "حدد المدينة";
  Statusreqest statusreqest = Statusreqest.success;
  final TextEditingController searchDeptsTextController =
      TextEditingController();
  String? selectedStartDate;
  String? selectedEndDate;

  @override
  getDepts() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _supplierDeptsData.getAllDepts(userID).listen((event) {
        supplierDeptsList.value = event.docs;
        if (supplierDeptsList.isEmpty) {
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
    String search = searchDeptsTextController.text;
    if (search.isEmpty) {
      getDepts();
    } else {
      supplierDeptsList.value =
          supplierDeptsList.where((doc) {
            final data = doc.data();
            final customer_name =
                data["supplier_name"].toString().toLowerCase();
            final bill_id = data["bill_no"].toString().toLowerCase();
            if (customer_name.contains(search.toLowerCase()) ||
                bill_id.contains(search.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          }).toList();
      if (supplierDeptsList.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
      update();
    }
  }

  @override
  searchForBillBayCity(String city_name) {
    if (city_name.isEmpty || city_name == "جميع المدن") {
      getDepts();
    } else {
      supplierDeptsList.value =
          supplierDeptsList.where((doc) {
            final data = doc.data();
            final fileView = data["supplier_city"].toLowerCase();
            return fileView.contains(city_name.toLowerCase());
          }).toList();
      if (supplierDeptsList.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
      selectedSupplierCity = city_name;
    }
    update();
  }

  @override
  searchByDate(DateTime searchStartDate, DateTime searchEndDate) {
    try {
      selectedStartDate = _formatDate(searchStartDate);
      selectedEndDate = _formatDate(searchEndDate);

      // Filter bills within date range
      supplierDeptsList.value =
          supplierDeptsList.where((doc) {
            final data = doc.data();
            final DateTime billDate = (data["bill_date"] as Timestamp).toDate();

            // Check if bill date is within range (inclusive)
            return billDate.isAfter(
                  searchStartDate.subtract(const Duration(days: 1)),
                ) &&
                billDate.isBefore(searchEndDate.add(const Duration(days: 1)));
          }).toList();

      // Update status if no results found
      if (supplierDeptsList.isEmpty) {
        statusreqest = Statusreqest.noData;
      }

      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  goTODetailsPage(String dept_id) {
    Get.toNamed(
      AppRoutes.supplier_depts_details_page,
      arguments: {"dept_id": dept_id},
    );
  }

  @override
  void onInit() {
    getDepts();
    super.onInit();
  }
}
