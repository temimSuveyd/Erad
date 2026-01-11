import 'package:erad/core/class/handling_data_view.dart';
import 'package:erad/core/constans/images.dart';
import 'package:erad/core/function/validator_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/auth/login_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/login/widgets/custom_sigin_button.dart';
import 'package:erad/view/login/widgets/custom_sign_textfield.dart';

class AccountSquare extends StatelessWidget {
  const AccountSquare({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final containerWidth = maxWidth > 400 ? 360.0 : maxWidth * 0.9;
          final horizontalPadding = maxWidth > 400 ? 32.0 : 24.0;

          return Container(
            width: containerWidth,
            constraints: const BoxConstraints(minWidth: 280, maxWidth: 400),
            padding: EdgeInsets.all(horizontalPadding),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
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
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  AppImages.logo,
                                  height: 32,
                                  width: 32,
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "اراد",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          CustomLoginTextField(
                            hintText: 'أدخل اسم الشركة',
                            controller: controller.companyName,
                            validator: ValidatorInput.validateCompanyName,
                          ),
                          const SizedBox(height: 16),

                          CustomLoginTextField(
                            hintText: "أدخل بريدك الإلكتروني",
                            controller: controller.userEmail,
                            validator: ValidatorInput.validateEmail,
                          ),
                          const SizedBox(height: 16),

                          CustomLoginTextField(
                            hintText: "أدخل كلمة المرور",
                            controller: controller.userPassword,
                            validator: ValidatorInput.validatePassword,
                          ),
                          const SizedBox(height: 20),

                          // Remember me checkbox
                          Obx(
                            () => Row(
                              children: [
                                Checkbox(
                                  value: controller.isLogin.value,
                                  onChanged: (value) {
                                    controller.changeSaveLogin();
                                  },
                                  activeColor: AppColors.primary,
                                ),
                                const Text(
                                  "تذكرني عند الدخول",
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),
                          CustomSignInButton(
                            onPressed: () => controller.login(),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          );
        },
      ),
    );
  }
}
