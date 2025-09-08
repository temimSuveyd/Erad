import 'package:erad/controller/expenses/expenses_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/expenses/expenses_view/widgets/custom_total_expenses_container.dart';
import 'package:erad/view/expenses/expenses_view/widgets/expanses_ListView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExpensesControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "نفقات"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: CustomScrollView(
          slivers: [
            TotalexpensesContainer(),
            SliverToBoxAdapter(child: const SizedBox(height: 24)),
            ExpansesListView(),
          ],
        ),
      ),
    );
  }
}
