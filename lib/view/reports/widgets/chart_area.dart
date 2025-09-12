import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChartArea extends StatelessWidget {
  const ChartArea({
    super.key,
    required this.totalList,
    required this.title,
    required this.primaryColor,
  });
  final List totalList;
  final String title;
  final Color primaryColor;

  static const List<String> arabicMonths = [
    '', // 0. index boş, çünkü aylar 1'den başlıyor
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  @override
  Widget build(BuildContext context) {
    final maxAmount =
        totalList.isNotEmpty
            ? totalList
                .map((e) => (e['amount'] ?? 0) as num)
                .reduce((a, b) => a > b ? a : b)
            : 1;
    final safeMax = maxAmount == 0 ? 1 : maxAmount;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.09),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(13, (i) {
                final item = totalList.firstWhere(
                  (e) => e["index"] == i,
                  orElse: () => null,
                );
                final amount = item != null ? (item["amount"] ?? 0) as num : 0;
                // Bar yüksekliği, min 8, max 100 olacak şekilde orantılı
                final double minBarHeight = 1;
                final double maxBarHeight = 135;
                final double barHeight =
                    amount > 0
                        ? ((amount / safeMax) * (maxBarHeight - minBarHeight)) +
                            minBarHeight
                        : minBarHeight;
                if (i != 0) {
                  // Ay adını al, eğer i 1-12 arasıysa, yoksa boş string
                  final String monthName =
                      (i >= 1 && i <= 12) ? arabicMonths[i] : '';
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Tooltip(
                          message:
                              "${item != null ? item["index"] : i} : $amount",
                          child: Container(
                            height: barHeight,
                            width: 14,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          monthName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            NumberFormat.compact(locale: "ar").format(amount),
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
