
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Custom_date_picker_button extends StatelessWidget {
  const Custom_date_picker_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 250,
      height: 43,
      color: AppColors.wihet,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
        initialEntryMode: DatePickerEntryMode.input,
        );
        if (pickedDate != null) {

        }
      },
    child: Text("تحديد التاريخ",style: TextStyle(fontSize: 18,color: AppColors.grey,fontWeight: FontWeight.w500),),
    );
  }
}



