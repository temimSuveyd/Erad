import 'package:erad/core/function/is_date_in_range.dart';
import 'package:erad/data/data_score/remote/depts/supplier_depts_data.dart';
import 'package:erad/data/model/supplier_bill_view/bill_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/Supplier/Supplier_bill_data.dart';

abstract class SuppliersBillViewController extends GetxController {
  void getSuppliersBills();
  void searchForBillsBaySupplierName();
  void searchForBillBayCity(String cityName);
  void searchByDate(DateTimeRange dateRange);
  void goToDetailsPage(String billId);
  void updateBillStaus(String billStatus, String billId, BillModel billModel);
  void addDept(BillModel? billModel);
  void addBillToDepts(BillModel? billModel);
  void deleteDept(String customerId, String billId);
}

class SuppliersBillViewControllerImp extends SuppliersBillViewController {
  SupplierBillData supplierBillData = SupplierBillData();
  SupplierDeptsData supplierDeptsData = SupplierDeptsData();
  var supplierBillsList = <Map<String, dynamic>>[].obs;
  Services services = Get.find();
  Statusreqest statusreqest = Statusreqest.success;
  late TextEditingController searchBillsTextController =
      TextEditingController();
  String? selectedSupplierCity;
  DateTimeRange? selectedDateRange;
  DateTime startedDate = DateTime.now();

  @override
  void getSuppliersBills() {
    statusreqest = Statusreqest.loading;
    update();
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      supplierBillData.getAllBills(userID).listen((event) {
        List<Map<String, dynamic>> allBills =
            event.map((doc) => doc).toList();
        supplierBillsList.value =
            allBills.where((data) {
              final DateTime billDate = DateTime.parse(data["bill_date"]);
              if (selectedDateRange == null) {
                return (billDate.year == startedDate.year &&
                    billDate.month == startedDate.month &&
                    billDate.day == startedDate.day);
              } else {
                return isDateInRange(
                  billDate: billDate,
                  range: selectedDateRange!,
                );
              }
            }).toList();
        if (supplierBillsList.isEmpty) {
          statusreqest = Statusreqest.empty;
        } else {
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
  void searchForBillsBaySupplierName() {
    String search = searchBillsTextController.text;
    if (search.isEmpty) {
      getSuppliersBills();
    } else {
      supplierBillsList.value =
          supplierBillsList.where((data) {
            final supplierName = data["supplier_name"].toString().toLowerCase();
            final billId = data["bill_no"].toString().toLowerCase();
            if (supplierName.contains(search.toLowerCase()) ||
                billId.contains(search.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          }).toList();
      if (supplierBillsList.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
      update();
    }
  }

  @override
  void searchForBillBayCity(String cityName) {
    if (cityName.isEmpty || cityName == "جميع المدن") {
      getSuppliersBills();
    } else {
      String userID = services.sharedPreferences.getString(AppShared.userID)!;
      supplierBillData.getAllBills(userID).listen((event) {
        List<Map<String, dynamic>> allBills =
            event.map((doc) => doc).toList();
        supplierBillsList.value =
            allBills.where((data) {
              final fileView = data["supplier_city"].toLowerCase();
              return fileView.contains(cityName.toLowerCase());
            }).toList();
        if (supplierBillsList.isEmpty) {
          statusreqest = Statusreqest.empty;
        }
        selectedSupplierCity = cityName;
        update();
      });
    }
  }

  @override
  void searchByDate(DateTimeRange dateRange) async {
    try {
      selectedDateRange = dateRange;
      getSuppliersBills();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void goToDetailsPage(String billId) {
    Get.toNamed(
      AppRoutes.supplier_bill_details_page,
      arguments: {"bill_id": billId},
    );
  }

  @override
  Future updateBillStaus(
    String billStatus,
    String billId,
    BillModel billModel,
  ) async {
    try {
      String userID = services.sharedPreferences.getString(AppShared.userID)!;
      statusreqest = Statusreqest.loading;
      update();
      await supplierBillData.updateBillStatus(userID, billId, billStatus);
      if (billStatus == 'deliveryd' && billModel.payment_type != 'monetary') {
        await addDept(billModel);
        await addBillToDepts(billModel);
      } else {
        deleteDept(billModel.supplier_id!, billId);
      }
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.success;
    }
    update();
  }

  @override
  Future addDept(BillModel? billModel) async {
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      await supplierDeptsData.addDepts(
        billModel!.supplier_id!,
        billModel.supplier_name!,
        billModel.supplier_city!,
        userID,
        billModel.total_price!,
        billModel.bill_date!,
      );
      addBillToDepts(billModel);
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  Future addBillToDepts(BillModel? billModel) async {
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      await supplierDeptsData.addBillToDepts(
        billModel!.bill_no!,
        billModel.bill_id!,
        billModel.supplier_id!,
        billModel.payment_type!,
        userID,
        billModel.total_price!,
        billModel.bill_date!,
      );
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void deleteDept(String customerId, String billId) async {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      await supplierDeptsData.deleteBillFromDepts(billId, customerId, userID);
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void onInit() async {
    getSuppliersBills();
    super.onInit();
  }
}
