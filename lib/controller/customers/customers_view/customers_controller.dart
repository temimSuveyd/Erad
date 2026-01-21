import 'package:erad/data/model/customers/customers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/customer/customers_data.dart';
import 'package:erad/view/custom_widgets/custom_delete_dialog.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';
import 'package:erad/view/customer/customers_view/widgets/custom_add_customer_dialog.dart';

abstract class CustomersController extends GetxController {
  addCustomer();

  show_add_customer_dialog();
  changeCity(String cityName);
  getCustomers();
  show_delete_dialog(String customerId);
  delete_customer(String customerId);
  show_edit_dialog(CustomersModel customersModel);
  editCustomer(String customerId, String customerCity, String customerName);
  searchForCustomersBayName();
  searchForCustomersBayCity(String cityName);
}

class CustomersControllerImp extends CustomersController {
  Statusreqest statusreqest = Statusreqest.success;
  CustomersData customersData = CustomersData();
  var customersList = [].obs;
  Services services = Get.find();
  TextEditingController search_controller = TextEditingController();
  TextEditingController customer_name_controller = TextEditingController();
  String customer_city = "مدينة العميل";

  @override
  addCustomer() {
    String customerName = customer_name_controller.text;
    if (customer_city.isEmpty || customerName.isEmpty) {
      custom_snackBar();
    } else {
      statusreqest = Statusreqest.loading;
      update();
      String userID = services.sharedPreferences.getString(AppShared.userID)!;

      try {
        customersData.addCustomer(userID, customerName, customer_city);
      } catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    }
  }

  @override
  show_add_customer_dialog() {
    Custom_add_customer_dialog(
      customer_name_controller,
      customer_city,
      () {
        addCustomer();
        Get.close(0);
      },
      (p0) {
        changeCity(p0);
      },
      "اسم العميل",
      "مدينة العميل",
    );
  }

  @override
  changeCity(String cityName) {
    customer_city = cityName;
    update();
  }

  @override
  getCustomers() {
    statusreqest = Statusreqest.loading;
    update();
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      customersData.getAllCustomers(userID).listen((event) {
        customersList.value = event;
        if (customersList.isEmpty) {
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
  show_delete_dialog(String customerId) {
    custom_delete_dialog(() {
      delete_customer(customerId);
    });
  }

  @override
  delete_customer(String customerId) {
    try {
      String userID = services.sharedPreferences.getString(AppShared.userID)!;

      customersData.deleteCustomer(userID, customerId);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  show_edit_dialog(CustomersModel customersModel) {
    Custom_add_customer_dialog(
      customer_name_controller,
      customersModel.customer_city!,
      () {
        editCustomer(
          customersModel.customer_id!,
          customersModel.customer_city!,
          customersModel.customer_name!,
        );
        Get.close(0);
      },
      (p0) {
        changeCity(p0);
      },
      customersModel.customer_name!,
      customersModel.customer_city!,
    );
  }

  @override
  editCustomer(String customerId, String customerCity, String customerName) {
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    String newCustomerName =
        customer_name_controller.text.isEmpty
            ? customerName
            : customer_name_controller.text;
    String newCityName = customer_city.isEmpty ? customerCity : customer_city;
    try {
      customersData.editCustomer(
        userID,
        newCustomerName,
        newCityName,
        customerId,
      );
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  searchForCustomersBayName() {
    String search = search_controller.text;
    if (search.isEmpty) {
      getCustomers();
    } else {
      customersList.value =
          customersList.where((doc) {
            final data = doc.data();
            final fileView = data["customer_name"].toLowerCase();
            return fileView.contains(search.toLowerCase());
          }).toList();
      if (customersList.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
    }
    update();
  }

  @override
  searchForCustomersBayCity(String cityName) {
    customer_city = cityName;
    if (cityName.isEmpty || cityName == "جميع المدن") {
      getCustomers();
    } else {
      customersList.value =
          customersList.where((doc) {
            final data = doc.data();
            final fileView = data["customer_city"].toLowerCase();
            return fileView.contains(cityName.toLowerCase());
          }).toList();
      if (customersList.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
    }
    update();
  }

  @override
  void onInit() {
    getCustomers();
    super.onInit();
  }
}
