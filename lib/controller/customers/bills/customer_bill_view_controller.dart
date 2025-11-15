import 'package:erad/core/function/is_date_in_range.dart';
import 'package:erad/data/data_score/remote/depts/customer_depts_data.dart';
import 'package:erad/data/model/customer_bills_view/bill_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/customer/customer_bill_data.dart';

abstract class CustomerBillViewController extends GetxController {
  void getCustomersBills();
  void searchForBillsBayCustomerName();
  void searchForBillBayCity(String cityName);
  void searchByDate(DateTimeRange dateRange);
  void goToDetailsPage(String billId);
  void updateBillStaus(String billStatus, String billId, BillModel billModel);
  void addDept(BillModel? billModel);
  void addBillToDepts(BillModel? billModel);
  void deleteDept(String customerId, String billId);
}

class CustomerBillViewControllerImp extends CustomerBillViewController {
  CustomerBillData customerBillData = CustomerBillData();
  CustomerDeptsData customerDeptsData = CustomerDeptsData();
  var customer_bills_list = [].obs;
  Services services = Get.find();
  Statusreqest statusreqest = Statusreqest.success;
  late TextEditingController searchBillsTextController =
      TextEditingController();
  String? selectedCustomerCity;
  DateTimeRange? selectedDateRange;
  DateTime startedDate = DateTime.now();

  @override
  getCustomersBills() {
    statusreqest = Statusreqest.loading;
    update();
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      customerBillData.getAllBils(userID).listen((event) {
        customer_bills_list.value = event.docs;
        customer_bills_list.value =
            customer_bills_list.where((doc) {
              final data = doc.data();
              final DateTime billDate = data["bill_date"].toDate();
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
        if (customer_bills_list.isEmpty) {
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
  searchForBillsBayCustomerName() {
    String search = searchBillsTextController.text;
    if (search.isEmpty) {
      getCustomersBills();
    } else {
      customer_bills_list.value =
          customer_bills_list.where((doc) {
            final data = doc.data();
            final customerName = data["customer_name"].toString().toLowerCase();

            final billId = data["bill_no"].toString().toLowerCase();
            if (customerName.contains(search.toLowerCase()) ||
                billId.contains(search.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          }).toList();
      if (customer_bills_list.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
      update();
    }
  }

  @override
  searchForBillBayCity(String cityName) {
    if (cityName.isEmpty || cityName == "جميع المدن") {
      getCustomersBills();
    } else {
      String userID = services.sharedPreferences.getString(AppShared.userID)!;

      customerBillData.getAllBils(userID).listen((event) {
        customer_bills_list.value = event.docs;
        customer_bills_list.value =
            customer_bills_list.where((doc) {
              final data = doc.data();
              final fileView = data["customer_city"].toLowerCase();
              return fileView.contains(cityName.toLowerCase());
            }).toList();
        if (customer_bills_list.isEmpty) {
          statusreqest = Statusreqest.empty;
        }
        selectedCustomerCity = cityName;
        update();
      });
    }
  }

  @override
  searchByDate(DateTimeRange dateRange) async {
    // String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      selectedDateRange = dateRange;
      getCustomersBills();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  goToDetailsPage(String billId) {
    Get.toNamed(
      AppRoutes.customer_bills_details_page,
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
      await customerBillData.updateBillStatus(userID, billId, billStatus);
      if (billStatus == 'deliveryd' && billModel.payment_type != 'Religion') {
        await addDept(billModel);
        await addBillToDepts(billModel);
      } else {
        deleteDept(billModel.customer_id!, billId);
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
      await customerDeptsData.addDepts(
        billModel!.customer_id!,
        billModel.customer_name!,
        billModel.customer_city!,
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
      await customerDeptsData.addBillToDepts(
        billModel!.bill_no!,
        billModel.bill_id!,
        billModel.customer_id!,
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
  void onInit() async {
    getCustomersBills();
    super.onInit();
  }

  @override
  void deleteDept(String customerId, String billId) async {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      await customerDeptsData.delteBillFromDepts(billId, customerId, userID);
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }
}
