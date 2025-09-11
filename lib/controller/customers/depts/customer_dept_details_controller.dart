import 'dart:developer';

import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/depts/customer_depts_data.dart';
import 'package:erad/data/model/customer_depts/customer_depts_model.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:erad/view/custom_widgets/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CustomerDeptsDetailsController extends GetxController {
  getBills();
  getPayments();
  getDeptDetails();
  initData();
  goToBillDetails(String billId);
  showAddPaymentDialog();
  addPayment();
  bool calculatesAmountOfRemainingDebt();
  updateDeptData();
  showDeleteDeptDialog();
  deleteDept();
  showDeletePayment(String id);
  deletePayment(String id);
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

  DeptsModel? deptModel;
  DateTime paymentDate = DateTime.now();

  @override
  getBills() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _customerDeptsData.getBillById(userID, deptId!).listen((event) {
        deptsList.value = event.docs;
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
        paymentsList.value = event.docs;
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
      _customerDeptsData.getDeptDetails(userID, deptId!).then((value) {
        if (value.data()!.isEmpty) {
          statusreqest = Statusreqest.empty;
        } else {
          deptModel = DeptsModel.formatJson(value.data());
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
        buttonColor: AppColors.primary,
backgroundColor: AppColors.backgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Custom_textfield(
              hintText: "أضف سعر الدفع",
              suffixIcon: Icons.attach_money_rounded,
              validator: (p0) {
                return null;
              },
              controller: addPaymentController,
              onChanged: (p0) {},
            ),
            SizedBox(height: 10),
            Custom_set_date_button(
              hintText: "تاريخ الدفعة",
              onPressed: () {
                showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    paymentDate = selectedDate;
                    update();
                  }
                });
              },
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
    double totalDepts = 0;
    double totalPayment = 0;
    for (var total_Depts in deptsList) {
      totalDepts = total_Depts['total_price'] + totalDepts;
    }
    for (var total_payments in paymentsList) {
      totalPayment = total_payments['total_price'] + totalPayment;
    }
    if (totalDepts - totalPayment <= -1) {
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
      _customerDeptsData.updateTotalDept(
        deptId!,
        userID,
        remainingDebtAamount,
      );
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
      backgroundColor: AppColors.backgroundColor,
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
      _customerDeptsData.delteDepts(deptId!, userID);
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
      backgroundColor: AppColors.backgroundColor,
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
      _customerDeptsData.deltePaymentFromDepts(id, deptId!, userID);
      getBills();
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void onInit() {
    initData();
    getPayments();
    getDeptDetails();
    getBills();
    super.onInit();
  }
}
