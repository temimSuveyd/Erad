import 'package:erad/core/constans/colors.dart';
import 'package:erad/data/model/expenses/expenses_card_model.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:flutter/material.dart';

class ExpensesCard extends StatelessWidget {
  const ExpensesCard({
    super.key,
    required this.expensesModel,
    this.onDelete,
    this.onEdit,
  });

  final ExpensesCardModel expensesModel;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    // Format date
    String formattedDate =
        "${expensesModel.date!.year}/${expensesModel.date!.month.toString().padLeft(2, '0')}/${expensesModel.date!.day.toString().padLeft(2, '0')}";
    // Tekrar durumu
    String repeatText = expensesModel.isRepeatExpense! ? "متكرر" : "مرة واحدة";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.primary, width: 1.2),
          // Remove shadow for a cleaner look
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Leading icon
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.grey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  // Remove shadow for a cleaner look
                ),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.attach_money_rounded,
                    color: AppColors.wihet,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Main info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      expensesModel.title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Amount
                    Text(
                      "${expensesModel.amount!.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.red,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Date and repeat info - make it much more visible
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: AppColors.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Icon(
                            expensesModel.isRepeatExpense!
                                ? Icons.repeat
                                : Icons.repeat_one,
                            color: expensesModel.isRepeatExpense!
                                ? AppColors.green
                                : AppColors.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            repeatText,
                            style: TextStyle(
                              color: expensesModel.isRepeatExpense!
                                  ? AppColors.green
                                  : AppColors.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Edit & Delete buttons
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(226, 11, 27, 82),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Custom_button(
                      icon: Icons.delete,
                      title: "حذف",
                      onPressed: () {},
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Custom_button(
                      icon: Icons.edit,
                      title: "تعديل",
                      onPressed: () {},
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
