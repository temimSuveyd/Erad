import 'package:erad/controller/expenses/expenses_category_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesCategoryCard extends GetView<ExpensesCategoryControllerImp> {
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
        tileColor: AppColors.grey,
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
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
                  controller.showEditExpensesCategoryDailog(id, title);
                },
                color: AppColors.primary,
              ),
              Custom_button(
                icon: Icons.delete,
                title: "حذف",
                onPressed: () {
                  controller.showaDeleteExpensesCategoryDailog(id);
                },
                color: AppColors.primary,
              ),
              Custom_button(
                icon: Icons.open_in_new,
                title: "تفاصيل",
                onPressed: () {
                  controller.goTOExpensesPage(id);
                },
                color: AppColors.primary,
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
