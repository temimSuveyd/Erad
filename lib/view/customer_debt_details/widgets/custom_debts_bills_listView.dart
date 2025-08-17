import 'package:flutter/cupertino.dart';
import 'package:Erad/view/customer_debt_details/widgets/custom_debts_bills_card.dart';

class Custom_debts_bills_listView extends StatelessWidget {
  const Custom_debts_bills_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [...List.generate(3, (index) => Custom_debts_bills_card())],
    );
  }
}

