import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/reports/reports_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/reports/widgets/mobile_reports_header.dart';
import 'package:erad/view/reports/widgets/mobile_summary_cards.dart';
import 'package:erad/view/reports/widgets/mobile_year_selector.dart';
import 'package:erad/view/reports/widgets/mobile_chart_section.dart';

class ReportsViewPage extends StatelessWidget {
  const ReportsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReportsControllerImpl());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile
              ? null
              : customAppBar(title: "التقارير السنوية", context: context),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile) const SliverToBoxAdapter(child: MobileReportsHeader()),

          // Year selector
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: const MobileYearSelector(),
            ),
          ),

          // Summary cards
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: const MobileSummaryCards(),
            ),
          ),

          // Chart section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: const MobileChartSection(),
            ),
          ),

          // Detailed statistics
          // SliverToBoxAdapter(
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: padding),
          //     child: const MobileDetailedStats(),
          //   ),
          // ),

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
