import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:erad/controller/home/home_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/data/model/home/home_modle.dart';

class Custom_home_card extends GetView<HomeControllerImp> {
  const Custom_home_card({super.key, required this.homeModle});

  final HomeModle homeModle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () {
        controller.goToPage(homeModle.pageName!);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.black.withOpacity(0.7),
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.30),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.18),
                  width: 2,
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                homeModle.imagePath ?? '',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Icon(
                      Icons.image_not_supported,
                      size: 54,
                      color: AppColors.primary.withOpacity(0.3),
                    ),
              ),
            ),
            SizedBox(height: 18),
            Text(
              homeModle.title ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: AppColors.wihet,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.7,
                shadows: [
                  Shadow(
                    color: AppColors.primary.withOpacity(0.20),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 6),
            // Container(
            //   width: 36,
            //   height: 4,
            //   decoration: BoxDecoration(
            //     color: AppColors.primary.withOpacity(0.12),
            //     borderRadius: BorderRadius.circular(2),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
