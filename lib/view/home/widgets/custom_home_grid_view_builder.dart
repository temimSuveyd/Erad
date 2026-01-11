import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/data_score/static/home/home_page_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:erad/controller/home/home_controller.dart';
import 'package:erad/data/model/home/home_modle.dart';
import 'package:erad/view/home/widgets/custom_home_card.dart';

class CustomHomeGridViewBuilder extends StatelessWidget {
  const CustomHomeGridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerImp>(
      builder:
          (controller) => LayoutBuilder(
            builder: (context, constraints) {
              // Responsive grid configuration
              final crossAxisCount = DesignTokens.getGridCrossAxisCount(
                context,
              );
              final spacing = DesignTokens.spacing16;

              // Calculate item height based on screen size
              final itemHeight = DesignTokens.isMobile(context) ? 145.0 : 150.0;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: itemHeight,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                ),
                itemCount: home_page_data.length,
                itemBuilder:
                    (context, index) => CustomHomeCard(
                      homeModle: HomeModle(
                        home_page_data[index].imagePath,
                        home_page_data[index].pageName,
                        home_page_data[index].title,
                      ),
                    ),
              );
            },
          ),
    );
  }
}
