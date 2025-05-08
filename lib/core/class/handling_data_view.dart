import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/class/handling_data.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/core/constans/images.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_add_button.dart';

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
            children: [CircularProgressIndicator(color: AppColors.primary)],
          ),
        ),
      );
    }
    if (statusreqest == Statusreqest.faliure) {
      return Center(
        child: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(AppImages.faliure),
              ),
              Text(
                "حدث خطأ ، يرجى المحاولة مرة أخرى",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Custom_button(
                icon: Icons.refresh,
                title: "حاول ثانية",
                onPressed: () => onPressed(),
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
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(AppImages.noData),
              ),
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
