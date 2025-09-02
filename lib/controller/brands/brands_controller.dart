import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/brands/brands_data.dart';
import 'package:erad/view/prodects/brands_view/widgets/custom_brands_add_diaolg.dart';
import 'package:erad/view/custom_widgets/custom_delete_dialog.dart';

abstract class BrandsController extends GetxController {
  show_dialog();
  add_categorey();
  initData();
  go_to_brands_type_page(String brand_name);
  getBrands();
  searchForBrands();
  show_delete_dialog(String id);
  delete_brand(String id);
}

class BrandsControllerImp extends BrandsController {
  Statusreqest statusreqest = Statusreqest.success;
  TextEditingController _brand_name = TextEditingController();
  TextEditingController serach_for_brands_controller = TextEditingController();

  BrandsData brandsData = BrandsData();
  Services services = Get.find();
  var brandsList = [].obs;
  String? categorey_type;
  String? categorey_name;

  @override
  // ignore: non_constant_identifier_names
  show_dialog() async {
    custom_add_brands_dialog(
      () {
        add_categorey();
        Get.back();
      },
      _brand_name,
      (String? validator) {},
    );
  }

  @override
  // ignore: non_constant_identifier_names
  add_categorey() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    String brand_name = _brand_name.text;
    try {
      brandsData.addBrand(
        categorey_name!,
        user_email,
        categorey_type!,
        brand_name,
      );
      _brand_name.clear();
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  getBrands() {
    statusreqest = Statusreqest.loading;
    update();

    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;

    try {
      brandsData.getBrands(user_email, categorey_type!, categorey_name!).listen(
        (event) {
          brandsList.value = event.docs;
          if (brandsList.isEmpty) {
            statusreqest = Statusreqest.noData;
            update();
          } else {
            statusreqest = Statusreqest.success;
            update();
          }
        },
      );
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  // ignore: non_constant_identifier_names
  go_to_brands_type_page(String brandName) {
    Get.toNamed(
      AppRoutes.brands_page_type_page,
      arguments: {
        "brand_name": brandName,
        "categorey_type": categorey_type,
        "categorey_name": categorey_name,
      },
    );
  }

  @override
  searchForBrands() {
    String search = serach_for_brands_controller.text;
    if (search.isEmpty) {
      getBrands();
    } else {
      brandsList.value =
          brandsList.where((doc) {
            final data = doc.data();
            final fileView = data["brand_name"].toString().toLowerCase();
            return fileView.contains(search.toLowerCase());
          }).toList();
      if (brandsList.isEmpty) {
        statusreqest = Statusreqest.noData;
        update();
      }
    }
    update();
  }

  @override
  // ignore: non_constant_identifier_names
  show_delete_dialog(String id) {
    custom_delete_dialog(() {
      delete_brand(id);
    });
  }

  @override
  // ignore: non_constant_identifier_names
  delete_brand(String id) {
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      brandsData.deleteBramd(user_email, id);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  initData() {
    categorey_type = Get.arguments["categorey_type"];
    categorey_name = Get.arguments["categorey_name"];
  }

  @override
  void onInit() {
    initData();
    getBrands();
    super.onInit();
  }
}
