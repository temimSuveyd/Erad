import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:Erad/controller/home/home_controller.dart';
import 'package:Erad/view/home/widgets/custom_set_page_button.dart';

AppBar Custom_home_appBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    actions: [
      Spacer(),
      GetBuilder<HomeControllerImp>(
        builder: (controller) => Custom_set_page_container(),
      ),
      Spacer(),
    ],
  );
}
