import 'package:Erad/core/constans/bill_status.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:flutter/material.dart';

class Bill_status_button extends StatelessWidget {
  const Bill_status_button({
    super.key,
    required this.billStatus,
    required this.onPressed,
  });

  final String billStatus;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (billStatus == BillStatus.deliveryd) {
      return Custom_button(
        icon: Icons.verified_outlined,
        title: "تم التسليم",
        onPressed: () => onPressed(),
        color: AppColors.green,
      );
    } else if (billStatus == BillStatus.eliminate) {
      return Custom_button(
        icon: Icons.cancel_outlined,
        title: "تم الإلغاء",
        onPressed: () => onPressed(),
        color: AppColors.red,
      );
    } else if (billStatus == BillStatus.itwasFormed) {
      return Custom_button(
        icon: Icons.assignment_turned_in_outlined,
        title: "تم التشكيل",
        onPressed: () => onPressed(),
        color: AppColors.primary,
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
