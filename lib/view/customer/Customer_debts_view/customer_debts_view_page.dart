import 'package:erad/controller/customers/depts/customer_depts_view_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/customer/Customer_debts_view/widgets/custom_dept_name_list.dart';
import 'package:erad/view/customer/Customer_debts_view/widgets/custom_list_view_builder.dart';
import 'package:erad/view/customer/Customer_debts_view/widgets/mobile_customer_debts_header.dart';
import 'package:flutter/material.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:get/get.dart';

class CustomerDebtsViewPage extends GetView<CustomerDeptsViewControllerImp> {
  const CustomerDebtsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      appBar:
          isMobile
              ? null
              : customAppBar(title: "ديون العملاء", context: context),
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile)
            const SliverToBoxAdapter(child: MobileCustomerDebtsHeader()),

          // Filters section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: _buildFiltersSection(context, isMobile),
            ),
          ),

          // Desktop header (column labels) - only show on desktop
          if (!isMobile) const CustomerDeptNameList(),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(
              height: isMobile ? DesignTokens.spacing8 : DesignTokens.spacing16,
            ),
          ),

          // Debts list
          const CustomDeptsListView(),

          // Bottom padding for mobile
          if (isMobile)
            const SliverToBoxAdapter(
              child: SizedBox(height: DesignTokens.spacing24),
            ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(BuildContext context, bool isMobile) {
    if (isMobile) {
      // Mobile: Vertical stack with improved spacing
      return Column(
        children: [
          CustomTextField(
            hintText: 'البحث باسم العميل أو رقم الفاتورة',
            suffixIcon: Icons.search,
            validator: (p0) => null,
            controller: controller.searchDeptsTextController,
            onChanged: (value) => controller.searchForBillsBayCustomerName(),
          ),
          const SizedBox(height: DesignTokens.spacing12),
          CustomDropDownButton(
            value: controller.selectedCustomerCity,
            onChanged: (value) => controller.searchForBillBayCity(value),
            hint: 'اختر المدينة',
            items: city_data,
          ),
        ],
      );
    } else {
      // Desktop: Horizontal row (existing implementation)
      return Row(
        spacing: DesignTokens.spacing20,
        children: [
          Expanded(
            child: CustomTextField(
              hintText: 'اسم او رقم الفاتورة',
              suffixIcon: Icons.search,
              validator: (p0) => null,
              controller: controller.searchDeptsTextController,
              onChanged: (value) => controller.searchForBillsBayCustomerName(),
            ),
          ),
          Expanded(
            child: CustomDropDownButton(
              value: controller.selectedCustomerCity,
              onChanged: (value) => controller.searchForBillBayCity(value),
              hint: 'اختر المدينة',
              items: city_data,
            ),
          ),
        ],
      );
    }
  }
}
