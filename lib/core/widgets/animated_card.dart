import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

/// Modern animated card with hover effects and minimal shadow
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double? elevation;
  final Border? border;

  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.border,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: DesignTokens.durationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
    return GestureDetector(
      onTapDown:
          widget.onTap != null
              ? (details) {
                setState(() => _isHovered = true);
                _handleTapDown(details);
              }
              : null,
      onTapUp:
          widget.onTap != null
              ? (details) {
                setState(() => _isHovered = false);
                _handleTapUp(details);
              }
              : null,
      onTapCancel:
          widget.onTap != null
              ? () {
                setState(() => _isHovered = false);
                _handleTapCancel();
              }
              : null,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: DesignTokens.durationFast,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppColors.white,
            borderRadius:
                widget.borderRadius ?? DesignTokens.borderRadiusMedium,
            border:
                widget.border ??
                Border.all(
                  color: _isHovered ? AppColors.primary : AppColors.border,
                  width: DesignTokens.borderWidthThin,
                ),
            boxShadow: [
              BoxShadow(
                color: AppColors.withOpacity(Colors.black, 0.05),
                blurRadius: _isHovered ? 8 : 4,
                offset: Offset(0, _isHovered ? 4 : 2),
              ),
            ],
          ),
          padding:
              widget.padding ?? const EdgeInsets.all(DesignTokens.spacing16),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Simple card without animations (for better performance in lists)
class SimpleCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Border? border;

  const SimpleCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius ?? DesignTokens.borderRadiusMedium,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.white,
            borderRadius: borderRadius ?? DesignTokens.borderRadiusMedium,
            border:
                border ??
                Border.all(
                  color: AppColors.border,
                  width: DesignTokens.borderWidthThin,
                ),
            boxShadow: [
              BoxShadow(
                color: AppColors.withOpacity(Colors.black, 0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: padding ?? const EdgeInsets.all(DesignTokens.spacing16),
          child: child,
        ),
      ),
    );
  }
}
