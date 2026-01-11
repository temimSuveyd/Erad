import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:erad/controller/brands/brands_type_controller.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/prodect/prodect_model.dart';
import 'package:erad/view/prodects/brands_type_view/widgets/custom_brands_type_Card.dart';
import 'package:erad/view/prodects/brands_type_view/widgets/mobile_brands_type_card.dart';

// ignore: camel_case_types
class Custom_brands_type_listView extends StatelessWidget {
  const Custom_brands_type_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandsTypeControllerImp>(
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
                  onPressed: () => controller.get_brands_type(),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (controller.statusreqest == Statusreqest.success) {
          if (controller.brandsTypeList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: DesignTokens.spacing16),
                  Text(
                    'لا توجد أنواع منتجات',
                    style: DesignTokens.getBodyLarge(context),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.brandsTypeList.length,
            itemBuilder: (context, index) {
              final isMobile = DesignTokens.isMobile(context);
              final productModel = ProductModel.formateJson(
                controller.brandsTypeList[index],
              );

              if (isMobile) {
                // Use mobile card for mobile devices
                return MobileBrandsTypeCard(productModel: productModel);
              } else {
                // Use desktop card for larger screens
                return Custom_brands_type_Card(productModel: productModel);
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
