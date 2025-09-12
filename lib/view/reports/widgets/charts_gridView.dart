import 'package:erad/controller/reports/reports_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/data/data_score/static/reports/reports_data.dart';
import 'package:erad/view/reports/widgets/chart_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ChartsGridViewBuilder extends StatelessWidget {
  const ChartsGridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportsControllerImpl>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getAllCustomerBills(),
            statusreqest: controller.statusreqest,
            widget: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 1.3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount:  controller.chartsLists.length,
              itemBuilder:
                  (context, index) => ChartArea(
                    totalList: controller.chartsLists[index],
                    title: reportsChartsData[index].title,
                    primaryColor: reportsChartsData[index].color,
                  ),
            ),
          ),
    );
  }
}
