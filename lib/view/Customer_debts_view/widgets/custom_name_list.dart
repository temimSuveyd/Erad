import 'package:flutter/material.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:Erad/view/Customer_bills_view/widgets/custom_name_label.dart';

class CustomerNameList extends StatelessWidget {
  const CustomerNameList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          // ...List.generate(
          //   nameLableData.length,
          //   (index) => CustomerNameLabel(title: nameLableData[index].title, widgets: index==0?300:220,),
          // ),
          SizedBox(width: 10),
               Custom_button( color: AppColors.primary,
                icon: Icons.add,
                onPressed: () {
                  
                },
                title: "إضافة",
              )
        ],
      ),
    );
  }
}

