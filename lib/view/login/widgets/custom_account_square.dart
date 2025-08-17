import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:Erad/controller/auth/login_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/core/function/validatorInpot.dart';
import 'package:Erad/view/login/widgets/custom_sigin_button.dart';
import 'package:Erad/view/login/widgets/custom_sign_textfield.dart';

// ignore: camel_case_types
class Account_Square extends StatelessWidget {
  const Account_Square({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(206, 20, 20, 20),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),

      child: GetBuilder<LoginControllerImp>(
        builder:
            (controller) => Column(
              children: [
                SizedBox(height: 20),

                Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.wihet,
                  ),
                ),
                SizedBox(height: 30),
                Custom_login_textfield(
                  hintText: "أدخل اسمك",
                  controller: controller.user_email,
                  validator: (p0) {
                    return validatorInput(p0!, 4, 40, "email");
                  },
                ),
                SizedBox(height: 10),

                Custom_login_textfield(
                  hintText: "أدخل كلمة المرور ",
                  controller: controller.user_password,
                  validator: (p0) {},
                ),
                Spacer(),
                Custom_sigin_button(onPressed: () => controller.login()),
              ],
            ),
      ),
    );
  }
}
