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
  
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 250,
          crossAxisSpacing: 50,
          mainAxisSpacing: 50,
        ),
        itemCount: controller.homeData.length,
        itemBuilder:
            (context, index) => Custom_home_card(
              homeModle: HomeModle(
                controller.homeData[index].imagePath,
                controller.homeData[index].pageName,
                controller.homeData[index].title,
              ),
            ),
      ),
    );
  }
}
