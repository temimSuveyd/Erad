import 'package:erad/view/home/widgets/custom_home_appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/home/home_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/home/widgets/csutom_home_gridViewBuilder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return Scaffold(
      appBar: Custom_home_appBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.surfaceVariant.withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Custom_home_gridViewBuilder(),
          ),
        ),
      ),
    );
  }
}
