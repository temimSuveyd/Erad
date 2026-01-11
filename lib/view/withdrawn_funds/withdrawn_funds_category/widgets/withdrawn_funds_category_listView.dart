import 'package:erad/controller/withdrawn_funds/withdrawn_funds_category_controller.dart';
import 'package:erad/core/class/handling_data_view.dart' show HandlingDataView;
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_category/widgets/withdrawn_funds_category_card.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_category/widgets/mobile_user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesCategoryListView extends StatelessWidget {
  const ExpensesCategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawnFundsCategoryControllerImp>(
      builder:
          (controller) => HandlingDataView(
            onPressed: () => controller.getWithdrawnFunds(),
            statusreqest: controller.statusreqest,
            widget: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.withdrawnFundDataList.length,
              itemBuilder: (context, index) {
                final isMobile = DesignTokens.isMobile(context);

                if (isMobile) {
                  // Use mobile user card for mobile devices
                  return MobileUserCard(
                    id: controller.withdrawnFundDataList[index].id,
                    userName: controller.withdrawnFundDataList[index]["userId"],
                  );
                } else {
                  // Use desktop card for larger screens
                  return ExpensesCategoryCard(
                    id: controller.withdrawnFundDataList[index].id,
                    title: controller.withdrawnFundDataList[index]["userId"],
                  );
                }
              },
            ),
          ),
    );
  }
}
