import 'package:erad/controller/withdrawn_funds/withdrawn_funds_category_controller.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_category/widgets/custom_FloatingActionButton.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_category/widgets/withdrawn_funds_category_listView.dart';
import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:get/get.dart';

class WithdrawnFundsCategoryPage extends StatelessWidget {
  const WithdrawnFundsCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WithdrawnFundsCategoryControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "المستخدمون"),
      floatingActionButton: CustomFloatingActionButton(),

      body: ExpensesCategoryListView(),
    );
  }
}
