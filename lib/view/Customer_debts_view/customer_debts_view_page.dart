import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/view/Customer_bills_view/widgets/custom_list_view_builder.dart';
import 'package:suveyd_ticaret/view/Customer_bills_view/widgets/custom_name_list.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_appBar.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_search_text_field.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom__dropDownButton.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_set_date_button.dart';

class CustomerDebtsViewPage extends StatelessWidget {
  CustomerDebtsViewPage({super.key});
  final List<String> titleList = [
    "محمود ديبا",
    "مدينة",
    " 150",
    "300",
    "290",
  ];
  final List<double> width = [300, 200, 200, 200, 200];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appBar(title: "ديون العملاء"),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 30,
                children: [
                  Custom_textfield(hintText: 'اسم الفئة', suffixIcon: Icons.add, validator: (String?validator ) {  }, controller: null, onChanged: (String ) {  },),
                  Custom_set_date_button(),
                     Custom_dropDownButton(
              value: "value" ,
              onChanged:(value) {
                
              },
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
