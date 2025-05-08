import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/Customer_bills_view/widgets/custom_list_view_builder.dart';
import 'package:suveyd_ticaret/view/Customer_bills_view/widgets/custom_name_list.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_appBar.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_search_text_field.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom__dropDownButton.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_set_date_button.dart';

class CustomerBillsViewPage extends StatelessWidget {
  CustomerBillsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "فواتير العملاء"),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 10,
                children: [
                  Custom_textfield(
                    hintText: 'اسم العميل',
                    suffixIcon: Icons.search,
                    validator: (String? validator) {},
                    controller: null,
                    onChanged: (p0) {},
                  ),
                  Custom_set_date_button(),
                  Custom_dropDownButton(
                    value: "value",
                    onChanged: (value) {},
                    hint: 'اختر المدينة',
                    items: [],
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),
            CustomerNameList(),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            Custom_listviewBuilder(),
          ],
        ),
      ),
    );
  }
}
