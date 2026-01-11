import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:get/get.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hint,
    required this.value,
  });

  final List<DropdownMenuItem<String>>? items;
  final Function(String value) onChanged;
  final String hint;
  final String value;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> safeItems = items ?? [];
    final matches = safeItems.where((item) => item.value == value).toList();

    String? dropdownValue;
    if (matches.length == 1) {
      dropdownValue = value;
    } else {
      dropdownValue = null;
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;

    return Container(
      height: 48,
      width: isDesktop ? Get.width * 0.15 : double.infinity,
      constraints: BoxConstraints(
        minWidth: isDesktop ? 150 : 0,
        maxWidth: isDesktop ? Get.width * 0.25 : double.infinity,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.textLight),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          items: safeItems,
          hint: Text(
            hint,
            style: const TextStyle(color: AppColors.textLight, fontSize: 16),
          ),
          onChanged: (selectedValue) {
            if (selectedValue != null) {
              onChanged(selectedValue);
            }
          },
          isExpanded: true,
          dropdownColor: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
