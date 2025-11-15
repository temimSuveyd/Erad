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
  final bool showDebtCheck; // yeni eklenen: porçalrı hesapla checkbox'ı gösterilsin mi
  final bool includeDebts; // yeni eklenen: seçili mi
  final void Function(bool?)? onDebtCheckChanged; // yeni eklenen: değişim işlemi

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
    // Renk uyumu için daha soft arka plan, outline border ve tutarlı metin/ikon renkleri
    final Color cardBgColor = Colors.white; // daha nötr bir arkaplan
    final Color iconBgColor = iconColor.withOpacity(0.13);
    final Color labelTextColor = AppColors.primary.withOpacity(0.95); // bir tık daha koyu
    final Color valueTextColor = iconColor;
    final Color dropDownIconColor = iconColor; // tema ana rengiyle daha uyumlu
    final Color dropDownTextColor = AppColors.primary; // dropdown value text
    final Color dropDownBgColor = AppColors.primary.withOpacity(0.97);
    final Color outlineColor = iconColor.withOpacity(0.23);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: outlineColor, width: 1.2),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      color: cardBgColor,
      child: Container(
        height: showDebtCheck ? 120 : 100,
        constraints: BoxConstraints(
          maxWidth: showDropDownMenu != true && !showDebtCheck
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
                color: iconBgColor,
                borderRadius: BorderRadius.circular(11),
              ),
              width: 46,
              height: 46,
              child: Center(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 26,
                ),
              ),
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
                            color: labelTextColor,
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
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: dropDownIconColor,
                            ),
                            iconSize: 28,
                            dropdownColor: dropDownBgColor,
                            elevation: 6,
                            style: TextStyle(
                              color: dropDownTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                            underline: const SizedBox(),
                            items: List.generate(dropdownItems.length, (index) {
                              return DropdownMenuItem<String>(
                                value: dropdownIds[index],
                                child: Text(
                                  dropdownItems[index],
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    color: iconColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
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
                          Transform.scale(
                            scale: 0.95,
                            child: Checkbox(
                              value: includeDebts,
                              onChanged: onDebtCheckChanged,
                              activeColor: iconColor,
                              side: BorderSide(
                                color: iconColor.withOpacity(0.3),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "صافي الارباح",
                              style: TextStyle(
                                color: iconColor.withOpacity(0.83),
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
                      color: valueTextColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          blurRadius: 6,
                          color: valueTextColor.withOpacity(0.10),
                          offset: const Offset(0, 2),
                        )
                      ],
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
