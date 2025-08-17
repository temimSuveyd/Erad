import 'package:Erad/core/class/handling_data.dart';
import 'package:Erad/core/constans/sharedPreferences.dart';
import 'package:Erad/core/services/app_services.dart';
import 'package:Erad/data/data_score/remote/depts/customer_depts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class CustomerDeptsViewController extends GetxController {
  getBills();
  getCustomers();
  searchForBillsBayCustomerName();
  searchForBillBayCity(String city_name);
  searchByDate(DateTime searchStartDate, DateTime searchEndDate);
  getDepts();
}

class CustomerDeptsViewControllerImp extends CustomerDeptsViewController {
  final CustomerDeptsData _customerDeptsData = CustomerDeptsData();
  final Services services = Get.find();
  var customerBillsList = [].obs;
  var customersList  = [].obs;
  var customersDeptsList = [].obs;
  

  
  String selectedCustomerCity = "حدد المدينة";
  Statusreqest statusreqest = Statusreqest.success;
  final TextEditingController searchDeptsTextController =
      TextEditingController();
  String? selectedStartDate;
  String? selectedEndDate;

  @override
  getBills() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      _customerDeptsData.getAllDepts(user_email).listen((event) {
        customerBillsList.value = event.docs;
        if (customerBillsList.isEmpty) {
          statusreqest = Statusreqest.noData;
        } else {
          statusreqest = Statusreqest.success;
        }
        update();
      });
    } on Exception catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  getCustomers() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      _customerDeptsData.getCustomers(user_email).listen((event) {
        customerBillsList.value = event.docs;
        if (customerBillsList.isEmpty) {
          statusreqest = Statusreqest.noData;
        } else {
          statusreqest = Statusreqest.success;
        }
        update();
      });
    } on Exception catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  getDepts() {
  

  }


  @override
  searchForBillsBayCustomerName() {
    String search = searchDeptsTextController.text;
    if (search.isEmpty) {
      getBills();
    } else {
      customerBillsList.value =
          customerBillsList.where((doc) {
            final data = doc.data();
            final customer_name =
                data["customer_name"].toString().toLowerCase();
            final bill_id = data["bill_no"].toString().toLowerCase();
            if (customer_name.contains(search.toLowerCase()) ||
                bill_id.contains(search.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          }).toList();
      if (customerBillsList.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
      update();
    }
  }

  @override
  searchForBillBayCity(String city_name) {
    if (city_name.isEmpty || city_name == "جميع المدن") {
      getBills();
    } else {
      customerBillsList.value =
          customerBillsList.where((doc) {
            final data = doc.data();
            final fileView = data["customer_city"].toLowerCase();
            return fileView.contains(city_name.toLowerCase());
          }).toList();
      if (customerBillsList.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
      selectedCustomerCity = city_name;
    }
    update();
  }

  @override
  searchByDate(DateTime searchStartDate, DateTime searchEndDate) {
    try {
      selectedStartDate = _formatDate(searchStartDate);
      selectedEndDate = _formatDate(searchEndDate);

      // Filter bills within date range
      customerBillsList.value =
          customerBillsList.where((doc) {
            final data = doc.data();
            final DateTime billDate = (data["bill_date"] as Timestamp).toDate();

            // Check if bill date is within range (inclusive)
            return billDate.isAfter(
                  searchStartDate.subtract(const Duration(days: 1)),
                ) &&
                billDate.isBefore(searchEndDate.add(const Duration(days: 1)));
          }).toList();

      // Update status if no results found
      if (customerBillsList.isEmpty) {
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
  void onInit() {
    getBills();

    super.onInit();
  }
  

}
