import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/home/widgets/custom_home_appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/home/home_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/home/widgets/custom_home_grid_view_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: customHomeAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final padding = DesignTokens.getResponsiveSpacing(context);

          return Padding(
            padding: EdgeInsets.all(padding),
            child: const CustomHomeGridViewBuilder(),
          );
        },
      ),
    );
  }
}
