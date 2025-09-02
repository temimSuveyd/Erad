import 'package:flutter/widgets.dart';
import 'package:erad/view/prodects/categorey_type_view/widgets/custom_categoreyType_Card.dart';
import 'package:erad/view/prodects/products_view/widgets/custom_prodects_Card.dart';

class Custom_products_listView extends StatelessWidget {
  const Custom_products_listView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder:
          (context, index) => Custom_products_Card(),
    );
  }
}
