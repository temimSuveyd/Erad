import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:Erad/view/custom_widgets/custom_appBar.dart';
import 'package:Erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:Erad/view/custom_widgets/custom_total_price_container.dart';
import 'package:Erad/view/customer_debt_details/widgets/custom_debt_payment_type_heder.dart';
import 'package:Erad/view/customer_debt_details/widgets/custom_debt_payments_listView.dart';
import 'package:Erad/view/customer_debt_details/widgets/custom_debts_bills_listView.dart';

class CustomerDebtsDetailsPage extends StatelessWidget {
  const CustomerDebtsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appBar(title: "تفاصيل الديون"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        children: [
          Row(children: [Custom_set_date_button(hintText: '', onPressed: () {  },)]),

          SizedBox(height: 40),

          Row(
            spacing: 20,
            children: [
              Custom_debt_payment_type_heder(title: "دَين"),
              Custom_debt_payment_type_heder(title: "المدفوعات"),
                   Custom_button( color: AppColors.primary,
                icon: Icons.add,
                onPressed: () {
                  
                },
                title: "إضافة",
              )
            ],
          ),

          SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Custom_debts_bills_listView(),
              Custom_debt_payments_listView(),
            ],
          ),

          Row(children: [Custom_total_price_container(title: '',)]),
        ],
      ),
    );
  }
}
