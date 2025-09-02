import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';

class SetExpensesDateRangeButton extends StatelessWidget {
  const SetExpensesDateRangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          backgroundColor: AppColors.wihet.withOpacity(0.13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_month, color: AppColors.wihet, size: 22),
            const SizedBox(width: 10),
            Text(
              "01.06.2024",
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
              "30.06.2024",
              style: TextStyle(
                color: AppColors.wihet,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
