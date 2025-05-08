import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suveyd_ticaret/core/class/handling_data.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/core/constans/sharedPreferences.dart';
import 'package:suveyd_ticaret/core/function/convertToDropdownItems.dart';
import 'package:suveyd_ticaret/core/services/app_services.dart';
import 'package:suveyd_ticaret/data/data_score/remote/customers_data.dart';
import 'package:suveyd_ticaret/data/data_score/remote/cystomer_bill_data.dart';
import 'package:suveyd_ticaret/data/data_score/remote/product_data.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_delete_dialog.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_textfield_erroe_snackbar.dart';
import 'package:suveyd_ticaret/view/customer_bills_add/widgets/custom_add_product_to_bill_dialog.dart';

abstract class CustomerBiilAddController extends GetxController {
  addCustomerBill();
  getCustomerById();
  getAllCustomers();
  setCustomer(String id);
  setDate(DateTime bill_date);
  setPaymentType(String payment_type);
  getAllProducts();
  showAddProdectDialog();
  addProduct(String product_id);
  getProductById(String product_id);
  getBillProdects();
  totalPriceAccount();
  onWillPop();
  deleteBill();
  showDleteBillDialog();
}

class CustomerBiilAddControllerImp extends CustomerBiilAddController {
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  // bill data
  CustomerBillData customerBillData = CustomerBillData();
  DateTime bill_add_date = DateTime.now();
  String? bill_id;
  // customer data
  CustomersData customersData = CustomersData();
  Map<String, dynamic>? customerData;
  var customersList = [].obs;
  List<DropdownMenuItem<String>>? customers_list_dropdownItrm;
  String? customer_name;
  String? customer_city;
  String? customer_id;
  String? bill_payment_type;
  // product data
  ProductData _productData = ProductData();
  Map<String, dynamic>? productData;
  var all_product_list = [].obs;
  var bill_prodects_list = [].obs;
  List<DropdownMenuItem<String>>? product_list_dropdownItrm;
  TextEditingController number_of_products_controller = TextEditingController();
  String? product_name;
  int? product_price;
  String? product_id;
  int? product_number;
  int? prodect_profits;
  int total_product_price = 0;
  // --------------------------------------------------------bill data
  @override
  addCustomerBill() async {
    if (customer_name == null ||
        customer_city == null ||
        customer_id == null ||
        bill_payment_type == null) {
      custom_empty_data_erroe_snackbar();
    } else {
      statusreqest = Statusreqest.loading;
      update();
      String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;

      try {
        bill_id = await customerBillData.addCustomerBill(
          customer_name!,
          customer_city!,
          customer_id!,
          bill_payment_type!,
          user_email,
          bill_add_date,
        );
        statusreqest = Statusreqest.success;
        update();
      } catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    }
  }

  @override
  getCustomerById() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;

    try {
      customersData.getCustomerByID(user_email, customer_id!).listen((event) {
        customerData = event.data();
        customer_city = customerData!["customer_city"];
        customer_name = customerData!["customer_name"];
        if (customerData!.isEmpty) {
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
  setDate(DateTime bill_date) {
    bill_add_date = bill_date;
    update();
  }

  @override
  setPaymentType(String payment_type) {
    bill_payment_type = payment_type;
    update();
  }

  @override
  setCustomer(String id) {
    customer_id = id;
    update();
    getCustomerById();
  }

  @override
  getAllCustomers() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      customersData.getAllCustomers(user_email).listen((event) {
        customersList.value = event.docs;
        customers_list_dropdownItrm = convertToDropdownItems(
          event.docs,
          'customer_name',
        );
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
  deleteBill() {




customerBillData.deleteCustomerBill(user_email, bill_id)



  }


  // -------------------------------------------------------------------------------product data

  @override
  getAllProducts() {
    statusreqest = Statusreqest.loading;
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      _productData.getAllproduct(user_email).listen((event) {
        all_product_list.value = event.docs;
        product_list_dropdownItrm = convertToDropdownItems(
          event.docs,
          "prodect_name",
        );
        if (all_product_list.isEmpty) {
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
  showAddProdectDialog() {
    if (bill_id == null) {
      custom_empty_data_erroe_snackbar();
    } else {
      custom_add_product_to_bill_dialog(
        number_of_products_controller,
        product_list_dropdownItrm,
        (value) {
          getProductById(value);
        },
        () {
          addProduct(product_name!);
        },
        "اسم المنتج",
        "عدد المنتجات",
      );
    }
  }

  @override
  addProduct(String product_id) {
    if (bill_id == null || product_name!.isEmpty) {
      custom_empty_data_erroe_snackbar();
    } else {
      String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      int numper_of_numper = int.parse(number_of_products_controller.text);
      try {
        customerBillData.addProductToBill(
          product_name!,
          product_price!,
          product_id,
          numper_of_numper,
          numper_of_numper * product_price!,
          user_email,
          bill_id!,
        );
        getBillProdects();

        update();
      } catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    }
  }

  @override
  getProductById(String product_id) async {
    try {
      String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      productData = await _productData.getProductById(user_email, product_id);
      product_name = productData!["prodect_name"];
      product_price = int.parse(productData!["prodect_sales_price"].toString());
      prodect_profits = productData!["prodect_profits"];
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  getBillProdects() {
    if (bill_id == null) {
      statusreqest = Statusreqest.noData;
      update();
    } else {
      statusreqest = Statusreqest.loading;
      update();

      String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      try {
        customerBillData.getBillProdects(user_email, bill_id!).listen((event) {
          bill_prodects_list.value = event.docs;
          totalPriceAccount();
          if (bill_prodects_list.isEmpty) {
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
  totalPriceAccount() {
    for (var responce in bill_prodects_list) {
      // total_product_price = total_product_price! + price;
      int price = responce["Total product price"];
      total_product_price = total_product_price + price;
    }
  }

  @override
  Future<bool> onWillPop() async {
    log("test-----------------------------test");
    bool shouldExit = false;
    Get.defaultDialog(
      buttonColor: AppColors.primary,
      backgroundColor: AppColors.backgroundColor,
      textConfirm: "حفظ",
      textCancel: "حذف",
      title: "حفظ هذا الفاتورة",
      middleText: "bu faturayı kaydetmek istiyor musunuz",
      onCancel: () {
        bool shouldExit = false;
        Get.back();
      },
      onConfirm: () {
        bool shouldExit = true;
      },
    );

    return shouldExit;
  }

  @override
  void onInit() {
    getBillProdects();
    getAllCustomers();
    getAllProducts();
    super.onInit();
  }

  @override
  void onClose() {




    super.onClose();
  }
  
  @override
  showDleteBillDialog() {
Get.defaultDialog(

  onConfirm: () {
    deleteBill();
  },
  onCancel: () {
    
  },

  buttonColor: AppColors.primary,
  backgroundColor: AppColors.backgroundColor,
  middleText: "هل أنت متأكد من أنك تريد حذف هذه الفاتورة",
);
  }
  



}
