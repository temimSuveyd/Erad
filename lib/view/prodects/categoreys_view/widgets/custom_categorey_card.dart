import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:erad/controller/categoreys/categorey_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_title_text_container.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';

// ignore: camel_case_types
class Custom_categorey_card extends GetView<CategoreyControllerImp> {
  const Custom_categorey_card({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final String count;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.grey,
          ),

          child: Row(
            spacing: 25,
            children: [
              Custom_title_text_container(title: title),
              Custom_button(
                color: AppColors.primary,
                icon: Icons.edit,
                onPressed: () => controller.show_edit_dialog(title),
                title: "تحرير",
              ),
              Custom_button(
                color: AppColors.primary,
                icon: Icons.delete_forever,
                onPressed: () => controller.show_delete_dialog(title),
                title: "حذف",
              ),
              Custom_button(
                color: AppColors.primary,
                icon: Icons.open_in_browser_outlined,
                onPressed: () => controller.go_to_gategorey_type_page(title),

                title: "تفاصيل",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
