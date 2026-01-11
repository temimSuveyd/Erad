import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/depts/customer_dept_details_controller.dart';
import 'package:erad/core/class/handling_data_view.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/customer/customer_debt_details/widgets/mobile_debt_details_header.dart';
import 'package:erad/view/customer/customer_debt_details/widgets/mobile_debt_summary_card.dart';
import 'package:erad/view/customer/customer_debt_details/widgets/mobile_date_filter_section.dart';
import 'package:erad/view/customer/customer_debt_details/widgets/mobile_bills_section.dart';
import 'package:erad/view/customer/customer_debt_details/widgets/mobile_payments_section.dart';

class CustomerDebtsDetailsPage
    extends GetView<CustomerDeptsDetailsControllerImp> {
  const CustomerDebtsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomerDeptsDetailsControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile
              ? null
              : customAppBar(title: "تفاصيل الديون", context: context),
      body: GetBuilder<CustomerDeptsDetailsControllerImp>(
        builder:
            (controller) => HandlingDataView(
              onPressed: () => controller.getDeptDetails(),
              statusreqest: controller.statusreqest,
              widget: CustomScrollView(
                slivers: [
                  // Mobile header (replaces app bar on mobile)
                  if (isMobile)
                    const SliverToBoxAdapter(child: MobileDebtDetailsHeader()),

                  // Debt summary card
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(padding),
                      child: const MobileDebtSummaryCard(),
                    ),
                  ),

                  // Date filter section
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: const MobileDateFilterSection(),
                    ),
                  ),

                  // Bills section
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(padding),
                      child: const MobileBillsSection(),
                    ),
                  ),

                  // Payments section
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(padding),
                      child: const MobilePaymentsSection(),
                    ),
                  ),

                  // Bottom padding for mobile
                  if (isMobile)
                    const SliverToBoxAdapter(
                      child: SizedBox(height: DesignTokens.spacing24),
                    ),
                ],
              ),
            ),
      ),
    );
  }
}
