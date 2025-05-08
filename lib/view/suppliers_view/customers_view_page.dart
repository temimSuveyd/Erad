import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom__dropDownButton.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_appBar.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_search_text_field.dart';
import 'package:suveyd_ticaret/view/customers_view/widgets/custom_brands_heder.dart';
import 'package:suveyd_ticaret/view/customers_view/widgets/custom_brands_listView.dart';
import 'package:suveyd_ticaret/view/suppliers_view/widgets/custom_brands_heder.dart';
import 'package:suveyd_ticaret/view/suppliers_view/widgets/custom_brands_listView.dart';

class SuppliersViewPage extends StatelessWidget {
  const SuppliersViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "زبائني"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 10,
                children: [Custom_textfield(hintText: 'اسم الفئة', suffixIcon: Icons.add, validator: (String?validator ) {  }, controller: null, onChanged: (String ) {  },), Custom_dropDownButton(onChanged: (String value) {  }, hint: '', items: [], value: '',)],
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),

            SliverToBoxAdapter(
              child: Row(children: [Custom_suppliers_heder()]),
            ),

            Custom_suppliers_listView(),
          ],
        ),
      ),
    );
  }
}
