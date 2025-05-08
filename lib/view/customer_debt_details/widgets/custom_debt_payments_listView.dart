import 'package:flutter/cupertino.dart';
import 'package:suveyd_ticaret/view/customer_debt_details/widgets/custom_debt_payments_card.dart';

class Custom_debt_payments_listView extends StatelessWidget {
  const Custom_debt_payments_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [...List.generate(10, (index) => Custom_debt_payments_card())],
    );
  }
}

