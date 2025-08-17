import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:Erad/controller/home/home_controller.dart';
import 'package:Erad/data/model/home/home_modle.dart';
import 'package:Erad/view/home/widgets/custom_home_card.dart';

class Custom_home_gridViewBuilder extends StatelessWidget {
  const Custom_home_gridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerImp>(
      builder: (controller) => 
     GridView.builder(
        // physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 320,
          mainAxisExtent: 200,
          crossAxisSpacing: 100,
          mainAxisSpacing: 100,
        ),
        itemCount: controller.homeData.length,
        itemBuilder:
            (context, index) => Custom_home_card(
              homeModle: HomeModle(
                controller.homeData[index].icon,
                controller.homeData[index].pageName,
                controller.homeData[index].title,
              ),
            ),
      ),
    );
  }
}
