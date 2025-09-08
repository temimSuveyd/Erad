
import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_add_produc_Textfield extends StatelessWidget {
  const Custom_add_produc_Textfield({
    super.key,
    required this.width,
    required this.hintText,
    required this.onChanged,
    required this.controller,
    required this.onSubmitted,
    this.focusNode,
  });

  final double width;
  final String hintText;
  final void Function(String) onChanged;
  final TextEditingController? controller;
  final Function(String) onSubmitted;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: width,
      child: TextField(
        focusNode: focusNode,
        onSubmitted: (value) => onSubmitted(value),
        controller: controller,
        onChanged: (value) => onChanged(value),

        decoration: InputDecoration(
          hintText: hintText,
          fillColor: AppColors.wihet,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
