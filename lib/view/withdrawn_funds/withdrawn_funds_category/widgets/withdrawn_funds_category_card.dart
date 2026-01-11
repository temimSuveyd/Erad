import 'package:erad/controller/withdrawn_funds/withdrawn_funds_category_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesCategoryCard
    extends GetView<WithdrawnFundsCategoryControllerImp> {
  const ExpensesCategoryCard({
    super.key,
    required this.id,
    required this.title,
  });
  final String title;
  final String id;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: AppColors.grey,
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.18),
          child: const Icon(Icons.attach_money, color: Colors.white),
        ),
        trailing: SizedBox(
          width: isDesktop ? 500 : screenWidth * 0.4,
          height: 35,
          child:
              isDesktop
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 10,
                    children: [
                      CustomButton(
                        icon: Icons.edit,
                        title: "تعديل",
                        onPressed: () {
                          controller.showEditWithdrawnFundsCategoryDailog(
                            id,
                            title,
                          );
                        },
                        color: AppColors.primary,
                      ),
                      CustomButton(
                        icon: Icons.delete,
                        title: "حذف",
                        onPressed: () {
                          controller.showaDeleteWithdrawnFundsCategoryDailog(
                            id,
                          );
                        },
                        color: AppColors.primary,
                      ),
                      CustomButton(
                        icon: Icons.open_in_new,
                        title: "الأموال المسحوبة",
                        onPressed: () {
                          controller.goTOWithdrawnFundsPage(id);
                        },
                        color: AppColors.primary,
                      ),
                    ],
                  )
                  : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 5,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: AppColors.primary),
                          onPressed: () {
                            controller.showEditWithdrawnFundsCategoryDailog(
                              id,
                              title,
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: AppColors.primary),
                          onPressed: () {
                            controller.showaDeleteWithdrawnFundsCategoryDailog(
                              id,
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.open_in_new,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            controller.goTOWithdrawnFundsPage(id);
                          },
                        ),
                      ],
                    ),
                  ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: isDesktop ? 20 : 16,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        titleAlignment: ListTileTitleAlignment.center,
      ),
    );
  }
}
