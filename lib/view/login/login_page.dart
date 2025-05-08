import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:suveyd_ticaret/controller/login_controller.dart';
import 'package:suveyd_ticaret/core/class/handling_data_view.dart';
import 'package:suveyd_ticaret/core/class/handling_data_view_with_sliverBox.dart';
import 'package:suveyd_ticaret/core/constans/images.dart';
import 'package:suveyd_ticaret/view/login/widgets/custom_account_square.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginControllerImp());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 212, 212),
      body: GetBuilder<LoginControllerImp>(
        builder:
            (controller) => Form(
              key: controller.formState,
              child: HandlingDataView(
                statusreqest: controller.statusreqest,
                widget: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.signin_background),
                      fit: BoxFit.cover,
                    ),
                  ),

                  child: Container(
                    alignment: Alignment.center,
                    color: const Color.fromARGB(62, 0, 0, 0),
                    child: Account_Square(),
                  ),
                ),
                onPressed: () => controller.login(),
              ),
            ),
      ),
    );
  }
}
