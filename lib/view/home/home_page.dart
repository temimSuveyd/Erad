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
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_home_appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
        child: Custom_home_gridViewBuilder(),
      ),
    );
  }
}
