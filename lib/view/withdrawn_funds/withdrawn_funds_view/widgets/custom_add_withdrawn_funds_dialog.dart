import 'package:erad/controller/withdrawn_funds/withdrawn_funds_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAddExpensesDialog extends StatelessWidget {
  final TextEditingController countController;

  const CustomAddExpensesDialog({
    super.key,
    required this.countController,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.18),
                width: 1.2,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Custom_textfield(
              hintText: "مبلغ",
              suffixIcon: Icons.attach_money_rounded,
              validator: (q) {
                return null;
              },
              controller: countController,
              onChanged: (value) {},
            ),
          ),

          const SizedBox(height: 10),
          // Tarih seçici
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.18),
                width: 1.2,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: GetBuilder<WithdrawnFundsControllerImp>(
              builder:
                  (controller) => Custom_set_date_button(
                    hintText:
                        "${controller.addedDate.year}/${controller.addedDate.month.toString().padLeft(2, '0')}/${controller.addedDate.day.toString().padLeft(2, '0')}",
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary:
                                    AppColors
                                        .primary, // header background color
                                onPrimary: Colors.white, // header text color
                                onSurface: AppColors.primary, // body text color
                                surface:
                                    AppColors
                                        .backgroundColor, // background color of the date picker itself
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      AppColors.primary, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          controller.setDate(selectedDate);
                        }
                      });
                    },
                  ),
            ),
          ),
          const SizedBox(height: 18),
          // Tekrarlama checkbox ve dropdown
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.12),
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    GetBuilder<WithdrawnFundsControllerImp>(
                      builder:
                          (controller) => Checkbox(
                            value: controller.isRepeatWithdrawnFunds.value,
                            onChanged:
                                (value) => controller.toggleRepeatWithdrawnFunds(),
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "كرر هذه النفقة كل ",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.18),
                      width: 1.2,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  child: GetBuilder<WithdrawnFundsControllerImp>(
                    builder:
                        (controller) => Custom_set_date_button(
                          hintText:
                              "${controller.addedDate.year}/${controller.addedDate.month.toString().padLeft(2, '0')}/${controller.addedDate.day.toString().padLeft(2, '0')}",
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary:
                                          AppColors
                                              .primary, // header background color
                                      onPrimary:
                                          Colors.white, // header text color
                                      onSurface:
                                          AppColors.primary, // body text color
                                      surface:
                                          AppColors
                                              .backgroundColor, // background color of the date picker itself
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor:
                                            AppColors
                                                .primary, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                controller.setRepeatDate(selectedDate);
                              }
                            });
                          },
                        ),
                  ),
                ),
                //
              ],
            ),
          ),
        ],
      ),
    );
  }
}
