import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/view/Customer_bills_view/widgets/custom_bill_header_row.dart';

class Custom_listviewBuilder extends StatelessWidget {
  const Custom_listviewBuilder({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 6,
      itemBuilder:
          (context, index) =>
              Custom_bill_view_card(),
    );
  }
}
