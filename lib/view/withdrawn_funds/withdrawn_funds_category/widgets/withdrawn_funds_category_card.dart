import 'package:erad/controller/expenses/expenses_category_controller.dart';
import 'package:erad/controller/withdrawn_funds/withdrawn_funds_category_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesCategoryCard extends GetView<WithdrawnFundsCategoryControllerImp> {
  const ExpensesCategoryCard({
    super.key,
    required this.id,
    required this.title,
  });
  final String title;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: AppColors.primary.withOpacity(0.08),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.18),
          child: const Icon(Icons.attach_money, color: Colors.white),
        ),
        trailing: SizedBox(
          width: 450,
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 10,
            children: [
              Custom_button(
                icon: Icons.edit,
                title: "تعديل",
                onPressed: () {
                  controller.showEditWithdrawnFundsCategoryDailog(id, title);
                },
                color: AppColors.primary,
              ),
              Custom_button(
                icon: Icons.delete,
                title: "حذف",
                onPressed: () {
                  controller.showaDeleteWithdrawnFundsCategoryDailog(id);
                },
                color: AppColors.red,
              ),
              Custom_button(
                icon: Icons.open_in_new,
                title: "الأموال المسحوبة",
                onPressed: () {
                  controller.goTOWithdrawnFundsPage(id);
                },
                color: AppColors.grey,
              ),
            ],
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          overflow: TextOverflow.ellipsis,
        ),

        titleAlignment: ListTileTitleAlignment.center,
      ),
    );
  }
}
