import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/categorey_type_view/widgets/custom_categoreyType_heder.dart';
import 'package:suveyd_ticaret/view/categorey_type_view/widgets/custom_categoreyType_listView.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_appBar.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_search_text_field.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom__dropDownButton.dart';
import 'package:suveyd_ticaret/view/customer_bills_add/widgets/custom_amout_dropDown_button.dart';
import 'package:suveyd_ticaret/view/products_view/widgets/custom_categoreyType_listView.dart';
import 'package:suveyd_ticaret/view/products_view/widgets/custom_podects_heder.dart';

class productsViewPage extends StatelessWidget {
  const productsViewPage({super.key});

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "بضائع"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 20,
                children: [Custom_textfield(hintText: 'اسم الفئة', suffixIcon: Icons.add, validator: (String?validator ) {  }, controller: null, onChanged: (String ) {  },),   Custom_dropDownButton(
              value: "value" ,
              onChanged:(value) {
                
              },
              hint: 'اختر المدينة',
              items: [],
            ),   Custom_dropDownButton(
              value: "value" ,
              onChanged:(value) {
                
              },
              hint: 'اختر المدينة',
              items: [],
            ),]),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),

            SliverToBoxAdapter(
              child: Row(children: [Custom_products_heder()]),
            ),

            Custom_products_listView(),
          ],
        ),
      ),
    );
  }
}
