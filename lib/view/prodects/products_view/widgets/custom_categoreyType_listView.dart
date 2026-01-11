import 'package:flutter/material.dart';
import 'package:erad/view/prodects/products_view/widgets/custom_prodects_Card.dart';

class Custom_products_listView extends StatelessWidget {
  const Custom_products_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Replace with actual data count
      itemBuilder: (context, index) => Custom_products_Card(),
    );
  }
}
