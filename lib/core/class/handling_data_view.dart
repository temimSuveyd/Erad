import 'package:flutter/material.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/images.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:lottie/lottie.dart';

class HandlingDataView extends StatelessWidget {
  const HandlingDataView({
    super.key,
    required this.statusreqest,
    required this.widget,
    required this.onPressed,
  });
  final Statusreqest statusreqest;
  final Widget widget;
  final dynamic Function() onPressed;
  @override
  Widget build(BuildContext context) {
    if (statusreqest == Statusreqest.loading) {
      return Center(
        child: SizedBox(
          height: 300,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [LottieBuilder.asset(AppImages.loadingAnimation)],
          ),
        ),
      );
    }
    if (statusreqest == Statusreqest.faliure) {
      return Center(
        child: SizedBox(
          width: 300,
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LottieBuilder.asset(AppImages.faliure, height: 170),
              Text(
                "هناك خط غير معروف من فضلك حاول مرة أخرى",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primary,

                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Custom_button(
                icon: Icons.refresh_rounded,
                title: "حاول ثانية",
                onPressed: () => onPressed(),
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      );
    }
    if (statusreqest == Statusreqest.noData) {
      return Center(
        child: SizedBox(
          height: 300,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              // SizedBox(
              //   height: 100,
              //   width: 100,
              //   child: Image.asset(AppImages.noData),
              // ),
              Text(
                "لا بيانات",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (statusreqest == Statusreqest.noInternet) {
      return Center(
        child: SizedBox(
          height: 300,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,

            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(AppImages.noInternet),
              ),
              Text(
                "تم قطع اتصال الإنترنت",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Custom_button(
                color: AppColors.primary,
                icon: Icons.refresh,
                title: "حاول ثانية",
                onPressed: () => onPressed(),
              ),
            ],
          ),
        ),
      );
    }
    if (statusreqest == Statusreqest.success) {
      return widget;
    } else {
      return SizedBox();
    }
  }
}
