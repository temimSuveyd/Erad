import 'package:flutter/material.dart';
import 'package:erad/core/constans/design_tokens.dart';

/// Responsive layout wrapper that adapts to screen size
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= DesignTokens.tabletBreakpoint) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= DesignTokens.mobileBreakpoint) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

/// Responsive padding widget
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets? mobile;
  final EdgeInsets? tablet;
  final EdgeInsets? desktop;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding;
    
    if (DesignTokens.isDesktop(context)) {
      padding = desktop ?? 
                tablet ?? 
                mobile ?? 
                EdgeInsets.all(DesignTokens.spacingDesktop);
    } else if (DesignTokens.isTablet(context)) {
      padding = tablet ?? 
                mobile ?? 
                EdgeInsets.all(DesignTokens.spacingTablet);
    } else {
      padding = mobile ?? EdgeInsets.all(DesignTokens.spacingMobile);
    }

    return Padding(
      padding: padding,
      child: child,
    );
  }
}

/// Responsive container with max width constraint
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? 1200,
        ),
        padding: padding ?? EdgeInsets.all(DesignTokens.getResponsiveSpacing(context)),
        child: child,
      ),
    );
  }
}

/// Responsive grid view
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double? spacing;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final double? childAspectRatio;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    int crossAxisCount;
    
    if (DesignTokens.isDesktop(context)) {
      crossAxisCount = desktopColumns ?? 4;
    } else if (DesignTokens.isTablet(context)) {
      crossAxisCount = tabletColumns ?? 3;
    } else {
      crossAxisCount = mobileColumns ?? 2;
    }

    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spacing ?? DesignTokens.spacing16,
      mainAxisSpacing: spacing ?? DesignTokens.spacing16,
      childAspectRatio: childAspectRatio ?? 1.0,
      children: children,
    );
  }
}
