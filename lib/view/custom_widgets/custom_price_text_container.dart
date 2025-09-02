import 'package:flutter/cupertino.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_price_text_container extends StatelessWidget {
  const Custom_price_text_container({super.key, required this.price});
final String price;
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
       price,
        style: TextStyle(
          color: AppColors.green,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
