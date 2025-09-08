import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/depts/customer_depts_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class CustomerDeptsViewController extends GetxController {
  searchForBillsBayCustomerName();
  searchForBillBayCity(String cityName);
  searchByDate(DateTime searchStartDate, DateTime searchEndDate);
  getDepts();
  goTODetailsPage(String deptId);
}

class CustomerDeptsViewControllerImp extends CustomerDeptsViewController {
  final CustomerDeptsData _customerDeptsData = CustomerDeptsData();
  final Services services = Get.find();
  var customersDeptsList = [].obs;
  String selectedCustomerCity = "حدد المدينة";
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
      _customerDeptsData.getAllDepts(userID).listen((event) {
        customersDeptsList.value = event.docs;

        if (customersDeptsList.isEmpty) {
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
    String search = searchDeptsTextController.text;
    if (search.isEmpty) {
      getDepts();
    } else {
      customersDeptsList.value =
          customersDeptsList.where((doc) {
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
      if (customersDeptsList.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
      update();
    }
  }

  @override
  searchForBillBayCity(String cityName) {
    if (cityName.isEmpty || cityName == "جميع المدن") {
      getDepts();
    } else {
      customersDeptsList.value =
          customersDeptsList.where((doc) {
            final data = doc.data();
            final fileView = data["customer_city"].toLowerCase();
            return fileView.contains(cityName.toLowerCase());
          }).toList();
      if (customersDeptsList.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
      selectedCustomerCity = cityName;
    }
    update();
  }

  @override
  searchByDate(DateTime searchStartDate, DateTime searchEndDate) {
    try {
      selectedStartDate = _formatDate(searchStartDate);
      selectedEndDate = _formatDate(searchEndDate);

      // Filter bills within date range
      customersDeptsList.value =
          customersDeptsList.where((doc) {
            final data = doc.data();
            final DateTime billDate = (data["bill_date"] as Timestamp).toDate();

            // Check if bill date is within range (inclusive)
            return billDate.isAfter(
                  searchStartDate.subtract(const Duration(days: 1)),
                ) &&
                billDate.isBefore(searchEndDate.add(const Duration(days: 1)));
          }).toList();

      // Update status if no results found
      if (customersDeptsList.isEmpty) {
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
  goTODetailsPage(String deptId) {
    Get.toNamed(
      AppRoutes.customer_debt_details_page,
      arguments: {"dept_id": deptId},
    );
  }

  @override
  void onInit() {
    getDepts();
    super.onInit();
  }
}
