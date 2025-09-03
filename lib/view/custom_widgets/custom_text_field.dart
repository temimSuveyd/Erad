import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_textfield extends StatelessWidget {
  const Custom_textfield({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    required this.validator,
    required this.controller,
    required this.onChanged,
    this.maxLines, this.height,
  });
  final String hintText;
  final IconData suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String) onChanged;
  final int? maxLines;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: height??42,
      child: TextFormField(
        onChanged: (value) {
          onChanged(value);
        },
        maxLines: maxLines??1,
        style: TextStyle(color: AppColors.wihet, fontSize: 21),
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(suffixIcon, color: AppColors.grey),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 18, color: AppColors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grey, width: 2),
          ),
        ),
      ),
    );
  }
}
