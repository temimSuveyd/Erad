import 'package:erad/data/data_score/remote/supplier/suppliers_data.dart';
import 'package:erad/view/supplier/suppliers_view/widgets/custom_add_suppliers_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/view/custom_widgets/custom_delete_dialog.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';

abstract class SuppliersController extends GetxController {
  addSuppliers();

  show_add_Suppliers_dialog();
  changeCity(String cityName);
  getSuppliers();
  show_delete_dialog(String suppliersId);
  dlete_Suppliers(String suppliersId);
  show_edit_dialog(
    String suppliersId,
    String suppliersCity,
    String suppliersName,
  );
  editSuppliers(String suppliersId, String suppliersCity, String suppliersName);
  searchForSuppliersBayName();
  searchForSuppliersBayCity(String cityName);
}

class SuppliersControllerImp extends SuppliersController {
  Statusreqest statusreqest = Statusreqest.success;
  SuppliersData suppliersData = SuppliersData();
  var suppliersList = [].obs;
  Services services = Get.find();
  TextEditingController search_controller = TextEditingController();
  TextEditingController suppliers_name_controller = TextEditingController();
  String suppliers_city = "مدينة المورد";

  @override
  addSuppliers() {
    String suppliersName = suppliers_name_controller.text;
    if (suppliers_city.isEmpty || suppliersName.isEmpty) {
      custom_snackBar();
    } else {
      statusreqest = Statusreqest.loading;
      update();
      String userID = services.sharedPreferences.getString(AppShared.userID)!;

      try {
        suppliersData.addSupplier(userID, suppliersName, suppliers_city);
      } catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    }
  }

  @override
  show_add_Suppliers_dialog() {
    Custom_add_suppliers_dialog(
      suppliers_name_controller,
      suppliers_city,
      () {
        addSuppliers();
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
    suppliers_city = cityName;
    update();
  }

  @override
  getSuppliers() {
    statusreqest = Statusreqest.loading;
    update();
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      suppliersData.getAllSuppliers(userID).listen((event) {
        suppliersList.value = event.docs;
        if (suppliersList.isEmpty) {
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
  show_delete_dialog(String suppliersId) {
    custom_delete_dialog(() {
      dlete_Suppliers(suppliersId);
    });
  }

  @override
  dlete_Suppliers(String suppliersId) {
    try {
      String userID = services.sharedPreferences.getString(AppShared.userID)!;

      suppliersData.deleteSupplier(userID, suppliersId);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  show_edit_dialog(
    String suppliers_id,
    String suppliers_city,
    String suppliersName,
  ) {
    Custom_add_suppliers_dialog(
      suppliers_name_controller,
      suppliers_city,
      () {
        editSuppliers(suppliers_id, suppliers_city, suppliersName);
        Get.close(0);
      },
      (p0) {
        changeCity(p0);
      },
      suppliersName,
      suppliers_city,
    );
  }

  @override
  editSuppliers(
    String suppliers_id,
    String suppliers_city,
    String suppliersName,
  ) {
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    String suppliers_name0 =
        suppliers_name_controller.text.isEmpty
            ? suppliersName
            : suppliers_name_controller.text;
    String suppliersCity =
        suppliers_city.isEmpty ? suppliers_city : suppliers_city;
    try {
      suppliersData.editSupplier(
        userID,
        suppliers_name0,
        suppliersCity,
        suppliers_id,
      );
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  searchForSuppliersBayName() {
    String search = search_controller.text;
    if (search.isEmpty) {
      getSuppliers();
    } else {
      suppliersList.value =
          suppliersList.where((doc) {
            final data = doc.data();
            final fileView = data["supplier_name"].toLowerCase();
            return fileView.contains(search.toLowerCase());
          }).toList();
      if (suppliersList.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
    }
    update();
  }

  @override
  searchForSuppliersBayCity(String cityName) async {
    suppliers_city = cityName;
    if (cityName.isEmpty || cityName == "جميع المدن") {
      getSuppliers();
    } else {
      String userID = services.sharedPreferences.getString(AppShared.userID)!;
      try {
        suppliersData.getAllSuppliers(userID).listen((event) {
          var allSuppliers = event.docs;

          var filteredList =
              allSuppliers.where((doc) {
                final data = doc.data();
                final supplierCity =
                    data["supplier_city"]?.toString().toLowerCase() ?? '';
                final searchCity = cityName.toLowerCase();
                return supplierCity.contains(searchCity) ||
                    searchCity.contains(supplierCity) ||
                    supplierCity == searchCity;
              }).toList();

          suppliersList.value = filteredList;

          if (filteredList.isEmpty) {
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
  }

  @override
  void onInit() {
    getSuppliers();
    super.onInit();
  }
}
