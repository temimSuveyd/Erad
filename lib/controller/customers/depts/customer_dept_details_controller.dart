import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/function/is_date_in_range.dart';
import 'package:erad/core/function/save_started_date.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/depts/customer_depts_data.dart';
import 'package:erad/data/model/customer_depts/customer_depts_model.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:erad/view/custom_widgets/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CustomerDeptsDetailsController extends GetxController {
  void getBills();
  void getPayments();
  void getDeptDetails();
  void initData();
  void goToBillDetails(String billId);
  void showAddPaymentDialog();
  void addPayment();
  bool calculatesAmountOfRemainingDebt();
  void updateDeptData();
  void showDeleteDeptDialog();
  void deleteDept();
  void showDeletePayment(String id);
  void deletePayment(String id);
  Future startedDate();
  void setDateRenage(DateTimeRange dateRange);
  void setPaymentDate(DateTime date);
  void selectMonth(String monthKey);
  Map<String, List<Map<String, dynamic>>> groupBillsByMonth();
  Map<String, List<Map<String, dynamic>>> groupPaymentsByMonth();
  double calculateTotalDebts();
  double calculateTotalPayments();
  double calculateRemainingDebt();
}

class CustomerDeptsDetailsControllerImp extends CustomerDeptsDetailsController {
  final addPaymentController = TextEditingController();
  final CustomerDeptsData _customerDeptsData = CustomerDeptsData();
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  String? deptId;
  double remainingDebtAamount = 0.0;
  double totalDept = 0.0;
  var deptsList = [].obs;
  var paymentsList = [].obs;
  var allBillsList = [].obs; // Tüm faturalar (filtrelenmemiş)
  var allPaymentsList = [].obs; // Tüm ödemeler (filtrelenmemiş)

  // Ay bazında gruplandırma için
  var selectedMonth = ''.obs; // Seçili ay
  var availableMonths = <String>[].obs; // Mevcut aylar listesi

  DeptsModel? deptModel;
  DateTime paymentDate = DateTime.now();
  DateTimeRange? startedDateRange;
  DateTimeRange? selectedDateRange;

