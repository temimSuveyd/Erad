import 'dart:ui';
import 'package:erad/core/class/handling_data_view.dart';
import 'package:erad/core/constans/images.dart';
import 'package:erad/core/widgets/safe_image.dart';
import 'package:flutter/material.dart';
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Container(
            decoration: BoxDecoration(
              gradient: AppGradients.primaryGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                AppShadows.large,
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(32),
                  child: GetBuilder<LoginControllerImp>(
                    builder: (controller) => HandlingDataView(
                      statusreqest: controller.statusreqest,
                      onPressed: () => controller.login(),
                      widget: Form(
                        key: controller.formState,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Animated logo and app name
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0, end: 1),
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.elasticOut,
                              builder: (context, value, child) {
                                final clampedValue = value.clamp(0.0, 1.0);
                                return Transform.scale(
                                  scale: clampedValue,
                                  child: Opacity(
                                    opacity: clampedValue,
                                    child: child,
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: AppGradients.primaryGradient,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [AppShadows.medium],
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: AppImages.logo.toSafeImage(
                                      height: 56,
                                      width: 56,
                                      fallbackIcon: Icons.business,
                                      fallbackColor: AppColors.white,
                                      iconSize: 56,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "إراد",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                      letterSpacing: 1.2,
                                      shadows: [
                                        Shadow(
                                          color: AppColors.primary.withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "نظام إدارة الأعمال",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 32),
                            
                            // Company name field
                            _buildAnimatedTextField(
                              delay: 200,
                              child: Custom_login_textfield(
                                hintText: 'اسم الشركة',
                                controller: controller.company_name,
                                prefixIcon: Icons.business,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال اسم الشركة';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Email field
                            _buildAnimatedTextField(
                              delay: 300,
                              child: Custom_login_textfield(
                                hintText: "البريد الإلكتروني",
                                controller: controller.user_email,
                                prefixIcon: Icons.email_outlined,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال البريد الإلكتروني';
                                  }
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                    return 'البريد الإلكتروني غير صحيح';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // Password field
                            _buildAnimatedTextField(
                              delay: 400,
                              child: Custom_login_textfield(
                                hintText: "كلمة المرور",
                                controller: controller.user_password,
                                prefixIcon: Icons.lock_outline,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال كلمة المرور';
                                  }
                                  if (value.length < 6) {
                                    return 'كلمة المرور قصيرة جداً';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Remember me checkbox
                            _buildAnimatedCheckbox(
                              delay: 500,
                              controller: controller,
                            ),

                            const SizedBox(height: 32),
                            
                            // Login button
                            _buildAnimatedButton(
                              delay: 600,
                              child: Custom_sigin_button(
                                onPressed: () => controller.login(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required int delay,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        final clampedValue = value.clamp(0.0, 1.0);
        return Transform.translate(
          offset: Offset(0, 20 * (1 - clampedValue)),
          child: Opacity(opacity: clampedValue, child: child),
        );
      },
    );
  }

  Widget _buildAnimatedCheckbox({
    required int delay,
    required LoginControllerImp controller,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        final clampedValue = value.clamp(0.0, 1.0);
        return Transform.translate(
          offset: Offset(-20 * (1 - clampedValue), 0),
          child: Opacity(opacity: clampedValue, child: _RememberMeCheckbox(controller: controller)),
        );
      },
    );
  }

  Widget _buildAnimatedButton({
    required int delay,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      builder: (context, value, _) {
        final clampedValue = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: 0.8 + (0.2 * clampedValue),
          child: Opacity(opacity: clampedValue, child: child),
        );
      },
    );
  }
}

// Separate widget for better organization
class _RememberMeCheckbox extends StatelessWidget {
  final LoginControllerImp controller;

  const _RememberMeCheckbox({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Checkbox(
            value: controller.isLogin.value,
            onChanged: (value) {
              controller.changeSaveLogin();
            },
            activeColor: AppColors.primary,
            checkColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: BorderSide(
              color: AppColors.textTertiary,
              width: 1.5,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "تذكرني عند الدخول",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
