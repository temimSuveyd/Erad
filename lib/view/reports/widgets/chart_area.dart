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
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.25),
          width: 1.2,
        ),
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
              color: AppColors.primary.withOpacity(0.13),
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
                final double minBarHeight = 8;
                final double maxBarHeight = 100;
                final double barHeight =
                    amount > 0
                        ? ((amount / safeMax) * (maxBarHeight - minBarHeight)) +
                            minBarHeight
                        : minBarHeight;

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
                        "$i",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          NumberFormat.compact(locale: "ar").format(amount),
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
