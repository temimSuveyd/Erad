import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/customers_view/customers_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/data/model/customers/customers_model.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';

class CustomCustomersCard extends GetView<CustomersControllerImp> {
  const CustomCustomersCard({super.key, required this.customersModel});
  final CustomersModel customersModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Customer info
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customersModel.customer_name ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  customersModel.customer_city ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Action buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                color: AppColors.primary,
                icon: Icons.edit,
                onPressed: () => controller.show_edit_dialog(customersModel),
                title: "تحرير",
              ),
              const SizedBox(width: 8),
              CustomButton(
                color: AppColors.error,
                icon: Icons.delete,
                onPressed:
                    () => controller.show_delete_dialog(
                      customersModel.customer_id!,
                    ),
                title: "حذف",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
