import 'package:erad/controller/expenses/expenses_category_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/expenses/expenses_category/widgets/mobile_expenses_category_header.dart';
import 'package:erad/view/expenses/expenses_category/widgets/expenses_category_listView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesCategoryPage extends StatelessWidget {
  const ExpensesCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExpensesCategoryControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile
              ? null
              : customAppBar(title: "فئة الإنفاق", context: context),
      floatingActionButton:
          isMobile
              ? null
              : FloatingActionButton(
                onPressed:
                    () =>
                        Get.find<ExpensesCategoryControllerImp>()
                            .showaddExpensesCategoryDailog(),
                backgroundColor: AppColors.primary,
                child: Icon(Icons.add, color: AppColors.white),
              ),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile)
            const SliverToBoxAdapter(child: MobileExpensesCategoryHeader()),

          // Categories list
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
