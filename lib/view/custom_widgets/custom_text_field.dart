import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:get/get.dart';

class Custom_textfield extends StatelessWidget {
  const Custom_textfield({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.validator,
    this.controller,
    required this.onChanged,
    this.maxLines = 1,
    this.height,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.readOnly = false,
  });
  
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final int maxLines;
  final double? height;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool readOnly;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.3,
      height: height ?? (maxLines > 1 ? null : 56),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        enabled: enabled,
        readOnly: readOnly,
        style: TextStyle(
          color: enabled ? AppColors.textPrimary : AppColors.textTertiary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: prefixIcon != null 
            ? Icon(prefixIcon, color: AppColors.textSecondary)
            : null,
          suffixIcon: suffixIcon != null 
            ? Icon(suffixIcon, color: AppColors.textSecondary)
            : null,
          filled: true,
          fillColor: enabled 
            ? AppColors.surface 
            : AppColors.surfaceVariant.withOpacity(0.5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.textTertiary.withOpacity(0.3),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.error,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.textTertiary.withOpacity(0.2),
              width: 1,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: maxLines > 1 ? 16 : 18,
          ),
        ),
      ),
    );
  }
}
