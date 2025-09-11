import 'package:erad/controller/reports/reports_controller.dart';
import 'package:erad/data/data_score/static/reports/reports_data.dart';
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

  // Example data for each category (replace with your real data)
  static const double borclarim = 8000;
  static const double musteriBorclari = 6000;
  static const double masraflar = 4000;
  static const double toplamKazanc = 50000;
  static const double cekilenParalar = 3000;
  static const double mallar = 2000;

  // Example monthly data for each category (replace with your real data)
  static const double borclarimAylik = 1200;
  static const double musteriBorclariAylik = 900;
  static const double masraflarAylik = 700;
  static const double toplamKazancAylik = 8000;
  static const double cekilenParalarAylik = 500;
  static const double mallarAylik = 350;

  static final List<Map<String, dynamic>> cards = [
    {
      'icon': Icons.trending_up_rounded,
      'iconColor': Colors.green,
      'label': "مجمل أرباحي",
      'value': toplamKazanc,
      'monthly': toplamKazancAylik,
      'highlight': true,
    },
    {
      'icon': Icons.account_balance_wallet_rounded,
      'iconColor': Colors.redAccent,
      'label': "ديوني",
      'value': borclarim,
      'monthly': borclarimAylik,
    },
    {
      'icon': Icons.people_alt_rounded,
      'iconColor': Colors.orange,
      'label': "ديون العملاء",
      'value': musteriBorclari,
      'monthly': musteriBorclariAylik,
    },
    {
      'icon': Icons.money_off_csred_rounded,
      'iconColor': Colors.blueGrey,
      'label': "مصاريفي",
      'value': masraflar,
      'monthly': masraflarAylik,
    },
    {
      'icon': Icons.outbound_rounded,
      'iconColor': Colors.purple,
      'label': "مجمل سحب الأموال",
      'value': cekilenParalar,
      'monthly': cekilenParalarAylik,
    },
  ];

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
            SliverToBoxAdapter(child: YearSelector()),
            SliverToBoxAdapter(child: const SizedBox(height: 28)),

            SliverToBoxAdapter(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: List.generate(cards.length, (i) {
                  final card = cards[i];
                  return ReportCard(
                    icon: card['icon'],
                    iconColor: card['iconColor'],
                    label: card['label'],
                    value: card['value'],
                    monthlyValue: card['monthly'],
                    cardWidth: Get.width * 0.16,
                    highlight: false,

                    isSelected: false,
                  );
                }),
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
