import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:suveyd_ticaret/core/class/handling_data.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/core/constans/sharedPreferences.dart';
import 'package:suveyd_ticaret/core/services/app_services.dart';
import 'package:suveyd_ticaret/data/data_score/remote/brands_data.dart';
import 'package:suveyd_ticaret/view/brands_type_view/widgets/custom_add_brands_type_dialog.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_delete_dialog.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_textfield_erroe_snackbar.dart';

abstract class BrandsTypeController extends GetxController {
  show_dialog();
  add_brands_type();
  get_brands_type();
  initData();
  searchForBrandsType();
  show_edit_dialog(
    String sales_pice,
    String buiyng_price,
    String size,
    String product_name,
  );
  editBrandsType(
    String sales_pice,
    String buiyng_price,
    String size,
    String product_name,
  );
  deleteBrandsType(String product_name);
  show_delete_dialog(String product_name);
}

class BrandsTypeControllerImp extends BrandsTypeController {
  Statusreqest statusreqest = Statusreqest.success;
  TextEditingController product_sales_price_controller =
      TextEditingController();
  TextEditingController product_buying_controller = TextEditingController();
  TextEditingController product_size_controller = TextEditingController();
  TextEditingController serach_for_brands_type_controller =
      TextEditingController();
  BrandsData brandData = BrandsData();
  var brandsTypeList = [].obs;
  Services services = Get.find();
  String? categorey_type;
  String? categorey_name;
  String? brand_name;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  show_dialog() async {
    custom_add_brands_type_dialog(
      () {
        add_brands_type();
        Get.back();
      },
      product_buying_controller,
      product_sales_price_controller,
      product_size_controller,
      "سعر البيع",
      "سعر الشراء",
      "حجم المنتج",
      key,
    );
  }

  @override
  add_brands_type() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;

    if (product_size_controller.text.isNotEmpty ||
        product_buying_controller.text.isNotEmpty ||
        product_sales_price_controller.text.isNotEmpty) {
          
      int product_buing_price = int.parse(product_buying_controller.text);
      int product_sales_price = int.parse(product_sales_price_controller.text);
      String product_size = product_size_controller.text;
      int profits = (product_buing_price) - (product_sales_price);
      try {
        brandData.addBrandsType(
          categorey_name!,
          user_email,
          categorey_type!,
          brand_name!,
          product_size,
          product_buing_price,
          product_sales_price,
          profits,
        );

        statusreqest = Statusreqest.success;
        update();
      } catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    } else {
 custom_empty_data_erroe_snackbar();
    }
  }

  @override
  get_brands_type() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      brandData
          .getBrandsType(
            user_email,
            categorey_type!,
            categorey_name!,
            brand_name!,
          )
          .listen((event) {
            brandsTypeList.value = event.docs;
            if (brandsTypeList.isEmpty) {
              statusreqest = Statusreqest.noData;
              update();
            } else {
              statusreqest = Statusreqest.success;
              update();
            }
          });
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  searchForBrandsType() {
    String search = serach_for_brands_type_controller.text;
    if (search.isEmpty) {
      get_brands_type();
    } else {
      brandsTypeList.value =
          brandsTypeList.where((doc) {
            final data = doc.data();
            final fileView = data["product_name"].toString().toLowerCase();
            return fileView.contains(search.toLowerCase());
          }).toList();
      if (brandsTypeList.isEmpty) {
        statusreqest = Statusreqest.noData;
      }
    }
    update();
  }

  @override
  show_edit_dialog(
    String sales_pice,
    String buiyng_price,
    String size,
    String prand_name,
  ) {
    custom_add_brands_type_dialog(
      () {
        editBrandsType(sales_pice, buiyng_price, size, prand_name);
        Get.back();
      },
      product_buying_controller,
      product_sales_price_controller,
      product_size_controller,
      sales_pice,
      buiyng_price,
      size,
      key,
    );
  }

  @override
  editBrandsType(
    String sales_pice,
    String buiyng_price,
    String size,
    String product_name,
  ) {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    String product_buing_price =
        product_buying_controller.text.isEmpty
            ? buiyng_price
            : product_buying_controller.text;
    String product_sales_price =
        product_sales_price_controller.text.isEmpty
            ? sales_pice
            : product_buying_controller.text;
    String product_size =
        product_size_controller.text.isEmpty
            ? size
            : product_size_controller.text;
    try {
      brandData.editBrandsType(
        user_email,
        product_buing_price,
        product_sales_price,
        product_size,
        product_name,
      );
      product_buying_controller.clear();
      product_size_controller.clear();
      product_sales_price_controller.clear();
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  deleteBrandsType(String product_name) {
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      brandData.deleteBrandsType(user_email, product_name);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  show_delete_dialog(String product_name) {
    custom_delete_dialog(() {
      deleteBrandsType(product_name);
      Get.close(0);
    });
  }

  @override
  initData() {
    categorey_type = Get.arguments["categorey_type"];
    categorey_name = Get.arguments["categorey_name"];
    brand_name = Get.arguments["brand_name"];
  }

  @override
  void onInit() {
    initData();
    get_brands_type();
    super.onInit();
  }
}
