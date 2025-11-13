import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/depts/customer_depts_data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class CustomerDeptsViewController extends GetxController {
  void searchForBillsBayCustomerName();
  void searchForBillBayCity(String cityName);
  void getDepts();
  void goTODetailsPage(String deptId);
}

class CustomerDeptsViewControllerImp extends CustomerDeptsViewController {
  final CustomerDeptsData _customerDeptsData = CustomerDeptsData();
  final Services services = Get.find();
  var customersDeptsList = [].obs;
  String selectedCustomerCity = "حدد المدينة";
  Statusreqest statusreqest = Statusreqest.success;
  final TextEditingController searchDeptsTextController =
      TextEditingController();

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
    String search = searchDeptsTextController.text;
    if (search.isEmpty) {
      getDepts();
    } else {
      customersDeptsList.value =
          customersDeptsList.where((doc) {
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
      if (customersDeptsList.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
      update();
    }
  }

  @override
  searchForBillBayCity(String cityName) {
    final String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    if (cityName.isEmpty || cityName == "جميع المدن") {
      getDepts();
    } else {
      _customerDeptsData.getAllDepts(userID).listen((event) {
        customersDeptsList.value = event.docs;
        customersDeptsList.value =
            customersDeptsList.where((doc) {
              final data = doc.data();
              final fileView = data["customer_city"].toLowerCase();
              return fileView.contains(cityName.toLowerCase());
            }).toList();
        if (customersDeptsList.isEmpty) {
          statusreqest = Statusreqest.empty;
        }
        selectedCustomerCity = cityName;
        update();
      });
    }
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
