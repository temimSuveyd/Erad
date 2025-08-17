import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:Erad/controller/home/home_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/data/data_score/static/home/home_pages_data.dart';

// ignore: camel_case_types
class Custom_set_page_container extends StatelessWidget {
  const Custom_set_page_container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.primary,
      ),
      // padding: EdgeInsets.all(5),
      child: GetBuilder<HomeControllerImp>(
        builder:
            (controller) => Row(
              children: [
                ...List.generate(
                  2,
                  (index) => Custom_set_page_button(
                    container_color:
                        index == controller.buttonIndex
                            ? AppColors.wihet
                            : Colors.transparent,
                    text_color:
                        index == controller.buttonIndex
                            ? AppColors.grey
                            : AppColors.wihet,
                    onPressed: () => controller.setPage(index),
                    title: home_pages_data[index].title!,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}

class Custom_set_page_button extends StatelessWidget {
  const Custom_set_page_button({
    super.key,
    required this.onPressed,

    required this.title,
    required this.container_color,
    required this.text_color,
  });

  final void Function() onPressed;
  final Color container_color;
  final Color text_color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: container_color,
        ),

        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: text_color,
            ),
          ),
        ),
      ),
    );
  }
}
