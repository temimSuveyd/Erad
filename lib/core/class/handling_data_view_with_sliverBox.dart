import 'package:flutter/material.dart';
import 'package:Erad/core/class/handling_data.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/core/constans/images.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';

class HandlingDataViewWithSliverBox extends StatelessWidget {
  const HandlingDataViewWithSliverBox({
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
      return SliverToBoxAdapter(
        child: Center(
          child: SizedBox(
            height: 300,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [CircularProgressIndicator(color: AppColors.primary)],
            ),
          ),
        ),
      );
    }
    if (statusreqest == Statusreqest.faliure) {
      return SliverToBoxAdapter(
        child: Center(
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
                Custom_button( color: AppColors.primary,
                  icon: Icons.refresh,
                  title: "حاول ثانية",
                  onPressed: () => onPressed(),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (statusreqest == Statusreqest.noData) {
      return SliverToBoxAdapter(
        child: Center(
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
        ),
      );
    }
    if (statusreqest == Statusreqest.noInternet) {
      return SliverToBoxAdapter(
        child: Center(
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
                Custom_button( color: AppColors.primary,
                  icon: Icons.refresh,
                  title: "حاول ثانية",
                  onPressed: () => onPressed(),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (statusreqest == Statusreqest.notAdded) {
      return SliverToBoxAdapter(
        child: Center(
          child: SizedBox(
            height: 300,
            width: 400,
            child: Center(
              child: Text(
                " للإضافة انقر فوق الزر إضافة +",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),
      );
    }
    if (statusreqest == Statusreqest.success) {
      return widget;
    } else {
      return SliverToBoxAdapter(child: SizedBox());
    }
  }
}
