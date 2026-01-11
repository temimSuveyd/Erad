import 'package:erad/controller/withdrawn_funds/withdrawn_funds_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/data/model/withdrawn_fund/withdrawn_fund_card_model.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawnFundsCard extends GetView<WithdrawnFundsControllerImp> {
  const WithdrawnFundsCard({super.key, required this.withdrawnFundCardModel});

  final WithdrawnFundCardModel withdrawnFundCardModel;

  String get formattedDate {
    final date = withdrawnFundCardModel.date;
    if (date == null) return '';
    return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
  }

  String get repeatText =>
      withdrawnFundCardModel.isRepeatWithdrawnFund == true
          ? "متكرر"
          : "مرة واحدة";

  String get formattedRepeatDate {
    final repeatDate = withdrawnFundCardModel.repeatDate;
    if (repeatDate == null) return '';
    return "${repeatDate.year}/${repeatDate.month.toString().padLeft(2, '0')}/${repeatDate.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        color: AppColors.background,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary, width: 1.2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Leading icon with shadow
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.grey.withValues(alpha: 0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.18),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.attach_money_rounded,
                      color: AppColors.wihet,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                // Main info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Amount
                      Text(
                        withdrawnFundCardModel.amount?.toStringAsFixed(2) ?? "0.00",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: AppColors.red,
                          letterSpacing: 0.7,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Date, repeat info, and repeat date
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: AppColors.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Icon(
                            withdrawnFundCardModel.isRepeatWithdrawnFund == true
                                ? Icons.repeat
                                : Icons.repeat_one,
                            color:
                                withdrawnFundCardModel.isRepeatWithdrawnFund ==
                                        true
                                    ? AppColors.green
                                    : AppColors.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            repeatText,
                            style: TextStyle(
                              color:
                                  withdrawnFundCardModel
                                              .isRepeatWithdrawnFund ==
                                          true
                                      ? AppColors.green
                                      : AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (withdrawnFundCardModel.isRepeatWithdrawnFund ==
                              true) ...[
                            const SizedBox(width: 10),
                            Icon(
                              Icons.event_repeat,
                              color: AppColors.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              formattedRepeatDate,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                // Edit & Delete buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      icon: Icons.edit,
                      title: "",
                      onPressed:
                          () => controller.showEditDialog(
                            withdrawnFundCardModel.amount ?? 0.0,
                            withdrawnFundCardModel.date ?? DateTime.now(),
                            withdrawnFundCardModel.isRepeatWithdrawnFund ??
                                false,
                            withdrawnFundCardModel.repeatDate ?? DateTime.now(),
                            withdrawnFundCardModel.id ?? "",
                          ),
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 8),
                    CustomButton(
                      icon: Icons.delete,
                      title: "",
                      onPressed:
                          () => controller.showDeleteDialog(
                            withdrawnFundCardModel.id!,
                          ),
                      color: AppColors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
