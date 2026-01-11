import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_bill_view_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/customer/Customer_bills_view/widgets/custom_list_view_builder.dart';
import 'package:erad/view/customer/Customer_bills_view/widgets/custom_bill_name_list.dart';
import 'package:erad/view/customer/Customer_bills_view/widgets/mobile_bills_header.dart';
import 'package:erad/view/custom_widgets/custom_app_bar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_drop_down_button.dart';
import 'package:erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:erad/view/custom_widgets/show_date_range_picker.dart';

class CustomerBillsViewPage extends GetView<CustomerBillViewControllerImp> {
  const CustomerBillsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomerBillViewControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final isTablet = DesignTokens.isTablet(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile
              ? null
              : customAppBar(title: "فواتير العملاء", context: context),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile) const SliverToBoxAdapter(child: MobileBillsHeader()),

          // Filters section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: _buildFiltersSection(context, isMobile, isTablet),
            ),
          ),

          // Desktop header (column labels) - only show on desktop
          if (!isMobile) const CustomerNameList(),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(
              height: isMobile ? DesignTokens.spacing8 : DesignTokens.spacing16,
            ),
          ),

          // Bills list
          const CustomListViewBuilder(),

          // Bottom padding for mobile
          if (isMobile)
            const SliverToBoxAdapter(
              child: SizedBox(height: DesignTokens.spacing24),
            ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    if (isMobile) {
      // Mobile: Vertical stack with improved spacing
      return Column(
        children: [
          GetBuilder<CustomerBillViewControllerImp>(
            builder:
                (controller) => CustomTextField(
                  hintText: 'البحث باسم العميل',
                  suffixIcon: Icons.search,
                  validator: (String? validator) => null,
                  controller: controller.searchBillsTextController,
                  onChanged: (p0) {
                    controller.searchForBillsBayCustomerName();
                  },
                ),
          ),
          const SizedBox(height: DesignTokens.spacing12),
          GetBuilder<CustomerBillViewControllerImp>(
            builder:
                (controller) => CustomDropDownButton(
                  value: controller.selectedCustomerCity ?? '',
                  onChanged: (value) => controller.searchForBillBayCity(value),
                  hint: controller.selectedCustomerCity ?? "حدد المدينة",
                  items: city_data,
                ),
          ),
          const SizedBox(height: DesignTokens.spacing12),
          GetBuilder<CustomerBillViewControllerImp>(
            builder:
                (controller) => CustomSetDateButton(
                  hintText:
                      controller.selectedDateRange == null
                          ? "${controller.startedDate.year}/${controller.startedDate.month}/${controller.startedDate.day}"
                          : "${controller.selectedDateRange!.start.year}/${controller.selectedDateRange!.start.month}/${controller.selectedDateRange!.start.day} - ${controller.selectedDateRange!.end.year}/${controller.selectedDateRange!.end.month}/${controller.selectedDateRange!.end.day}",
                  onPressed: () {
                    show_date_range_picker(context).then((dateRange) {
                      if (dateRange != null) {
                        controller.searchByDate(dateRange);
                      }
                    });
                  },
                ),
          ),
        ],
      );
    } else {
      // Tablet/Desktop: Horizontal row (existing implementation)
      return Row(
        spacing: DesignTokens.spacing12,
        children: [
          Expanded(
            child: GetBuilder<CustomerBillViewControllerImp>(
              builder:
                  (controller) => CustomTextField(
                    hintText: 'اسم العميل',
                    suffixIcon: Icons.search,
                    validator: (String? validator) => null,
                    controller: controller.searchBillsTextController,
                    onChanged: (p0) {
                      controller.searchForBillsBayCustomerName();
                    },
                  ),
            ),
          ),
          Expanded(
            child: GetBuilder<CustomerBillViewControllerImp>(
              builder:
                  (controller) => CustomDropDownButton(
                    value: controller.selectedCustomerCity ?? '',
                    onChanged:
                        (value) => controller.searchForBillBayCity(value),
                    hint: controller.selectedCustomerCity ?? "حدد المدينة",
                    items: city_data,
                  ),
            ),
          ),
          Expanded(
            child: GetBuilder<CustomerBillViewControllerImp>(
              builder:
                  (controller) => CustomSetDateButton(
                    hintText:
                        controller.selectedDateRange == null
                            ? "${controller.startedDate.year}/${controller.startedDate.month}/${controller.startedDate.day}"
                            : "${controller.selectedDateRange!.start.year}/${controller.selectedDateRange!.start.month}/${controller.selectedDateRange!.start.day} - ${controller.selectedDateRange!.end.year}/${controller.selectedDateRange!.end.month}/${controller.selectedDateRange!.end.day}",
                    onPressed: () {
                      show_date_range_picker(context).then((dateRange) {
                        if (dateRange != null) {
                          controller.searchByDate(dateRange);
                        }
                      });
                    },
                  ),
            ),
          ),
        ],
      );
    }
  }
}