  @override
  getBills() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _customerDeptsData.getBillById(userID, deptId!).listen((event) {
        allBillsList.value = event; // Tüm faturaları sakla

        // Eğer ay seçilmişse, sadece o ayın faturalarını göster
        if (selectedMonth.value.isNotEmpty) {
          deptsList.value = _filterBillsByMonth(
            allBillsList,
            selectedMonth.value,
          );
        } else {
          // Tarih aralığı filtresi uygula
          deptsList.value =
              allBillsList.where((data) {
                final DateTime billDate = data['bill_date'].toDate();
                if (selectedDateRange == null) {
                  return isDateInRange(
                    billDate: billDate,
                    range: startedDateRange!,
                  );
                } else {
                  return isDateInRange(
                    billDate: billDate,
                    range: selectedDateRange!,
                  );
                }
              }).toList();
        }

        _updateAvailableMonths();
        calculatesAmountOfRemainingDebt();

        if (deptsList.isEmpty) {
          statusreqest = Statusreqest.empty;
        } else {
          statusreqest = Statusreqest.success;
        }
        update();
      });
    } catch (e) {
      statusreqest = Statusreqest.success;
      update();
    }
  }

  @override
  getPayments() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _customerDeptsData.getAllPayments(userID, deptId!).listen((event) {
        allPaymentsList.value = event; // Tüm ödemeleri sakla

        // Eğer ay seçilmişse, sadece o ayın ödemelerini göster
        if (selectedMonth.value.isNotEmpty) {
          paymentsList.value = _filterPaymentsByMonth(
            allPaymentsList,
            selectedMonth.value,
          );
        } else {
          // Tarih aralığı filtresi uygula
          paymentsList.value =
              allPaymentsList.where((data) {
                final DateTime billDate = data['payment_date'].toDate();
                if (selectedDateRange == null) {
                  return isDateInRange(
                    billDate: billDate,
                    range: startedDateRange!,
                  );
                } else {
                  return isDateInRange(
                    billDate: billDate,
                    range: selectedDateRange!,
                  );
                }
              }).toList();
        }

        if (paymentsList.isEmpty) {
          statusreqest = Statusreqest.empty;
        } else {
          statusreqest = Statusreqest.success;
        }
        update();
      });
    } catch (e) {
      statusreqest = Statusreqest.success;
      update();
    }
  }

  @override
  getDeptDetails() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      _customerDeptsData.getDeptDetails(deptId!).then((value) {
        if (value == null || value.isEmpty) {
          statusreqest = Statusreqest.empty;
        } else {
          deptModel = DeptsModel.formatJson(value);
          statusreqest = Statusreqest.success;
        }
        update();
      });
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  initData() {
    deptId = Get.arguments["dept_id"];
  }

  @override
  goToBillDetails(String billId) {
    Get.toNamed(
      AppRoutes.customer_bills_details_page,
      arguments: {"bill_id": billId},
    );
  }

  @override
  showAddPaymentDialog() {
    if (calculatesAmountOfRemainingDebt() == true) {
      Get.defaultDialog(
        title: "دفعة جديدة",
        titleStyle: TextStyle(color: AppColors.primary),
        buttonColor: AppColors.primary,
        backgroundColor: AppColors.background,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              height: 43,
              hintText: "أضف سعر الدفع",
              suffixIcon: Icons.attach_money_rounded,
              validator: (p0) {
                return null;
              },
              controller: addPaymentController,
              onChanged: (p0) {},
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: GetBuilder<CustomerDeptsDetailsControllerImp>(
                id: "paymentDatePicker", // You may want to specify an ID for finer-grained updates.
                builder:
                    (controller) => CustomSetDateButton(
                      hintText:
                          "${controller.paymentDate.year}/${controller.paymentDate.month.toString().padLeft(2, '0')}/${controller.paymentDate.day.toString().padLeft(2, '0')}",
                      onPressed: () {
                        showDatePicker(
                          context: Get.context!,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary:
                                      AppColors
                                          .primary, // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface:
                                      AppColors.primary, // body text color
                                  surface:
                                      AppColors
                                          .backgroundColor, // date picker bg color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        AppColors.primary, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            controller.setPaymentDate(selectedDate);
                            controller.update(["paymentDatePicker"]);
                          }
                        });
                      },
                    ),
              ),
            ),
          ],
        ),
        textConfirm: "إضافة",
        textCancel: "إلغاء",
        confirmTextColor: Colors.white,
        onConfirm: () {
          addPayment();
          Get.back();
        },
        onCancel: () {},
      );
    }
  }

  @override
  addPayment() {
    statusreqest = Statusreqest.loading;
    update();

    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;

      try {
        final double totalPrice = double.parse(addPaymentController.text);
        if (remainingDebtAamount - totalPrice >= 0) {
          _customerDeptsData.addPaymentToDepts(
            deptId!,
            userID,
            totalPrice,
            paymentDate,
          );
          getBills();
        } else {
          custom_snackBar(
            AppColors.red,
            "انتباه",
            "لا يمكنك إضافة دفعة بعد الآن",
          );
        }

        statusreqest = Statusreqest.success;
        update();
        addPaymentController.clear();
      } on FormatException {
        custom_snackBar(
          AppColors.red,
          "خطأ",
          "لا يمكنك إدخال أي شيء آخر غير الأرقام",
        );
        addPaymentController.clear();
        statusreqest = Statusreqest.success;
        update();
      }
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  bool calculatesAmountOfRemainingDebt() {
    // Tüm borçları ve ödemeleri hesapla (filtrelenmemiş verilerle)
    double totalDebts = calculateTotalDebts();
    double totalPayments = calculateTotalPayments();

    if (totalDebts - totalPayments <= -1 &&
        allPaymentsList.isNotEmpty &&
        allBillsList.isNotEmpty) {
      custom_snackBar(
        AppColors.primary,
        "لقد انتهى الدين",
        "لقد انتهى الدين ، لا يمكنك إضافة دفعة بعد الآن",
      );
      update();
      return false;
    } else {
      remainingDebtAamount = totalDebts - totalPayments;
      updateDeptData();
      update();
      return true;
    }
  }

  @override
  updateDeptData() {
    final String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      _customerDeptsData.updateTotalDept(deptId!, userID, remainingDebtAamount);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  showDeleteDeptDialog() {
    Get.defaultDialog(
      title: "انتباه",
      middleText: "هل أنت متأكد أنك تريد حذف هذا الدين؟",
      textConfirm: "حذف",
      textCancel: "يلغي",
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primary,
      backgroundColor: AppColors.background,
      onConfirm: () {
        deleteDept();
        Get.back();
        custom_snackBar(AppColors.green, "تم حذف ", "تم حذف هذا الدين بنجاح");
        Get.back();
      },
      onCancel: () {},
    );
  }

  @override
  deleteDept() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _customerDeptsData.deleteDepts(deptId!, userID);
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  showDeletePayment(String id) {
    Get.defaultDialog(
      title: "انتباه",
      middleText: "هل أنت متأكد من أنك تريد حذف هذه الدفعة؟",
      textConfirm: "حذف",
      textCancel: "يلغي",
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primary,
      backgroundColor: AppColors.background,
      onConfirm: () {
        deletePayment(id);
        Get.back();
        custom_snackBar(AppColors.green, "تم حذف ", "تم حذف هذا الدين بنجاح");
      },
      onCancel: () {},
    );
  }

  @override
  deletePayment(String id) {
    statusreqest = Statusreqest.loading;
    update();

    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _customerDeptsData.deletePaymentFromDepts(id, deptId!, userID);
      getBills();
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  Future startedDate() async {
    startedDateRange = await saveCustomDateRange();
  }

  @override
  void setDateRenage(DateTimeRange dateRange) {
    selectedDateRange = dateRange;
    getBills();
    getPayments();
  }

  @override
  void setPaymentDate(DateTime date) {
    paymentDate = date;
    update();
  }

  // Yeni metodlar
  @override
  void selectMonth(String monthKey) {
    if (selectedMonth.value == monthKey) {
      // Aynı ay seçilirse, filtreyi kaldır
      selectedMonth.value = '';
      deptsList.value = allBillsList;
      paymentsList.value = allPaymentsList;
    } else {
      selectedMonth.value = monthKey;
      deptsList.value = _filterBillsByMonth(allBillsList, monthKey);
      paymentsList.value = _filterPaymentsByMonth(allPaymentsList, monthKey);
    }
    update();
  }

  @override
  Map<String, List<Map<String, dynamic>>> groupBillsByMonth() {
    Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var bill in allBillsList) {
      final DateTime billDate = bill['bill_date'].toDate();
      final String monthKey =
          '${billDate.year}-${billDate.month.toString().padLeft(2, '0')}';

      if (!grouped.containsKey(monthKey)) {
        grouped[monthKey] = [];
      }
      grouped[monthKey]!.add(bill);
    }

    return grouped;
  }

  @override
  Map<String, List<Map<String, dynamic>>> groupPaymentsByMonth() {
    Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var payment in allPaymentsList) {
      final DateTime paymentDate = payment['payment_date'].toDate();
      final String monthKey =
          '${paymentDate.year}-${paymentDate.month.toString().padLeft(2, '0')}';

      if (!grouped.containsKey(monthKey)) {
        grouped[monthKey] = [];
      }
      grouped[monthKey]!.add(payment);
    }

    return grouped;
  }

  @override
  double calculateTotalDebts() {
    double total = 0.0;
    for (var debt in allBillsList) {
      total += (debt['total_price'] as num).toDouble();
    }
    return total;
  }

  @override
  double calculateTotalPayments() {
    double total = 0.0;
    for (var payment in allPaymentsList) {
      total += (payment['total_price'] as num).toDouble();
    }
    return total;
  }

  @override
  double calculateRemainingDebt() {
    return calculateTotalDebts() - calculateTotalPayments();
  }

  // Yardımcı metodlar
  List<Map<String, dynamic>> _filterBillsByMonth(
    List<dynamic> bills,
    String monthKey,
  ) {
    return bills
        .where((bill) {
          final DateTime billDate = bill['bill_date'].toDate();
          final String billMonthKey =
              '${billDate.year}-${billDate.month.toString().padLeft(2, '0')}';
          return billMonthKey == monthKey;
        })
        .cast<Map<String, dynamic>>()
        .toList();
  }

  List<Map<String, dynamic>> _filterPaymentsByMonth(
    List<dynamic> payments,
    String monthKey,
  ) {
    return payments
        .where((payment) {
          final DateTime paymentDate = payment['payment_date'].toDate();
          final String paymentMonthKey =
              '${paymentDate.year}-${paymentDate.month.toString().padLeft(2, '0')}';
          return paymentMonthKey == monthKey;
        })
        .cast<Map<String, dynamic>>()
        .toList();
  }

  void _updateAvailableMonths() {
    Set<String> months = {};

    // Faturalardan ayları topla
    for (var bill in allBillsList) {
      final DateTime billDate = bill['bill_date'].toDate();
      final String monthKey =
          '${billDate.year}-${billDate.month.toString().padLeft(2, '0')}';
      months.add(monthKey);
    }

    // Ödemelerden ayları topla
    for (var payment in allPaymentsList) {
      final DateTime paymentDate = payment['payment_date'].toDate();
      final String monthKey =
          '${paymentDate.year}-${paymentDate.month.toString().padLeft(2, '0')}';
      months.add(monthKey);
    }

    availableMonths.value =
        months.toList()..sort((a, b) => b.compareTo(a)); // En yeni ay önce
  }

  String getMonthDisplayName(String monthKey) {
    final parts = monthKey.split('-');
    final year = parts[0];
    final month = int.parse(parts[1]);

    const monthNames = [
      '',
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    return '${monthNames[month]} $year';
  }

  @override
  void onInit() async {
    await startedDate();
    initData();
    getPayments();
    getDeptDetails();
    getBills();
    super.onInit();
  }
}
