import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/view/Customer_bills_view/widgets/custom_bill_header_row.dart';

class Custom_listviewBuilder extends StatelessWidget {
  const Custom_listviewBuilder({
    super.key,
    required this.titleList,
    required this.width,
  });

  final List<String> titleList;
  final List<double> width;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 6,
      itemBuilder:
          (context, index) =>
              Row(
                children: [
                  Custom_bill_view_card(),
                ],
              ),
    );
  }
}
