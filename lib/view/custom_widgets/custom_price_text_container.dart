import 'package:flutter/cupertino.dart';
import 'package:Erad/core/constans/colors.dart';

class Custom_price_text_container extends StatelessWidget {
  const Custom_price_text_container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.wihet,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "13000000000",
        style: TextStyle(
          color: AppColors.green,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
