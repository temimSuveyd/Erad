import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

/// Navigation item model
class NavigationItem {
  final String label;
  final IconData icon;
  final String route;

  const NavigationItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}

/// Responsive navigation wrapper
/// Shows bottom navigation on mobile, drawer on tablet/desktop
class ResponsiveNavigationScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final List<NavigationItem> navigationItems;
  final int currentIndex;
  final Function(int) onNavigationChanged;
  final Widget? floatingActionButton;

  const ResponsiveNavigationScaffold({
    super.key,
    required this.body,
    this.appBar,
    required this.navigationItems,
    required this.currentIndex,
    required this.onNavigationChanged,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = DesignTokens.isMobile(context);

    if (isMobile) {
      // Mobile: Bottom Navigation
      return Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: _buildBottomNavigation(context),
        floatingActionButton: floatingActionButton,
      );
    } else {
      // Tablet/Desktop: Drawer
      return Scaffold(
        appBar: appBar,
        body: Row(
          children: [
            _buildNavigationRail(context),
            Expanded(child: body),
          ],
        ),
        floatingActionButton: floatingActionButton,
      );
    }
  }

  Widget _buildBottomNavigation(BuildContext context) {
    // Limit to 5 items for bottom navigation
    final items = navigationItems.take(5).toList();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.withOpacity(Colors.black, 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing8,
            vertical: DesignTokens.spacing8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (index) => _buildBottomNavItem(
                context,
                items[index],
                index,
                currentIndex == index,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    BuildContext context,
    NavigationItem item,
    int index,
    bool isSelected,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () => onNavigationChanged(index),
        borderRadius: DesignTokens.borderRadiusMedium,
        child: AnimatedContainer(
          duration: DesignTokens.durationFast,
          padding: const EdgeInsets.symmetric(
            vertical: DesignTokens.spacing8,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.withOpacity(AppColors.primary, 0.1)
                : Colors.transparent,
            borderRadius: DesignTokens.borderRadiusMedium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                item.icon,
                size: 24,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              const SizedBox(height: 4),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationRail(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          left: BorderSide(
            color: AppColors.border,
            width: DesignTokens.borderWidthThin,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: DesignTokens.spacing16),
          Expanded(
            child: ListView.builder(
              itemCount: navigationItems.length,
              itemBuilder: (context, index) {
                final item = navigationItems[index];
                final isSelected = currentIndex == index;
                
                return _buildNavigationRailItem(
                  context,
                  item,
                  index,
                  isSelected,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRailItem(
    BuildContext context,
    NavigationItem item,
    int index,
    bool isSelected,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing12,
        vertical: DesignTokens.spacing4,
      ),
      child: InkWell(
        onTap: () => onNavigationChanged(index),
        borderRadius: DesignTokens.borderRadiusMedium,
        child: AnimatedContainer(
          duration: DesignTokens.durationFast,
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing16,
            vertical: DesignTokens.spacing12,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.withOpacity(AppColors.primary, 0.1)
                : Colors.transparent,
            borderRadius: DesignTokens.borderRadiusMedium,
            border: isSelected
                ? Border(
                    right: BorderSide(
                      color: AppColors.primary,
                      width: 3,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 24,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
