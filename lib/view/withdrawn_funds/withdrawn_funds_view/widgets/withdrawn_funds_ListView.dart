import 'package:erad/controller/withdrawn_funds/withdrawn_funds_controller.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/withdrawn_fund/withdrawn_fund_card_model.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_view/widgets/custom_withdrawn_funds_card.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_view/widgets/mobile_withdrawn_funds_card.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ExpansesListView extends StatelessWidget {
  const ExpansesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawnFundsControllerImp>(
      builder: (controller) {
        // Handle different states
        if (controller.statusreqest == Statusreqest.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.statusreqest == Statusreqest.faliure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: DesignTokens.spacing16),
                Text(
                  'حدث خطأ في تحميل البيانات',
                  style: DesignTokens.getBodyLarge(context),
                ),
                const SizedBox(height: DesignTokens.spacing16),
                ElevatedButton(
                  onPressed: () => controller.getWithdrawnFunds(),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (controller.statusreqest == Statusreqest.success) {
          if (controller.withdrawnFundsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: DesignTokens.spacing16),
                  Text(
                    'لا توجد أموال مسحوبة',
                    style: DesignTokens.getBodyLarge(context),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.withdrawnFundsList.length,
            itemBuilder: (context, index) {
              final isMobile = DesignTokens.isMobile(context);

              if (isMobile) {
                // Use mobile card for mobile devices
                return MobileWithdrawnFundsCard(
                  withdrawnFundCardModel: WithdrawnFundCardModel.formatJson(
                    controller.withdrawnFundsList[index],
                  ),
                );
              } else {
                // Use desktop card for larger screens
                return WithdrawnFundsCard(
                  withdrawnFundCardModel: WithdrawnFundCardModel.formatJson(
                    controller.withdrawnFundsList[index],
                  ),
                );
              }
            },
          );
        }

        // Default case
        return const SizedBox.shrink();
      },
    );
  }
}
