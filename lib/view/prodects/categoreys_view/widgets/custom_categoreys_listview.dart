import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:erad/controller/categoreys/categorey_controller.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/prodects/categoreys_view/widgets/custom_categorey_card.dart';
import 'package:erad/view/prodects/categoreys_view/widgets/mobile_category_card.dart';

class Custom_categoreys_listView extends StatelessWidget {
  const Custom_categoreys_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoreyControllerImp>(
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
                  onPressed: () => controller.getCategoreys(),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (controller.statusreqest == Statusreqest.success) {
          if (controller.categoreys_list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: DesignTokens.spacing16),
                  Text(
                    'لا توجد تصنيفات',
                    style: DesignTokens.getBodyLarge(context),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.categoreys_list.length,
            itemBuilder: (context, index) {
              final isMobile = DesignTokens.isMobile(context);

              if (isMobile) {
                // Use mobile card for mobile devices
                return MobileCategoryCard(
                  title: controller.categoreys_list[index]["category_name"],
                  id: controller.categoreys_list[index]['id'],
                );
              } else {
                // Use desktop card for larger screens
                return Custom_categorey_card(
                  count: controller.categoreys_list.length.toString(),
                  title: controller.categoreys_list[index]["category_name"],
                );
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
