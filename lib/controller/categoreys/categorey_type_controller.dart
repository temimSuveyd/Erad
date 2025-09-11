
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/categorey/categoreys_data.dart';
import 'package:erad/view/prodects/categorey_type_view/widgets/custom_add_categorey_type_dialog.dart';
import 'package:erad/view/custom_widgets/custom_delete_dialog.dart';

abstract class CategoreyTypeController extends GetxController {
  show_dialog();
  add_categorey_type();
  init_data();
  go_to_brand_page(String categoreyType);
  getCategoreysType();
  searchForCategoreys_type();
  show_delete_dialog(String id);
  delete_categorey(String id);
}

class CategoreyTypeControllerImp extends CategoreyTypeController {
  Statusreqest statusreqest = Statusreqest.success;
  CategoreysData categoreysData = CategoreysData();
  final TextEditingController _categorey_type = TextEditingController();
  TextEditingController serach_for_categorey_type_controller =
      TextEditingController();
  Services services = Get.find();
  String? categorey_name;
  var categoreyTypeList = [].obs;
  @override
  // ignore: non_constant_identifier_names
  show_dialog() {
    custom_add_categorey_type_dialog(_categorey_type, () {
      add_categorey_type();
      _categorey_type.clear();
      Get.back();
    });
  }

  @override
  // ignore: non_constant_identifier_names
  add_categorey_type() {
    statusreqest = Statusreqest.loading;
    update();
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    String categoreyType = _categorey_type.text;
    try {
      categoreysData.addCategorey_type(
        categorey_name!,
        userID,
        categoreyType,
      );
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  go_to_brand_page(String categoreyType) {
    Get.toNamed(
      AppRoutes.brands_page,
      arguments: {
        "categorey_type": categoreyType,
        "categorey_name": categorey_name,
      },
    );
  }

  @override
  // ignore: non_constant_identifier_names
  init_data() {
    categorey_name = Get.arguments["categorey_name"] ?? "";
  }

  @override
  getCategoreysType() {
    statusreqest = Statusreqest.loading;
    update();

    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;

    try {
      categoreysData.getCategoreysType(userID, categorey_name!).listen((
        event,
      ) {
        categoreyTypeList.value = event.docs;
        update();
        if (categoreyTypeList.isEmpty) {
          statusreqest = Statusreqest.empty;
          update();
        } else {
          statusreqest = Statusreqest.success;
          update();
        }
      });
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  searchForCategoreys_type() {
    String search = serach_for_categorey_type_controller.text;
    if (search.isEmpty) {
      getCategoreysType();
    } else {
      categoreyTypeList.value =
          categoreyTypeList.where((doc) {
            final data = doc.data();
            final fileView = data["categorey_type"].toString().toLowerCase();
            return fileView.contains(search.toLowerCase());
          }).toList();
      if (categoreyTypeList.isEmpty) {
        statusreqest = Statusreqest.empty;
        update();
      }
    }
    update();
  }

  @override
  show_delete_dialog(String id) {
    custom_delete_dialog(() {
      delete_categorey(id);
    });
  }

  @override
  delete_categorey(String id) {
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      categoreysData.deleteCategorey_type(userID, id);
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void onInit() {
    init_data();
    getCategoreysType();
    super.onInit();
  }
}
