import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    required this.validator,
    required this.controller,
    required this.onChanged,
    this.maxLines,
    this.height,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;

    return Container(
      height: height ?? 48,
      width: isDesktop ? Get.width * 0.15 : double.infinity,
      constraints: BoxConstraints(
        minWidth: isDesktop ? 150 : 0,
        maxWidth: isDesktop ? Get.width * 0.25 : double.infinity,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        onChanged: onChanged,
        maxLines: maxLines ?? 1,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
        controller: controller,
        validator: validator,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          prefixIcon: Icon(
            suffixIcon,
            color: AppColors.textSecondary,
            size: 20,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16, color: AppColors.textLight),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.textLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.textLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
