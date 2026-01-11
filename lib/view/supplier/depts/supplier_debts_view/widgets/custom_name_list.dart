import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';

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
               CustomButton( color: AppColors.primary,
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

