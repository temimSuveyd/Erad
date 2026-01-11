import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/customers_view/customers_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/custom_widgets/custom_drop_down_button.dart';
import 'package:erad/view/custom_widgets/custom_app_bar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/customer/customers_view/widgets/custom_brands_heder.dart';
import 'package:erad/view/customer/customers_view/widgets/custom_brands_listView.dart';
import 'package:erad/view/customer/customers_view/widgets/mobile_customers_header.dart';

class CustomersViewPage extends GetView<CustomersControllerImp> {
  const CustomersViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomersControllerImp());

    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isMobile ? null : customAppBar(title: "زبائني", context: context),
      body: Column(
        children: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile) const MobileCustomersHeader(),

          // Filters section
          Container(
            padding: EdgeInsets.all(padding),
            child: _buildFiltersSection(context, isMobile),
          ),

          // Desktop header - only show on desktop
          if (!isMobile)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Custom_customers_heder(),
            ),

          const SizedBox(height: 16),

          // Customers list
          Expanded(
            child: Padding(
              padding:
                  isMobile
                      ? EdgeInsets.zero
                      : EdgeInsets.symmetric(horizontal: padding),
              child: const CustomCustomersListView(),
            ),
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
            hintText: 'البحث عن العملاء',
            suffixIcon: Icons.search,
            validator: (String? validator) => null,
            controller: controller.search_controller,
            onChanged: (p0) {
              controller.searchForCustomersBayName();
            },
          ),
          const SizedBox(height: DesignTokens.spacing12),
          GetBuilder<CustomersControllerImp>(
            builder:
                (controller) => CustomDropDownButton(
                  onChanged: (String value) {
                    controller.searchForCustomersBayCity(value);
                  },
                  hint: controller.customer_city,
                  items: city_data,
                  value: '',
                ),
          ),
        ],
      );
    } else {
      // Desktop: Horizontal row (existing implementation)
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomTextField(
              hintText: 'ابحث عن العملاء',
              suffixIcon: Icons.search,
              validator: (String? validator) => null,
              controller: controller.search_controller,
              onChanged: (p0) {
                controller.searchForCustomersBayName();
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GetBuilder<CustomersControllerImp>(
              builder:
                  (controller) => CustomDropDownButton(
                    onChanged: (String value) {
                      controller.searchForCustomersBayCity(value);
                    },
                    hint: controller.customer_city,
                    items: city_data,
                    value: '',
                  ),
            ),
          ),
        ],
      );
    }
  }
}
