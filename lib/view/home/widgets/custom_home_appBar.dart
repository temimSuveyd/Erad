import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:suveyd_ticaret/controller/home_controller.dart';
import 'package:suveyd_ticaret/core/constans/images.dart';
import 'package:suveyd_ticaret/view/home/widgets/custom_set_page_button.dart';

AppBar Custom_home_appBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    actions: [
      SizedBox(width: 30),

      Image.asset(AppImages.logog, width: 45),
      Spacer(),
      GetBuilder<HomeControllerImp>(
        builder: (controller) => Custom_set_page_container(),
      ),
      SizedBox(width: 75),

      Spacer(),
    ],
  );
}
