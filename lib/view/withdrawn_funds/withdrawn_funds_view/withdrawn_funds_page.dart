import 'package:erad/controller/withdrawn_funds/withdrawn_funds_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_view/widgets/mobile_withdrawn_funds_header.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_view/widgets/mobile_withdrawn_funds_summary.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_view/widgets/withdrawn_funds_ListView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawnFundsPage extends StatelessWidget {
  const WithdrawnFundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WithdrawnFundsControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile
              ? null
              : customAppBar(title: "الأموال المسحوبة", context: context),
      floatingActionButton:
          isMobile
              ? null
              : FloatingActionButton(
                onPressed:
                    () =>
                        Get.find<WithdrawnFundsControllerImp>()
                            .showaddWithdrawnFundsDialog(),
                backgroundColor: AppColors.primary,
                child: Icon(Icons.add, color: AppColors.white),
              ),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile)
            const SliverToBoxAdapter(child: MobileWithdrawnFundsHeader()),

          // Summary section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: const MobileWithdrawnFundsSummary(),
            ),
          ),

          // Funds list
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: ExpansesListView(),
            ),
          ),

          // Bottom padding for mobile
          if (isMobile)
            const SliverToBoxAdapter(
              child: SizedBox(height: DesignTokens.spacing24),
            ),
        ],
      ),
    );
  }
}
