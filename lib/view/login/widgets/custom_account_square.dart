import 'package:erad/core/class/handling_data_view.dart';
import 'package:erad/core/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:erad/controller/auth/login_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/login/widgets/custom_sigin_button.dart';
import 'package:erad/view/login/widgets/custom_sign_textfield.dart';

class Account_Square extends StatelessWidget {
  const Account_Square({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 340,
        height: Get.height / 1.8,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.wihet, // Changed to white for border color
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: GetBuilder<LoginControllerImp>(
          builder:
              (controller) => HandlingDataView(
                statusreqest: controller.statusreqest,
                onPressed: () => controller.login(),
                widget: Form(
                  key: controller.formState,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo and app name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                0.10,
                              ), // Changed bg color to lighter white
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withOpacity(
                                  0.25,
                                ), // Changed border color
                                width: 0.5,
                              ),
                            ),
                            padding: const EdgeInsets.all(7),
                            child: Image.asset(
                              AppImages.logo,
                              height: 32,
                              width: 32,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            "اراد",
                            style: TextStyle(
                              color: AppColors.wihet,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 26),
                      Custom_login_textfield(
                        hintText: 'أدخل اسم الشركة',
                        controller: controller.company_name,
                        validator: (p0) {},
                      ),
                      const SizedBox(height: 15),

                      // Email field
                      Custom_login_textfield(
                        hintText: "أدخل بريدك الإلكتروني",
                        controller: controller.user_email,
                        // You may want to add a validator here
                        validator: (p0) {},
                      ),
                      const SizedBox(height: 15),
                      // Password field
                      Custom_login_textfield(
                        hintText: "أدخل كلمة المرور ",
                        controller: controller.user_password,
                        validator: (p0) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Remember me & button row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                Checkbox(
                                  value: controller.isLogin.value,
                                  onChanged: (value) {
                                    controller.changeSaveLogin();
                                  },
                                  activeColor:
                                      AppColors
                                          .wihet, // Checkbox active color changed to white
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: BorderSide(
                                    color: Colors.white.withOpacity(
                                      0.7,
                                    ), // Changed border color
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "تذكرني عند الدخول",
                                  style: TextStyle(
                                    color: AppColors.wihet,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.5,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),
                      Custom_sigin_button(onPressed: () => controller.login()),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
