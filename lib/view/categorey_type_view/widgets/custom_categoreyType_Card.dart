import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:Erad/controller/categoreys/categorey_type_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_title_text_container.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:Erad/view/customer_bills_add/widgets/custom_price_container.dart';

class Custom_categoreyType_Card extends GetView<CategoreyTypeControllerImp> {
  const Custom_categoreyType_Card({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(5),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),

          child: Row(
            spacing: 20,

            children: [
              Custom_title_text_container(title: title),
              Custom_button( color: AppColors.primary,icon: Icons.edit, onPressed: () {}, title: "يحرر"),
              Custom_button( color: AppColors.primary,
                icon: Icons.delete_forever,
                onPressed: () => controller.show_delete_dialog(title),
                title: "حذف",
              ),

              Custom_button( color: AppColors.primary,
                icon: Icons.open_in_browser_outlined,
                onPressed: () => controller.go_to_brand_page(title),
                title: "تفاصيل",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
