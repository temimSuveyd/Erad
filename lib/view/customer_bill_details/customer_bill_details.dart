import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_appBar.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_total_price_container.dart';
import 'package:suveyd_ticaret/view/customer_bill_details/widgets/csutom_lable_details.dart';
import 'package:suveyd_ticaret/view/customer_bill_details/widgets/custom_bill_details_heder.dart';
import 'package:suveyd_ticaret/view/customer_bill_details/widgets/custom_bill_options_button.dart';
import 'package:suveyd_ticaret/view/customer_bill_details/widgets/custom_prodects_details_sliverListBuilder.dart';
import 'package:suveyd_ticaret/view/customer_bill_details/widgets/custom_text_body.dart';

class CustomerBillDetailsPage extends StatelessWidget {
  const CustomerBillDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appBar(title: "تفاصيل الفاتورة"),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            Custom_text_body(title: "معلومات الفواتير"),
            Custom_bill_details_heder(),
            Custom_text_body(title: "البضائع"),
            Csutom_lable_details(),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            Custom_products_details_sliverListBuilder(),
            SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(
              child: Row(
                spacing: 20,
                children: [
                   Custom_total_price_container(title: '',),
                  Custom_bill_options_button(
                    icon: Icons.discount,
                    title: 'İndirim yap',
                  ),
                  Custom_bill_options_button(
                    icon: Icons.print,
                    title: 'Yazdır(PDF)',
                  ),
                  Custom_bill_options_button(icon: Icons.delete, title: 'Sil'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
