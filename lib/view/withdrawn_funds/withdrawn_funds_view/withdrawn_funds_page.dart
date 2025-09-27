import 'package:erad/controller/withdrawn_funds/withdrawn_funds_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_view/widgets/custom_total_expenses_container.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_view/widgets/withdrawn_funds_ListView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawnFundsPage extends StatelessWidget {
  const WithdrawnFundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WithdrawnFundsControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "الأموال المسحوبة"),
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
