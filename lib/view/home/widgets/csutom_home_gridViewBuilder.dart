import 'package:erad/data/data_score/static/home/home_page_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:erad/controller/home/home_controller.dart';
import 'package:erad/data/model/home/home_modle.dart';
import 'package:erad/view/home/widgets/custom_home_card.dart';

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
          crossAxisSpacing: 40,
          mainAxisSpacing: 50,
        ),
        itemCount: home_page_data.length ,
        itemBuilder:
            (context, index) => Custom_home_card(
              homeModle: HomeModle(
               home_page_data[index].imagePath,
               home_page_data[index].pageName,
               home_page_data[index].title,
              ),
            ),
      ),
    );
  }
}
