import 'package:erad/core/class/handling_data_view.dart';
import 'package:erad/core/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:erad/controller/auth/login_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/function/validatorInpot.dart';
import 'package:erad/view/login/widgets/custom_sigin_button.dart';
import 'package:erad/view/login/widgets/custom_sign_textfield.dart';

// ignore: camel_case_types
class Account_Square extends StatelessWidget {
  const Account_Square({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 320,
      decoration: BoxDecoration(
        color: const Color.fromARGB(20, 0, 24, 156),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

      child: GetBuilder<LoginControllerImp>(
        builder:
            (controller) => HandlingDataView(
              statusreqest: controller.statusreqest,
              onPressed: () => controller.login(),
              widget: Form(
                key: controller.formState,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                
                    Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.logo, height: 30, width: 30),
                        Text(
                          "اراد",
                          style: TextStyle(color: AppColors.wihet, fontSize: 20),
                        ),
                      ],
                    ),
                
                    SizedBox(height: 40),
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.wihet,
                            thickness: 1,
                            height: 2,
                            endIndent: 10,
                            indent: 0,
                          ),
                        ),
                
                        Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.wihet,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.wihet,
                            thickness: 1,
                            height: 2,
                            endIndent: 10,
                            indent: 0,
                          ),
                        ),
                      ],
                    ),
                
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                
                    Custom_sigin_button(onPressed: () => controller.login()),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
