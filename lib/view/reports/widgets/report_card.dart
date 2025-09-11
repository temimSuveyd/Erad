import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:intl/intl.dart';

class ReportCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final double value;
  final double monthlyValue;
  final double cardWidth;
  final bool highlight;
  final bool isSelected;

  const ReportCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.monthlyValue,
    required this.cardWidth,
    this.highlight = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      width: cardWidth,
      constraints: const BoxConstraints(minHeight: 110),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      decoration: BoxDecoration(
        color:
            highlight
                ? AppColors.primary.withOpacity(0.13)
                : AppColors.grey.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              isSelected
                  ? iconColor.withOpacity(0.7)
                  : (highlight
                      ? AppColors.primary.withOpacity(0.35)
                      : AppColors.grey.withOpacity(0.18)),
          width: isSelected ? 2.2 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color:
                highlight
                    ? AppColors.primary.withOpacity(0.08)
                    : Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.13),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  NumberFormat("#,##0", "tr").format(value),
                  style: TextStyle(
                    color: highlight ? AppColors.primary : iconColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 16,
                      color: iconColor.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Aylık: ${NumberFormat("#,##0", "tr").format(monthlyValue)}",
                      style: TextStyle(
                        color: iconColor.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
