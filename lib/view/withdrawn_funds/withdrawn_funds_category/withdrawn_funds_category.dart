import 'package:erad/controller/withdrawn_funds/withdrawn_funds_category_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_category/widgets/mobile_users_header.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_category/widgets/withdrawn_funds_category_listView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawnFundsCategoryPage extends StatelessWidget {
  const WithdrawnFundsCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WithdrawnFundsCategoryControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile
              ? null
              : customAppBar(title: "إدارة المستخدمين", context: context),
      floatingActionButton:
          isMobile
              ? null
              : FloatingActionButton(
                onPressed:
                    () =>
                        Get.find<WithdrawnFundsCategoryControllerImp>()
                            .showaddWithdrawnFundsCategoryDailog(),
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person_add, color: AppColors.white),
              ),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile) const SliverToBoxAdapter(child: MobileUsersHeader()),

          // Content
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: ExpensesCategoryListView(),
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
