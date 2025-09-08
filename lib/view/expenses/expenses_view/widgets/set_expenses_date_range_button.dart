import 'package:erad/controller/expenses/expenses_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SetExpensesDateRangeButton extends StatelessWidget {
  const SetExpensesDateRangeButton({super.key, required this.onPressed});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpensesControllerImp>(
      builder:
          (controller) => Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                backgroundColor: AppColors.wihet.withOpacity(0.13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              onPressed: () => onPressed(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_month, color: AppColors.wihet, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    
                    "${controller.pickedDateRange.start.year}/${controller.pickedDateRange.start.month.toString().padLeft(2, '0')}/${controller.pickedDateRange.start.day.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: AppColors.wihet,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.wihet,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${controller.pickedDateRange.end.year}/${controller.pickedDateRange.end.month.toString().padLeft(2, '0')}/${controller.pickedDateRange.end.day.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: AppColors.wihet,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
