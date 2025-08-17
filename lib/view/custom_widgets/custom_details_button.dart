import 'package:flutter/material.dart';
import 'package:Erad/core/constans/colors.dart';

class Custom_details_button extends StatelessWidget {
  const Custom_details_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: () {
      
    },
    minWidth:110,
    height: 50,
    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
    color: AppColors.primary,
    child: Text("تفاصيل",style: TextStyle(color: AppColors.wihet,fontSize: 20,fontWeight: FontWeight.w500),),
    );
  }
}
