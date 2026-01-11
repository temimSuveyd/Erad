import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_add_bill_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/mobile_bill_header.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/mobile_bill_form.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/mobile_products_section.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/mobile_bill_summary.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/mobile_bill_actions.dart';

class CustomerBillAddPage extends GetView<CustomerBiilAddControllerImp> {
  const CustomerBillAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomerBiilAddControllerImp());

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
                : customAppBar(title: "إضافة فاتورة عميل", context: context),
        body: CustomScrollView(
          slivers: [
            // Mobile header (replaces app bar on mobile)
            if (isMobile)
              const SliverToBoxAdapter(
                child: MobileBillHeader(
                  title: 'إضافة فاتورة عميل',
                  subtitle: 'إنشاء فاتورة جديدة للعميل',
                  icon: Icons.receipt_long_outlined,
                ),
              ),

            // Bill form section
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(padding),
                child: const MobileBillForm(),
              ),
            ),

            // Products section
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: const MobileProductsSection(),
              ),
            ),

            // Bill summary
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(padding),
                child: const MobileBillSummary(),
              ),
            ),

            // Action buttons
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(padding),
                child: const MobileBillActions(),
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
