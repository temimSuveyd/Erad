import 'package:erad/controller/customers/bills/customer_add_bill_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_date_picker_button extends StatelessWidget {
  const Custom_date_picker_button({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerBiilAddControllerImp>(
      builder:
          (controller) => MaterialButton(
            minWidth: 260,
            height: 60,
            color: AppColors.backgroundColor,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.grey, width: 2),
            ),
            onPressed: () async {
              // Use context from the widget tree, not Get.context!, to ensure MaterialLocalizations are available
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialEntryMode: DatePickerEntryMode.calendar,

                builder: (context, child) {
                  return Directionality(
                    textDirection: TextDirection.rtl, // Sağdan sola yönlendirme
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary:
                              AppColors.primary, // header, selected date, etc.
                          onPrimary:
                              AppColors.backgroundColor, // text on primary
                          surface:
                              AppColors.backgroundColor, // dialog background
                          onSurface: AppColors.grey, // text color
                          background: AppColors.backgroundColor,
                          onBackground: AppColors.grey,
                          secondary: AppColors.primary,
                          onSecondary: AppColors.backgroundColor,
                        ),
                        dialogBackgroundColor: AppColors.backgroundColor,
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                AppColors.primary, // button text color
                          ),
                        ),
                      ),
                      child: child!,
                    ),
                  );
                },
              );
              if (pickedDate != null) {
                controller.setDate(pickedDate);
              }
            },
            child: Text(
              "${controller.bill_add_date.day}/${controller.bill_add_date.month}/${controller.bill_add_date.year}",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
    );
  }
}
