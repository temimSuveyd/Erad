import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/function/is_date_in_range.dart';
import 'package:erad/core/function/save_started_date.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/depts/supplier_depts_data.dart';
import 'package:erad/data/model/supplier_depts/supplier_depts_model.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:erad/view/custom_widgets/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SupplierDeptsDetailsController extends GetxController {
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
}

class SupplierDeptsDetailsControllerImpl
    extends SupplierDeptsDetailsController {
  final addPaymentController = TextEditingController();
  final SupplierDeptsData _supplierDeptsData = SupplierDeptsData();
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  String? deptId;
  double remainingDebtAamount = 0.0;
  double totalDept = 0.0;
  var deptsList = [].obs;
  var paymentsList = [].obs;

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
      _supplierDeptsData.getBillById(userID, deptId!).listen((event) {
        deptsList.value = event;
        deptsList.value =
            deptsList.where((data) {
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
      _supplierDeptsData.getAllPayments(userID, deptId!).listen((event) {
        paymentsList.value = event;
        paymentsList.value =
            paymentsList.where((data) {
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
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _supplierDeptsData.getDeptDetails(userID, deptId!).then((value) {
        if (value!.isEmpty) {
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
      AppRoutes.supplier_depts_details_page,
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
              child: GetBuilder<SupplierDeptsDetailsControllerImpl>(
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
          _supplierDeptsData.addPaymentToDepts(
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
    double totalDepts = 0;
    double totalPayment = 0;
    for (var total_Depts in deptsList) {
      totalDepts = total_Depts['total_price'] + totalDepts;
    }
    for (var total_payments in paymentsList) {
      totalPayment = total_payments['total_price'] + totalPayment;
    }
    if (totalDepts - totalPayment <= -1 &&
        paymentsList.isNotEmpty &&
        deptsList.isNotEmpty) {
      custom_snackBar(
        AppColors.primary,
        "لقد انتهى الدين",
        "لقد انتهى الدين ، لا يمكنك إضافة دفعة بعد الآن",
      );
      update();
      return false;
    } else {
      remainingDebtAamount = totalDepts - totalPayment;
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
      _supplierDeptsData.updateTotalDept(deptId!, userID, remainingDebtAamount);
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
      _supplierDeptsData.deleteDepts(deptId!, userID);
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
      _supplierDeptsData.deletePaymentFromDepts(id, deptId!, userID);
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
