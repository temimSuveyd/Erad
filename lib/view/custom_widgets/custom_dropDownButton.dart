import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_dropDownButton extends StatelessWidget {
  const Custom_dropDownButton({
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
    // Ensure items is not null
    final List<DropdownMenuItem<String>> safeItems = items ?? [];

    // There should be exactly one item with value==this.value
    final matches = safeItems.where((item) => item.value == value).toList();

    String? dropdownValue;
    if (matches.length == 1) {
      dropdownValue = value;
    } else {
      dropdownValue = null;
    }

    return Container(
      width: 250,
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border.all(color: AppColors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          items: safeItems,
          hint: Text(
            hint,
            style: const TextStyle(color: AppColors.grey, fontSize: 20),
          ),
          onChanged: (selectedValue) {
            if (selectedValue != null) {
              onChanged(selectedValue);
            }
          },
          isExpanded: true,
          dropdownColor: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
          // Set style for the selected value
          style: const TextStyle(color: AppColors.grey, fontSize: 18),
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.grey),
        ),
      ),
    );
  }
}
