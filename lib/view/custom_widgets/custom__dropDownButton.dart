import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Erad/core/constans/colors.dart';

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
    return DropdownButton2<String>(
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: AppColors.wihet,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      hint: Text(
        hint,
        style: const TextStyle(color: AppColors.grey, fontSize: 20),
      ),

      isExpanded: false,
      items: items,
      onChanged: (value) => onChanged(value!),

      buttonStyleData: ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: 250,
        height: 41,
        decoration: BoxDecoration(
          color: AppColors.wihet,
          border: Border.all(color: AppColors.grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
