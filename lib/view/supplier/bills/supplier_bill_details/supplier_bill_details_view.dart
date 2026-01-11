import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/bills/suppliers_bill_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/widgets/mobile_supplier_bill_details_header.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/widgets/mobile_supplier_bill_info_card.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/widgets/mobile_supplier_bill_products_section.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/widgets/mobile_supplier_bill_summary_section.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/widgets/mobile_supplier_bill_actions_section.dart';

class SupplierBillDetailsPage
    extends GetView<SuppliersBillDetailsControllerImp> {
  const SupplierBillDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SuppliersBillDetailsControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile
              ? null
              : customAppBar(title: "تفاصيل الفاتورة", context: context),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile)
            const SliverToBoxAdapter(child: MobileSupplierBillDetailsHeader()),

          // Bill info card
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: const MobileSupplierBillInfoCard(),
            ),
          ),

          // Products section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: const MobileSupplierBillProductsSection(),
            ),
          ),

          // Bill summary
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: const MobileSupplierBillSummarySection(),
            ),
          ),

          // Action buttons
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: const MobileSupplierBillActionsSection(),
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
