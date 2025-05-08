import 'package:flutter/widgets.dart';
import 'package:suveyd_ticaret/view/suppliers_view/widgets/custom_brands_Card.dart';

class Custom_suppliers_listView extends StatelessWidget {
  const Custom_suppliers_listView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder:
          (context, index) => Custom_suppliers_Card(),
    );
  }
}
