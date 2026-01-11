import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:erad/controller/brands/brands_controller.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/prodects/brands_view/widgets/custom_brands_Card.dart';
import 'package:erad/view/prodects/brands_view/widgets/mobile_brand_card.dart';

class CustomBrandsListView extends StatelessWidget {
  const CustomBrandsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandsControllerImp>(
      builder: (controller) {
        // Handle different states
        if (controller.statusreqest == Statusreqest.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.statusreqest == Statusreqest.faliure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: DesignTokens.spacing16),
                Text(
                  'حدث خطأ في تحميل البيانات',
                  style: DesignTokens.getBodyLarge(context),
                ),
                const SizedBox(height: DesignTokens.spacing16),
                ElevatedButton(
                  onPressed: () => controller.getBrands(),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (controller.statusreqest == Statusreqest.success) {
          if (controller.brandsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.branding_watermark_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: DesignTokens.spacing16),
                  Text(
                    'لا توجد علامات تجارية',
                    style: DesignTokens.getBodyLarge(context),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.brandsList.length,
            itemBuilder: (context, index) {
              final isMobile = DesignTokens.isMobile(context);
              final brandName = controller.brandsList[index]["brand_name"];

              if (isMobile) {
                // Use mobile card for mobile devices
                return MobileBrandCard(title: brandName);
              } else {
                // Use desktop card for larger screens
                return Custom_Brands_Card(title: brandName);
              }
            },
          );
        }

        // Default case
        return const SizedBox.shrink();
      },
    );
  }
}
