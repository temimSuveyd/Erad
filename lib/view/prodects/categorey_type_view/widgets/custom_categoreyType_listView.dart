import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:erad/controller/categoreys/categorey_type_controller.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/prodects/categorey_type_view/widgets/custom_categoreyType_Card.dart';
import 'package:erad/view/prodects/categorey_type_view/widgets/mobile_category_type_card.dart';

class Custom_categoreyType_listView extends StatelessWidget {
  const Custom_categoreyType_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoreyTypeControllerImp>(
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
                  onPressed: () => controller.getCategoreysType(),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (controller.statusreqest == Statusreqest.success) {
          if (controller.categoreyTypeList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.layers_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: DesignTokens.spacing16),
                  Text(
                    'لا توجد أنواع تصنيفات',
                    style: DesignTokens.getBodyLarge(context),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.categoreyTypeList.length,
            itemBuilder: (context, index) {
              final isMobile = DesignTokens.isMobile(context);

              if (isMobile) {
                // Use mobile card for mobile devices
                return MobileCategoryTypeCard(
                  title: controller.categoreyTypeList[index]["categorey_type"],
                  id: controller.categoreyTypeList[index].id,
                );
              } else {
                // Use desktop card for larger screens
                return Custom_categoreyType_Card(
                  title: controller.categoreyTypeList[index]["categorey_type"],
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
