import 'package:erad/controller/withdrawn_funds/withdrawn_funds_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/data/model/withdrawn_fund/withdrawn_fund_card_model.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_view/widgets/custom_withdrawn_funds_card.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ExpansesListView extends StatelessWidget {
  const ExpansesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawnFundsControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getWithdrawnFunds(),
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.withdrawnFundsList.length,
              itemBuilder:
                  (context, index) => WithdrawnFundsCard(
                    withdrawnFundCardModel: WithdrawnFundCardModel.formatJson(
                      controller.withdrawnFundsList[index],
                    ),
                  ),
            ),
          ),
    );
  }
}
