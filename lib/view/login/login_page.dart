import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:erad/controller/auth/login_controller.dart';
import 'package:erad/view/login/widgets/custom_account_square.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Account_Square()),
    );
  }
}
