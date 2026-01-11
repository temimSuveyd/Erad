import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

/// Modern button with animations and proper touch targets
class ModernButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ModernButtonStyle style;
  final ModernButtonSize size;
  final bool isLoading;
  final double? width;

  const ModernButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.style = ModernButtonStyle.primary,
    this.size = ModernButtonSize.medium,
    this.isLoading = false,
    this.width,
  });

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: DesignTokens.durationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;
    final buttonColors = _getButtonColors();
    final buttonSizes = _getButtonSizes();

    return GestureDetector(
      onTapDown: isEnabled ? _handleTapDown : null,
      onTapUp: isEnabled ? _handleTapUp : null,
      onTapCancel: isEnabled ? _handleTapCancel : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedOpacity(
          duration: DesignTokens.durationFast,
          opacity: isEnabled ? 1.0 : 0.5,
          child: Container(
            width: widget.width,
            height: buttonSizes.height,
            constraints: BoxConstraints(
              minHeight: DesignTokens.minTouchTarget,
            ),
            child: ElevatedButton(
              onPressed: isEnabled ? widget.onPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColors.background,
                foregroundColor: buttonColors.foreground,
                elevation: buttonColors.elevation,
                shadowColor: AppColors.withOpacity(Colors.black, 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: DesignTokens.borderRadiusMedium,
                  side: buttonColors.border,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: buttonSizes.horizontalPadding,
                  vertical: buttonSizes.verticalPadding,
                ),
              ),
              child: widget.isLoading
                  ? SizedBox(
                      width: buttonSizes.iconSize,
                      height: buttonSizes.iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          buttonColors.foreground,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, size: buttonSizes.iconSize),
                          SizedBox(width: buttonSizes.iconSpacing),
                        ],
                        Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: buttonSizes.fontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  _ButtonColors _getButtonColors() {
    switch (widget.style) {
      case ModernButtonStyle.primary:
        return _ButtonColors(
          background: AppColors.primary,
          foreground: AppColors.white,
          border: BorderSide.none,
          elevation: DesignTokens.elevationLow,
        );
      case ModernButtonStyle.secondary:
        return _ButtonColors(
          background: AppColors.white,
          foreground: AppColors.primary,
          border: BorderSide(
            color: AppColors.primary,
            width: DesignTokens.borderWidthMedium,
          ),
          elevation: DesignTokens.elevationNone,
        );
      case ModernButtonStyle.success:
        return _ButtonColors(
          background: AppColors.success,
          foreground: AppColors.white,
          border: BorderSide.none,
          elevation: DesignTokens.elevationLow,
        );
      case ModernButtonStyle.danger:
        return _ButtonColors(
          background: AppColors.error,
          foreground: AppColors.white,
          border: BorderSide.none,
          elevation: DesignTokens.elevationLow,
        );
      case ModernButtonStyle.ghost:
        return _ButtonColors(
          background: Colors.transparent,
          foreground: AppColors.primary,
          border: BorderSide.none,
          elevation: DesignTokens.elevationNone,
        );
    }
  }

  _ButtonSizes _getButtonSizes() {
    switch (widget.size) {
      case ModernButtonSize.small:
        return _ButtonSizes(
          height: 36,
          horizontalPadding: DesignTokens.spacing12,
          verticalPadding: DesignTokens.spacing8,
          fontSize: 14,
          iconSize: 16,
          iconSpacing: DesignTokens.spacing8,
        );
      case ModernButtonSize.medium:
        return _ButtonSizes(
          height: 44,
          horizontalPadding: DesignTokens.spacing16,
          verticalPadding: DesignTokens.spacing12,
          fontSize: 16,
          iconSize: 20,
          iconSpacing: DesignTokens.spacing8,
        );
      case ModernButtonSize.large:
        return _ButtonSizes(
          height: 52,
          horizontalPadding: DesignTokens.spacing24,
          verticalPadding: DesignTokens.spacing16,
          fontSize: 18,
          iconSize: 24,
          iconSpacing: DesignTokens.spacing12,
        );
    }
  }
}

enum ModernButtonStyle {
  primary,
  secondary,
  success,
  danger,
  ghost,
}

enum ModernButtonSize {
  small,
  medium,
  large,
}

class _ButtonColors {
  final Color background;
  final Color foreground;
  final BorderSide border;
  final double elevation;

  _ButtonColors({
    required this.background,
    required this.foreground,
    required this.border,
    required this.elevation,
  });
}

class _ButtonSizes {
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final double iconSize;
  final double iconSpacing;

  _ButtonSizes({
    required this.height,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.fontSize,
    required this.iconSize,
    required this.iconSpacing,
  });
}
