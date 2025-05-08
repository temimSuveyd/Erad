import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:suveyd_ticaret/controller/home_controller.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/data/model/home/home_modle.dart';

class Custom_home_card extends GetView<HomeControllerImp> {
  const Custom_home_card({super.key, required this.homeModle,});

  final HomeModle homeModle;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColors.wihet,
      padding: EdgeInsets.all(20),
      onPressed: () {
       controller.goToPage(homeModle.pageName!);
      },
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColors.primary, width: 1),
      ),

      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(homeModle.icon, size: 100, color: AppColors.primary, weight: 2),
          Text(
            homeModle.title!,
            style: TextStyle(
              fontSize: 30,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
