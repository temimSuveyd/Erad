import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/depts/customer_depts_data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class CustomerDeptsViewController extends GetxController {
  void searchForBillsBayCustomerName();
  void searchForBillBayCity(String cityName);
  void getDepts();
  void goTODetailsPage(String deptId);
}

class CustomerDeptsViewControllerImp extends CustomerDeptsViewController {
  final CustomerDeptsData _customerDeptsData = CustomerDeptsData();
  final Services services = Get.find();
  var customersDeptsList = [].obs;
  String selectedCustomerCity = "حدد المدينة";
  Statusreqest statusreqest = Statusreqest.success;
  final TextEditingController searchDeptsTextController =
      TextEditingController();

  @override
  getDepts() {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      _customerDeptsData.getAllDepts(userID).listen((event) {
        customersDeptsList.value = event;

        // Her borç için toplam tutarı hesapla ve güncelle
        _updateDebtTotals();

        if (customersDeptsList.isEmpty) {
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

  // Borç toplamlarını hesapla ve güncelle
  void _updateDebtTotals() async {
    final String userID =
        services.sharedPreferences.getString(AppShared.userID)!;

    for (var debt in customersDeptsList) {
      try {
        // Bu borç için tüm faturaları al
        final billsStream = _customerDeptsData.getBillById(
          userID,
          debt['customer_id'],
        );
        final paymentsStream = _customerDeptsData.getAllPayments(
          userID,
          debt['customer_id'],
        );

        // Stream'leri dinle ve toplam hesapla
        billsStream.listen((bills) {
          paymentsStream.listen((payments) {
            double totalBills = 0.0;
            double totalPayments = 0.0;

            for (var bill in bills) {
              totalBills += (bill['total_price'] as num).toDouble();
            }

            for (var payment in payments) {
              totalPayments += (payment['total_price'] as num).toDouble();
            }

            double remainingDebt = totalBills - totalPayments;

            // Borç tablosunu güncelle
            _customerDeptsData.updateTotalDept(
              debt['customer_id'],
              userID,
              remainingDebt,
            );
          });
        });
      } catch (e) {
        print('Error updating debt total for ${debt['customer_id']}: $e');
      }
    }
  }

  @override
  searchForBillsBayCustomerName() {
    String search = searchDeptsTextController.text;
    if (search.isEmpty) {
      getDepts();
    } else {
      customersDeptsList.value =
          customersDeptsList.where((data) {
            final customerName = data["customer_name"].toString().toLowerCase();
            final billId = data["id"].toString().toLowerCase();
            if (customerName.contains(search.toLowerCase()) ||
                billId.contains(search.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          }).toList();
      if (customersDeptsList.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
      update();
    }
  }

  @override
  searchForBillBayCity(String cityName) {
    final String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    if (cityName.isEmpty || cityName == "جميع المدن") {
      getDepts();
    } else {
      _customerDeptsData.getAllDepts(userID).listen((event) {
        customersDeptsList.value = event;
        customersDeptsList.value =
            customersDeptsList.where((data) {
              final fileView = data["customer_city"].toLowerCase();
              return fileView.contains(cityName.toLowerCase());
            }).toList();
        if (customersDeptsList.isEmpty) {
          statusreqest = Statusreqest.empty;
        }
        selectedCustomerCity = cityName;
        update();
      });
    }
  }

  @override
  goTODetailsPage(String deptId) {
    Get.toNamed(
      AppRoutes.customer_debt_details_page,
      arguments: {"dept_id": deptId},
    );
  }

  @override
  void onInit() {
    getDepts();
    super.onInit();
  }
}
