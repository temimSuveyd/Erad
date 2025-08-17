import 'package:Erad/data/data_score/remote/supplier/suppliers_data.dart';
import 'package:Erad/view/suppliers_view/widgets/custom_add_suppliers_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:Erad/core/class/handling_data.dart';
import 'package:Erad/core/constans/sharedPreferences.dart';
import 'package:Erad/core/services/app_services.dart';
import 'package:Erad/view/custom_widgets/custom_delete_dialog.dart';
import 'package:Erad/view/custom_widgets/custom_textfield_erroe_snackbar.dart';

abstract class SuppliersController extends GetxController {
  addSuppliers();

  show_add_Suppliers_dialog();
  changeCity(String city_name);
  getSuppliers();
  show_delete_dialog(String Suppliers_id);
  dlete_Suppliers(String Suppliers_id);
  show_edit_dialog(
    String suppliers_id,
    String suppliers_city,
    String suppliers_name,
  );
  editSuppliers(
    String suppliers_id,
    String suppliers_city,
    String suppliers_name,
  );
  searchForSuppliersBayName();
  searchForSuppliersBayCity(String city_name);
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
    String suppliers_name = suppliers_name_controller.text;
    if (suppliers_city.isEmpty || suppliers_name.isEmpty) {
      custom_empty_data_erroe_snackbar();
    } else {
      statusreqest = Statusreqest.loading;
      update();
      String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;

      try {
        suppliersData.addSupplier(user_email, suppliers_name, suppliers_city);
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
  changeCity(String city_name) {
    suppliers_city = city_name;
    update();
  }

  @override
  getSuppliers() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      suppliersData.getAllSuppliers(user_email).listen((event) {
        suppliersList.value = event.docs;
        if (suppliersList.isEmpty) {
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
  show_delete_dialog(String Suppliers_id) {
    custom_delete_dialog(() {
      dlete_Suppliers(Suppliers_id);
    });
  }

  @override
  dlete_Suppliers(String Suppliers_id) {
    try {
      String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;

      suppliersData.deleteSupplier(user_email, Suppliers_id);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  show_edit_dialog(
    String _suppliers_id,
    String _suppliers_city,
    String suppliers_name,
  ) {
    Custom_add_suppliers_dialog(
      suppliers_name_controller,
      suppliers_city,
      () {
        editSuppliers(_suppliers_id, suppliers_city, suppliers_name);
        Get.close(0);
      },
      (p0) {
        changeCity(p0);
      },
      suppliers_name,
      _suppliers_city,
    );
  }

  @override
  editSuppliers(
    String _suppliers_id,
    String _suppliers_city,
    String suppliers_name,
  ) {
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    String _suppliers_name =
        suppliers_name_controller.text.isEmpty
            ? suppliers_name
            : suppliers_name_controller.text;
    String _suppliers_city =
        suppliers_city.isEmpty ? suppliers_city : suppliers_city;
    try {
      suppliersData.editSupplier(
        user_email,
        _suppliers_name,
        _suppliers_city,
        _suppliers_id,
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
        statusreqest = Statusreqest.noData;
      }
    }
    update();
  }

  @override
  searchForSuppliersBayCity(String city_name) async{
    suppliers_city = city_name;
    if (city_name.isEmpty || city_name == "جميع المدن") {
      getSuppliers();
    } else {

      String user_email = services.sharedPreferences.getString(AppShared.user_email)!;
      try {
        suppliersData.getAllSuppliers(user_email).listen((event) {
          var allSuppliers = event.docs;
          
          var filteredList = allSuppliers.where((doc) {
            final data = doc.data();
            final supplierCity = data["supplier_city"]?.toString().toLowerCase() ?? '';
            final searchCity = city_name.toLowerCase();
            return supplierCity.contains(searchCity) || 
                   searchCity.contains(supplierCity) ||
                   supplierCity == searchCity;
          }).toList();
          
          suppliersList.value = filteredList;
          
          if (filteredList.isEmpty) {
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
  }

  @override
  void onInit() {
    getSuppliers();
    super.onInit();
  }
}
