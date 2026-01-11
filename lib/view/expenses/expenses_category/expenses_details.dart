// import 'package:erad/controller/expenses/expenses_category_controller.dart';
// import 'package:erad/view/custom_widgets/custom_appBar.dart';
// import 'package:flutter/material.dart';
// import 'package:erad/core/constans/colors.dart';
// import 'package:get/get.dart';

// class ExpensesDetails extends GetView<ExpensesCategoryControllerImp> {
//   const ExpensesDetails({super.key});

//   @override
//   Widget build(BuildContext context) {

//     Get.lazyPut(() => ExpensesCategoryControllerImp());
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: customAppBar(title: "فئة الإنفاق", context: context),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {controller.showaddExpensesCategoryDailog();},
//         tooltip: "Ekle",
//         backgroundColor: AppColors.primary,
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: Text(
//           "إضافة فئة مصروف",
//           style: const TextStyle(color: Colors.white, fontSize: 18),
//         ),
//       ),

//       body: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: items.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 10),
//         itemBuilder: (context, index) {
//           final item = items[index];
//           final title = item['title'] ?? 'Başlık';
//           final amount = item['amount']?.toString() ?? '';
//           return ListTile(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             tileColor: AppColors.primary.withValues(alpha: 0.08),
//             leading: CircleAvatar(
//               backgroundColor: AppColors.primary.withValues(alpha: 0.18),
//               child: const Icon(Icons.attach_money, color: Colors.white),
//             ),
//             title: Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//             trailing: Text(
//               amount,
//               style: const TextStyle(
//                 color: Colors.white70,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
