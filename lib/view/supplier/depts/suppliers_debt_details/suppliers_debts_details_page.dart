import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/depts/supplier_depts_details_controller.dart';
import 'package:erad/core/class/handling_data_view.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/supplier/depts/suppliers_debt_details/widgets/mobile_supplier_debt_details_header.dart';
import 'package:erad/view/supplier/depts/suppliers_debt_details/widgets/mobile_supplier_debt_summary_card.dart';
import 'package:erad/view/supplier/depts/suppliers_debt_details/widgets/mobile_supplier_date_filter_section.dart';
import 'package:erad/view/supplier/depts/suppliers_debt_details/widgets/mobile_supplier_bills_section.dart';
import 'package:erad/view/supplier/depts/suppliers_debt_details/widgets/mobile_supplier_payments_section.dart';

class SupplierDebtsDetailsPage
    extends GetView<SupplierDeptsDetailsControllerImpl> {
  const SupplierDebtsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SupplierDeptsDetailsControllerImpl());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile
              ? null
              : customAppBar(title: "تفاصيل الديون", context: context),
      body: GetBuilder<SupplierDeptsDetailsControllerImpl>(
        builder:
            (controller) => HandlingDataView(
              onPressed: () => controller.getDeptDetails(),
              statusreqest: controller.statusreqest,
              widget: CustomScrollView(
                slivers: [
                  // Mobile header (replaces app bar on mobile)
                  if (isMobile)
                    const SliverToBoxAdapter(
                      child: MobileSupplierDebtDetailsHeader(),
                    ),

                  // Debt summary card
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(padding),
                      child: const MobileSupplierDebtSummaryCard(),
                    ),
                  ),

                  // Date filter section
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: const MobileSupplierDateFilterSection(),
                    ),
                  ),

                  // Bills section
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(padding),
                      child: const MobileSupplierBillsSection(),
                    ),
                  ),

                  // Payments section
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(padding),
                      child: const MobileSupplierPaymentsSection(),
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
