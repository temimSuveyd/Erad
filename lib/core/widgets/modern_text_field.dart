import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

/// Modern text field with filled style and proper validation
class ModernTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;

  const ModernTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<ModernTextField> createState() => _ModernTextFieldState();
}

class _ModernTextFieldState extends State<ModernTextField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: DesignTokens.getFontSize(context, DesignTokens.fontScaleSmall),
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing8),
        ],
        AnimatedContainer(
          duration: DesignTokens.durationFast,
          decoration: BoxDecoration(
            borderRadius: DesignTokens.borderRadiusMedium,
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppColors.withOpacity(AppColors.primary, 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            style: TextStyle(
              fontSize: DesignTokens.getFontSize(context, DesignTokens.fontScaleBase),
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: DesignTokens.getFontSize(context, DesignTokens.fontScaleBase),
                color: AppColors.textLight,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _isFocused ? AppColors.primary : AppColors.textSecondary,
                      size: 20,
                    )
                  : null,
              suffixIcon: widget.suffixIcon,
              filled: true,
              fillColor: widget.enabled ? AppColors.white : AppColors.surfaceVariant,
              border: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusMedium,
                borderSide: BorderSide(
                  color: AppColors.border,
                  width: DesignTokens.borderWidthThin,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusMedium,
                borderSide: BorderSide(
                  color: AppColors.border,
                  width: DesignTokens.borderWidthThin,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusMedium,
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: DesignTokens.borderWidthMedium,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusMedium,
                borderSide: BorderSide(
                  color: AppColors.error,
                  width: DesignTokens.borderWidthThin,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: DesignTokens.borderRadiusMedium,
                borderSide: BorderSide(
                  color: AppColors.error,
                  width: DesignTokens.borderWidthMedium,
                ),
              ),
              errorText: widget.errorText,
              errorStyle: TextStyle(
                fontSize: DesignTokens.getFontSize(context, DesignTokens.fontScaleXSmall),
                color: AppColors.error,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
                vertical: DesignTokens.spacing12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
