import 'package:erad/data/data_score/static/home/home_page_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:erad/controller/home/home_controller.dart';
import 'package:erad/data/model/home/home_modle.dart';
import 'package:erad/view/home/widgets/custom_home_card.dart';

class Custom_home_gridViewBuilder extends StatelessWidget {
  const Custom_home_gridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerImp>(
      builder: (controller) => GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisExtent: 280,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 0.85,
        ),
        itemCount: home_page_data.length,
        itemBuilder: (context, index) => _AnimatedHomeCard(
          index: index,
          homeModle: HomeModle(
            home_page_data[index].imagePath,
            home_page_data[index].pageName,
            home_page_data[index].title,
          ),
        ),
      ),
    );
  }
}

// Animated wrapper for home cards
class _AnimatedHomeCard extends StatefulWidget {
  final int index;
  final HomeModle homeModle;

  const _AnimatedHomeCard({
    required this.index,
    required this.homeModle,
  });

  @override
  State<_AnimatedHomeCard> createState() => _AnimatedHomeCardState();
}

class _AnimatedHomeCardState extends State<_AnimatedHomeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400 + (widget.index * 100)),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    // Staggered animation
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Custom_home_card(
          homeModle: widget.homeModle,
        ),
      ),
    );
  }
}
