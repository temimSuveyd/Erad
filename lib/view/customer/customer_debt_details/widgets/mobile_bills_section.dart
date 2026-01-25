import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/depts/customer_dept_details_controller.dart';
import 'package:erad/core/constans/colors.dart';

class MobileBillsSection extends GetView<CustomerDeptsDetailsControllerImp> {
  const MobileBillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDeptsDetailsControllerImp>(
      builder:
          (controller) => Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.grey, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Icons.receipt_long_outlined,
                        color: AppColors.red,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الفواتير المستحقة',
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (controller.selectedDateRange != null)
                            Text(
                              'من ${controller.selectedDateRange!.start.day}/${controller.selectedDateRange!.start.month}/${controller.selectedDateRange!.start.year} إلى ${controller.selectedDateRange!.end.day}/${controller.selectedDateRange!.end.month}/${controller.selectedDateRange!.end.year}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.grey),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '${controller.deptsList.length}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20.0),

                // Bills list
                if (controller.deptsList.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.deptsList.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 12.0),
                    itemBuilder: (context, index) {
                      final bill = controller.deptsList[index];
                      return _buildBillCard(context, bill, index);
                    },
                  )
                else
                  _buildEmptyState(context),
              ],
            ),
          ),
    );
  }

  Widget _buildBillCard(BuildContext context, dynamic billDoc, int index) {
    // DocumentSnapshot'ı Map'e çevir
    final bill = billDoc.data() as Map<String, dynamic>;
    final billDate = bill['bill_date']?.toDate() as DateTime?;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.wihet,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.red),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () => controller.goToBillDetails(bill['bill_id'] ?? ''),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bill header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.receipt_outlined,
                    color: AppColors.red,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'فاتورة رقم: ${bill['bill_no'] ?? 'غير محدد'}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${bill['total_price'] ?? 0} د.ع',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12.0),

            // Bill details
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.black,
                  size: 16,
                ),
                const SizedBox(width: 8.0),
                Text(
                  billDate != null
                      ? "${billDate.day}/${billDate.month}/${billDate.year}"
                      : 'غير محدد',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.black),
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, color: AppColors.black, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.red,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: AppColors.green,
              size: 32,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'لا توجد فواتير مستحقة',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'جميع الفواتير في هذا النطاق الزمني تم سدادها',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
