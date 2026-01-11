import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/bills/suppliers_bill_add_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_add/widgets/mobile_supplier_bill_header.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_add/widgets/mobile_supplier_bill_form.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_add/widgets/mobile_supplier_products_section.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_add/widgets/mobile_supplier_bill_summary.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_add/widgets/mobile_supplier_bill_actions.dart';

class SuppliersBillAddPage extends GetView<SupplierBiilAddControllerImp> {
  const SuppliersBillAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SupplierBiilAddControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldPop = await controller.onWillPop();
          if (shouldPop && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar:
            isMobile
                ? null
                : customAppBar(title: "إضافة فاتورة المورد", context: context),
        body: CustomScrollView(
          slivers: [
            // Mobile header (replaces app bar on mobile)
            if (isMobile)
              const SliverToBoxAdapter(
                child: MobileSupplierBillHeader(
                  title: 'إضافة فاتورة مورد',
                  subtitle: 'إنشاء فاتورة شراء جديدة من المورد',
                  icon: Icons.receipt_outlined,
                ),
              ),

            // Bill form section
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(padding),
                child: const MobileSupplierBillForm(),
              ),
            ),

            // Products section
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: const MobileSupplierProductsSection(),
              ),
            ),

            // Bill summary
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(padding),
                child: const MobileSupplierBillSummary(),
              ),
            ),

            // Action buttons
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(padding),
                child: const MobileSupplierBillActions(),
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
    );
  }
}
