
import 'package:flutter/cupertino.dart';
import 'package:Erad/core/constans/colors.dart';

class Custom_debt_payment_type_heder extends StatelessWidget {
  const Custom_debt_payment_type_heder({
    super.key, required this.titles_list, required this.width,

  });

final List<Widget> titles_list ;
final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          width: width,
          height: 40,
          color: AppColors.primary,

          child: Row(
            spacing: 10,

            children: titles_list,
          ),
        ),
      ],
    );
  }
}
