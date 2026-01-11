import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/prodects/products_view/widgets/mobile_products_header.dart';
import 'package:erad/view/prodects/products_view/widgets/mobile_products_filters.dart';
import 'package:erad/view/prodects/products_view/widgets/custom_categoreyType_listView.dart';

class ProductsViewPage extends StatelessWidget {
  const ProductsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = DesignTokens.isMobile(context);
    final padding = DesignTokens.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          isMobile ? null : customAppBar(title: "المنتجات", context: context),
      body: CustomScrollView(
        slivers: [
          // Mobile header (replaces app bar on mobile)
          if (isMobile) const SliverToBoxAdapter(child: MobileProductsHeader()),

          // Filters section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: const MobileProductsFilters(),
            ),
          ),

          // Products list
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Custom_products_listView(),
            ),
          ),

          // Bottom padding for mobile
          if (isMobile)
            const SliverToBoxAdapter(
              child: SizedBox(height: DesignTokens.spacing24),
            ),
        ],
      ),
    );
  }
}
