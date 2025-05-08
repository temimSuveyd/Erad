import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/view/customer_bill_details/widgets/custom_prodect_details_card.dart';

class Custom_products_details_sliverListBuilder extends StatelessWidget {
  const Custom_products_details_sliverListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Custom_product_details_card(),
    );
  }
}
