

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:Erad/core/constans/colors.dart';

class Custom_set_payment_type_dropDownButton extends StatelessWidget {
  const Custom_set_payment_type_dropDownButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      height: 40,
      child: DropdownButton2<String>(
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.wihet,
              ),
            ),
            hint: Text(
              "نوع الدفع",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            items: [
              DropdownMenuItem(value: "Option 1", child: Text("Option 1")),
              DropdownMenuItem(value: "Option 2", child: Text("Option 2")),
              DropdownMenuItem(value: "Option 3", child: Text("Option 3")),
            ],
            onChanged: (value) {},
          ),
    );
  }
}
