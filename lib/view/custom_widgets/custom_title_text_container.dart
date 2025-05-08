


import 'package:flutter/widgets.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Custom_title_text_container extends StatelessWidget {
  const Custom_title_text_container({super.key, required this.title});
final String title ;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5),
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.wihet,
      ),
      child: Text(
      title,
      overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
        ),
      ),
    );
  }
}
