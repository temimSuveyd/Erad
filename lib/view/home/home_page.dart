import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/controller/home/home_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/home/widgets/csutom_home_gridViewBuilder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // appBar: Custom_home_appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
        child: Custom_home_gridViewBuilder(),
      ),
    );
  }
}
