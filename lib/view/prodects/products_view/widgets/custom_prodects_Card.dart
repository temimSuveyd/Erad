
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_title_text_container.dart';
import 'package:erad/view/custom_widgets/custom_date_text_container.dart';

import '../../../supplier/bills/suppliers_bills_add/widgets/custom_price_container.dart';

class Custom_products_Card extends StatelessWidget {
  const Custom_products_Card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(5),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        
          child: Row(
            spacing: 20,
        
            children: [
              Custom_title_text_container(title: "title"),
         Custom_date_text_container(title: '',width: 100,),
              Custom_price_container(title: "123", width: 120),
      SizedBox(width: 100,)
            ],
          ),
        ),
      ],
    );
  }
}

