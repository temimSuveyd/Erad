import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/function/validatorInpot.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/customer/customers_data.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_delete_dialog.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';
import 'package:erad/view/customer/customers_view/widgets/custom_add_customer_dialog.dart';

abstract class CustomersController extends GetxController {
  addCustomer();

  show_add_customer_dialog();
  changeCity(String city_name);
  getCustomers();
  show_delete_dialog(String customer_id);
  dlete_customer(String customer_id);
  show_edit_dialog(
    String customer_id,
    String customer_city,
    String customer_name,
  );
  editCustomer(String customer_id, String customer_city, String customer_name);
  searchForCustomersBayName();
  searchForCustomersBayCity(String city_name);
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
    String customer_name = customer_name_controller.text;
    if (customer_city.isEmpty || customer_name.isEmpty) {
      custom_snackBar();
    } else {
      statusreqest = Statusreqest.loading;
      update();
      String userID =
          services.sharedPreferences.getString(AppShared.userID)!;

      try {
        customersData.addCustomer(userID, customer_name, customer_city);
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
  changeCity(String city_name) {
    customer_city = city_name;
    update();
  }

  @override
  getCustomers() {
    statusreqest = Statusreqest.loading;
    update();
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      customersData.getAllCustomers(userID).listen((event) {
        customersList.value = event.docs;
        if (customersList.isEmpty) {
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
  show_delete_dialog(String customer_id) {
    custom_delete_dialog(() {
      dlete_customer(customer_id);
    });
  }

  @override
  dlete_customer(String customer_id) {
    try {
      String userID =
          services.sharedPreferences.getString(AppShared.userID)!;

      customersData.deleteCustomer(userID, customer_id);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  show_edit_dialog(
    String _customer_id,
    String _customer_city,
    String customer_name,
  ) {
    Custom_add_customer_dialog(
      customer_name_controller,
      customer_city,
      () {
        editCustomer(_customer_id, customer_city, customer_name);
        Get.close(0);
      },
      (p0) {
        changeCity(p0);
      },
      customer_name,
      _customer_city,
    );
  }

  @override
  editCustomer(
    String _customer_id,
    String _customer_city,
    String customer_name,
  ) {
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    String _customer_name =
        customer_name_controller.text.isEmpty
            ? customer_name
            : customer_name_controller.text;
    String _customer_city =
        customer_city.isEmpty ? customer_city : customer_city;
    try {
      customersData.editCustomer(
        userID,
        _customer_name,
        _customer_city,
        _customer_id,
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
        statusreqest = Statusreqest.noData;
      }
    }
    update();
  }

  @override
  searchForCustomersBayCity(String city_name) {
    customer_city = city_name;
    if (city_name.isEmpty || city_name == "جميع المدن") {
      getCustomers();
    } else {
      customersList.value =
          customersList.where((doc) {
            final data = doc.data();
            final fileView = data["customer_city"].toLowerCase();
            return fileView.contains(city_name.toLowerCase());
          }).toList();
      if (customersList.isEmpty) {
        statusreqest = Statusreqest.noData;
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
