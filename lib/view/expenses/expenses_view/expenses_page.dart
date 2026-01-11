import 'package:erad/controller/expenses/expenses_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/expenses/expenses_view/widgets/mobile_expenses_header.dart';
import 'package:erad/view/expenses/expenses_view/widgets/mobile_expenses_summary.dart';
import 'package:erad/view/expenses/expenses_view/widgets/expanses_ListView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExpensesControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isMobile ? null : customAppBar(title: "نفقات", context: context),
      floatingActionButton:
          isMobile
              ? null
              : FloatingActionButton(
                onPressed:
                    () =>
                        Get.find<ExpensesControllerImp>()
                            .showaddExpensesDialog(),
                backgroundColor: AppColors.primary,
                child: Icon(Icons.add, color: AppColors.white),
              ),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile) const SliverToBoxAdapter(child: MobileExpensesHeader()),

          // Summary section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: const MobileExpensesSummary(),
            ),
          ),

          // Expenses list
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
