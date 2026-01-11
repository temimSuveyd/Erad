import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/home/home_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/home/home_modle.dart';

class CustomHomeCard extends GetView<HomeControllerImp> {
  const CustomHomeCard({super.key, required this.homeModle});

  final HomeModle homeModle;

  @override
  Widget build(BuildContext context) {
    return _AnimatedHomeCard(
      onTap: () => controller.goToPage(homeModle.pageName!),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container with gradient
          Image.asset(
            width: 70,
            height: 70,
            homeModle.imagePath ?? '',
            fit: BoxFit.contain,
            errorBuilder:
                (context, error, stackTrace) => const Icon(
                  Icons.dashboard_rounded,
                  size: 36,
                  color: AppColors.white,
                ),
          ),

          const SizedBox(height: DesignTokens.spacing16),

          // Title with responsive font size
          Text(
            homeModle.title ?? '',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: DesignTokens.getFontSize(
                context,
                DesignTokens.fontScaleBase,
              ),
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated card widget for home cards
class _AnimatedHomeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _AnimatedHomeCard({required this.child, required this.onTap});

  @override
  State<_AnimatedHomeCard> createState() => _AnimatedHomeCardState();
}

class _AnimatedHomeCardState extends State<_AnimatedHomeCard>
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
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: DesignTokens.durationFast,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: DesignTokens.borderRadiusMedium,
          ),
          padding: const EdgeInsets.all(DesignTokens.spacing20),
          child: widget.child,
        ),
      ),
    );
  }
}
