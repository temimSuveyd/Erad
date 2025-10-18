import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final double value;
  final bool showDropDownMenu;
  final String dropdownValue;
  final List<String> dropdownItems;
  final List<String> dropdownIds;

  final void Function(String) onChanged;
  final bool
  showDebtCheck; // yeni eklenen: porçalrı hesapla checkbox'ı gösterilsin mi
  final bool includeDebts; // yeni eklenen: seçili mi
  final void Function(bool?)?
  onDebtCheckChanged; // yeni eklenen: değişim işlemi

  const ReportCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.showDropDownMenu,
    required this.dropdownValue,
    required this.dropdownItems,
    required this.onChanged,
    required this.dropdownIds,
    required this.showDebtCheck,
    required this.includeDebts,
    required this.onDebtCheckChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      color: const Color.fromARGB(255, 0, 22, 93),
      child: Container(
        height: showDebtCheck ? 120 : 100, // checkbox varsa hafif genişlet
        constraints: BoxConstraints(
          maxWidth:
              showDropDownMenu != true && !showDebtCheck
                  ? Get.width * 0.14
                  : Get.width * 0.18,
        ),
        padding: EdgeInsets.symmetric(
          vertical: showDropDownMenu != true && !showDebtCheck ? 16 : 0,
          horizontal: 10,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.14),
                borderRadius: BorderRadius.circular(11),
              ),
              width: 46,
              height: 46,
              child: Center(child: Icon(icon, color: iconColor, size: 26)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      if (showDropDownMenu)
                        IgnorePointer(
                          ignoring: false,
                          child: DropdownButton<String>(
                            value:
                                dropdownIds.isNotEmpty &&
                                        dropdownIds.contains(dropdownValue)
                                    ? dropdownValue
                                    : dropdownIds.isNotEmpty
                                    ? dropdownIds.first
                                    : null,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.wihet,
                            ),
                            iconSize: 30,
                            dropdownColor: AppColors.primary,
                            elevation: 6,
                            style: const TextStyle(color: AppColors.primary),
                            underline: const SizedBox(),
                            items: List.generate(dropdownItems.length, (index) {
                              return DropdownMenuItem<String>(
                                value: dropdownIds[index],
                                child: Text(
                                  dropdownItems[index],
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    color: AppColors.wihet,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }),
                            onChanged: (value) {
                              onChanged(value!);
                            },
                          ),
                        ),
                    ],
                  ),
                  if (showDebtCheck)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Checkbox(
                            value: includeDebts,
                            onChanged: onDebtCheckChanged,
                            activeColor: iconColor,
                          ),
                          Flexible(
                            child: Text(
                              "صافي الارباح",
                              style: TextStyle(
                                color: AppColors.wihet,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    NumberFormat("#,##0", "ar").format(value),
                    style: TextStyle(
                      color: iconColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
