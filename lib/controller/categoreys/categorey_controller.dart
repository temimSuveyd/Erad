
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:Erad/core/class/handling_data.dart';
import 'package:Erad/core/constans/routes.dart';
import 'package:Erad/core/constans/sharedPreferences.dart';
import 'package:Erad/core/services/app_services.dart';
import 'package:Erad/data/data_score/remote/categorey/categoreys_data.dart';
import 'package:Erad/view/prodects/categoreys_view/widgets/custom_add_categorey_dialog.dart';
import 'package:Erad/view/custom_widgets/custom_delete_dialog.dart';

abstract class CategoreyController extends GetxController {
  // ignore: non_constant_identifier_names
  show_dialog();
  // ignore: non_constant_identifier_names
  add_categorey();
  // ignore: non_constant_identifier_names
  go_to_gategorey_type_page(String categoreyName);
  getCategoreys();
  searchForCategoreys();
  // ignore: non_constant_identifier_names
  show_delete_dialog(String id);
  // ignore: non_constant_identifier_names
  delete_categorey(String id);
}

class CategoreyControllerImp extends CategoreyController {
  Statusreqest statusreqest = Statusreqest.success;
  // ignore: non_constant_identifier_names
  final TextEditingController _categorey_name_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController serach_for_categorey_controller =
      TextEditingController();

  CategoreysData categoreysData = CategoreysData();
  Services services = Get.find();
  // ignore: non_constant_identifier_names
  var categoreys_list = [].obs;
  List searchList = [];

  @override
  // ignore: non_constant_identifier_names
  show_dialog() async {
    custom_add_categorey_dialog(
      () {
        add_categorey();
        Get.back();
      },
      _categorey_name_controller,
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
    String categorey_name = _categorey_name_controller.text;
    try {
      categoreysData.addCategoreys(categorey_name, user_email);
      _categorey_name_controller.clear();
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  // ignore: non_constant_identifier_names
  go_to_gategorey_type_page(String categoreyName) {
    Get.toNamed(
      AppRoutes.categorey_type_view_page,
      arguments: {"categorey_name": categoreyName},
    );
  }

  @override
  getCategoreys() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      categoreysData.getCategoreys(user_email).listen((event) {
        categoreys_list.value = event.docs;
        update();

        if (categoreys_list.isEmpty) {
          statusreqest = Statusreqest.noData;
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
  searchForCategoreys() {
    String search = serach_for_categorey_controller.text;
    if (search.isEmpty) {
      getCategoreys();
    } else {
      categoreys_list.value =
          categoreys_list.where((doc) {
            final data = doc.data();
            final fileView = data["categorey_name"].toString().toLowerCase();
            return fileView.contains(search.toLowerCase());
          }).toList();
      if (categoreys_list.isEmpty) {
        statusreqest = Statusreqest.noData;
        update();
      }
    }
    update();
  }
   @override
  // ignore: non_constant_identifier_names
  delete_categorey(String id) {
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      categoreysData.deleteCategorey(id, user_email);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }
  @override
  // ignore: non_constant_identifier_names
  show_delete_dialog(String id) {
    custom_delete_dialog(() {
      delete_categorey(id);
    });
  }

  @override
  void onInit() {
    getCategoreys();
    super.onInit();
  }

 
}
