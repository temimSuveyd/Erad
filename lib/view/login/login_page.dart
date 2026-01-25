import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:erad/controller/auth/login_controller.dart';
import 'package:erad/view/login/widgets/simple_account_square.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginControllerImp());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.primaryLight,
              AppColors.background,
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: Center(child: Account_Square()),
      ),
    );
  }
}
