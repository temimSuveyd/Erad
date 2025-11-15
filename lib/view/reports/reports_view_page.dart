import 'package:erad/controller/reports/reports_controller.dart';
import 'package:erad/core/class/handling_data_view.dart';
import 'package:erad/data/data_score/static/reports/reports_data.dart';
import 'package:erad/data/data_score/static/witdrawn_fund/total_amounts_cards_data.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/reports/widgets/charts_gridView.dart';
import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/reports/widgets/date_selector.dart';
import 'package:erad/view/reports/widgets/report_card.dart';
import 'package:erad/view/reports/widgets/chart_area.dart';
import 'package:get/get.dart';

class ReportsViewPage extends StatelessWidget {
  const ReportsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReportsControllerImpl());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "التقارير"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: GetBuilder<ReportsControllerImpl>(
                builder:
                    (controller) => YearSelector(
                      year: controller.selectedDate.year,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("اختر السنة"),
                              content: SizedBox(
                                width: 100,
                                height: 250,
                                child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    int year = DateTime.now().year - index;
                                    return ListTile(
                                      title: Text(year.toString()),
                                      onTap: () {
                                        controller.setYear(year);
                                        Get.back();
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 28)),
            SliverToBoxAdapter(
              child: GetBuilder<ReportsControllerImpl>(
                builder:
                    (controller) => Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: List.generate(controller.cardsList.length, (i) {
                        final card = totalAmountCards[i];
                        return ReportCard(
                          includeDebts: controller.includeDebts,
                          onDebtCheckChanged: (value) {
                            controller.debtCheckChanged();
                          },
                          showDebtCheck: card.showDebtCheck!,
                          dropdownIds:
                              controller.allUsersList
                                  .map((e) => e.toString())
                                  .toList(),
                          dropdownItems:
                              controller.allUsersNameList
                                  .map((e) => e.toString())
                                  .toList(),
                          dropdownValue:
                              controller.selectedUserId != null
                                  ? controller.selectedUserId!
                                  : "كافة المستخدمين",
                          onChanged: (value) {
                            controller.changeUser(value);
                          },
                          showDropDownMenu: card.showDropDownMenu!,
                          icon: card.icon!,
                          iconColor: card.color!,
                          label: card.title!,
                          value: controller.cardsList[i],
                        );
                      }),
                    ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 28)),

            SliverToBoxAdapter(
              child: GetBuilder<ReportsControllerImpl>(
                builder:
                    (controller) => SizedBox(
                      width: Get.width * 0.9,
                      child: ChartArea(
                        totalList: controller.totalEraningsMonthly,
                        title: "إجمالي أرباحي",
                        primaryColor: AppColors.green,
                      ),
                    ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 28)),
            ChartsGridViewBuilder(),
          ],
        ),
      ),
    );
  }
}
