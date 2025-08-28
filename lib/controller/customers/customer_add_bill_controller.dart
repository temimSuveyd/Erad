import 'dart:math';
import 'dart:typed_data';
import 'package:Erad/data/data_score/remote/depts/customer_depts_data.dart';
import 'package:Erad/view/customer/customer_bills_add/widgets/custom_show_popupMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/core/class/handling_data.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/core/constans/routes.dart';
import 'package:Erad/core/constans/sharedPreferences.dart';
import 'package:Erad/core/function/convertToDropdownItems.dart';
import 'package:Erad/core/function/pdf_maker.dart';
import 'package:Erad/core/services/app_services.dart';
import 'package:Erad/data/data_score/remote/customer/customers_data.dart';
import 'package:Erad/data/data_score/remote/customer/customer_bill_data.dart';
import 'package:Erad/data/data_score/remote/brands/product_data.dart';
import 'package:Erad/view/custom_widgets/custom_snackbar.dart';
import 'package:Erad/view/customer/customer_bills_add/widgets/custom_willPop_dailog.dart';

abstract class CustomerAddBiilController extends GetxController {
  addCustomerBill();
  addDept();
  addBillToDepts();
  getCustomerById();
  getAllCustomers();
  setCustomer(String id);
  setDate(DateTime bill_date);
  setPaymentType(String payment_type);
  getAllProducts();
  addProduct(String product_id);
  getProductById(String product_id);
  getBillProdects();
  totalPriceAccount();
  onWillPop();
  deleteBill();
  showDleteBillDialog();
  saveBillData();
  totalProfits();
  goToPdfViewPage(Uint8List pdfBytes);
  createPdf();
  searchForProduct();
  hiden_search_Menu();
  setProductFromSearch(String prodect_name);
  addProductListToFirebase(String user_email, String bill_id);
  deleteProduct(int product_index);
  generateRandomInvoiceId(String username);
}

class CustomerBiilAddControllerImp extends CustomerAddBiilController {
  Statusreqest statusreqest = Statusreqest.notAdded;
  Services services = Get.find();
  // bill data
  bool is_saved = false;
  CustomerBillData customerBillData = CustomerBillData();
  CustomerDeptsData customerDeptsData = CustomerDeptsData();
  DateTime bill_add_date = DateTime.now();
  String? bill_id;
  String? bill_no;
  // customer data
  CustomersData customersData = CustomersData();
  Map<String, dynamic>? customerData;
  var customersList = [].obs;
  List<DropdownMenuItem<String>>? customers_list_dropdownItrm;
  String? customer_name;
  String? customer_city;
  String? customer_id;
  String? bill_payment_type;
  // product data
  ProductData _productData = ProductData();
  var all_product_list = [].obs;
  var bill_prodects_list = [].obs;

  late Uint8List pdfBytes;

  TextEditingController number_of_products_controller = TextEditingController();
  TextEditingController serach_for_product_controller = TextEditingController();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  GlobalKey textFieldKey = GlobalKey();
  String? product_name;
  String? product_id;
  int? product_price;
  int? product_number;
  int? prodect_profits;
  double total_product_price = 0;
  double total_product_profits = 0;
  bool show_search_popupMenu = false;
  bool isSecondEnabled = false;

  // --------------------------------------------------------bill data
  @override
  addCustomerBill() async {
    if (customer_name == null ||
        customer_city == null ||
        customer_id == null ||
        bill_payment_type == null) {
      custom_snackBar();
      statusreqest = Statusreqest.success;
      update();
    } else {
      statusreqest = Statusreqest.loading;
      update();
      String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      try {
        bill_id = await customerBillData.addCustomerBill(
          customer_name!,
          customer_city!,
          customer_id!,
          bill_payment_type!,
          user_email,
          bill_add_date,
        );

        statusreqest = Statusreqest.success;
        update();
      } catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    }
  }

  SnackbarController custom_success_snackbar() {
    return Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.green,
        title: "نجاح",
        duration: Duration(seconds: 2),
        message: "تم الانتهاء من العملية بنجاح",
      ),
    );
  }

  @override
  getCustomerById() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;

    try {
      customersData.getCustomerByID(user_email, customer_id!).listen((event) {
        customerData = event.data();
        customer_city = customerData!["customer_city"];
        customer_name = customerData!["customer_name"];
        if (customerData!.isEmpty) {
          statusreqest = Statusreqest.noData;
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
  setDate(DateTime bill_date) {
    bill_add_date = bill_date;
    update();
  }

  @override
  setPaymentType(String payment_type) {
    bill_payment_type = payment_type;
    update();
  }

  @override
  setCustomer(String id) {
    customer_id = id;
    update();
    getCustomerById();
  }

  @override
  getAllCustomers() {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      customersData.getAllCustomers(user_email).listen((event) {
        customersList.value = event.docs;
        customers_list_dropdownItrm = convertToDropdownItems(
          event.docs,
          'customer_name',
        );
        if (customersList.isEmpty) {
          statusreqest = Statusreqest.faliure;
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
  deleteBill() {
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    if (bill_id == null) {
      Get.back();
    } else {
      try {
        customerBillData.deleteCustomerBill(user_email, bill_id!);
        Get.back();
      } catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    }
  }

  // -------------------------------------------------------------------------------product data

  @override
  getAllProducts() {
    statusreqest = Statusreqest.loading;
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      _productData.getAllproduct(user_email).listen((event) {
        all_product_list.value = event.docs;
        if (all_product_list.isEmpty) {
          statusreqest = Statusreqest.noData;
        } else {
          statusreqest = Statusreqest.success;
          Future.delayed(Duration(milliseconds: 100), () {
            FocusScope.of(Get.context!).requestFocus(focusNode1);
          });
        }
        update();
      });
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  searchForProduct() {
    if (!show_search_popupMenu) {
      show_search_popupMenu = true;
      update();
    }
    String search = serach_for_product_controller.text;
    if (search.isEmpty) {
      getAllProducts();
    } else {
      all_product_list.value =
          all_product_list.where((doc) {
            final data = doc.data();
            final fileView = data["product_name"].toString().toLowerCase();
            return fileView.contains(search.toLowerCase());
          }).toList();
    }
    update();
  }

  @override
  addProduct(String product_id) async {
    if (product_id.isNotEmpty) {
      await getProductById(product_id);
      int numper_of_numper = int.parse(number_of_products_controller.text);
      try {
        bill_prodects_list.add({
          "product_name": product_name!,
          "product_id": product_id,
          "product_number": numper_of_numper,

          "total_product_price": numper_of_numper * product_price!,
          "total_product_profits": numper_of_numper * prodect_profits!,

          "product_price": product_price!,
          "product_profits": prodect_profits!,
        });
        number_of_products_controller.clear();
        serach_for_product_controller.clear();
        Future.delayed(Duration(milliseconds: 100), () {
          FocusScope.of(Get.context!).requestFocus(focusNode1);
        });
        update();
      } catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    } else {
      custom_snackBar();
    }
  }

  @override
  getProductById(String product_id) async {
    try {
      String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      final productData = await _productData.getBrandsTypeBayId(
        user_email,
        product_id,
      );
      product_price = productData["product_sales_price"];
      prodect_profits = productData["product_profits"];
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  getBillProdects() {
    if (bill_id == null) {
    } else {
      statusreqest = Statusreqest.loading;
      update();

      String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      try {
        customerBillData.getBillProdects(user_email, bill_id!).listen((event) {
          bill_prodects_list.value = event.docs;
          if (bill_prodects_list.isEmpty) {
            statusreqest = Statusreqest.notAdded;
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
  }

  @override
  totalPriceAccount() {
    total_product_price = 0;

    for (var responce in bill_prodects_list) {
      int price = responce["total_product_price"];
      total_product_price += price;
    }
  }

  @override
  totalProfits() {
    total_product_profits = 0;
    for (var responce in bill_prodects_list) {
      int profits = responce["total_product_profits"];
      total_product_profits = total_product_profits + profits;
    }
  }

  @override
  Future<bool> onWillPop() async {
    custom_willPop_dialog(is_saved, () {
      if (bill_id != null) {
        saveBillData();
      } else {
        custom_snackBar();
        Get.back();
      }
    });

    return is_saved;
  }

  @override
  showDleteBillDialog() {
    Get.defaultDialog(
      onConfirm: () {
        deleteBill();
        Get.back();
      },
      onCancel: () {},
      textConfirm: "حذف",
      textCancel: "عدم الحذف",
      buttonColor: AppColors.primary,
      backgroundColor: AppColors.backgroundColor,
      middleText: "هل أنت متأكد من أنك تريد حذف هذه الفاتورة",
      title: "حذف الفاتورة",
    );
  }

  @override
  saveBillData() async {
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;

    if (!is_saved) {
      statusreqest = Statusreqest.loading;
      update();

      try {
        await addCustomerBill();
        if (bill_id != null && bill_prodects_list.isNotEmpty) {
          is_saved = true;
          generateRandomInvoiceId(customer_name!);
          await addProductListToFirebase(user_email, bill_id!);
          totalPriceAccount();
          totalProfits();
          customerBillData.updateCustomerBill(
            user_email,
            bill_id!,
            bill_no!,
            total_product_price,
            total_product_profits,
          );
          if (bill_payment_type == "Religion") {
            await addDept();
            addBillToDepts();
          }
          Get.back();
          custom_success_snackbar();
        } else {
          custom_snackBar();
          statusreqest = Statusreqest.success;
          update();
        }
      } catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    } else {
      totalPriceAccount();
      totalProfits();
      customerBillData.updateCustomerBill(
        user_email,
        bill_id!,
        bill_no!,
        total_product_price,
        total_product_profits,
      );
      Get.back();
    }
  }

  @override
  Future<void> addProductListToFirebase(
    String user_email,
    String bill_id,
  ) async {
    for (var product in bill_prodects_list) {
      String product_name = product["product_name"];

      String product_id = product["product_id"];
      int product_number = product["product_number"];

      int product_profits = product["product_profits"];
      int product_price = product["product_price"];

      int total_product_price = product["total_product_price"];
      int total_product_profits = product["total_product_profits"];

      customerBillData.addProductToBill(
        product_name,
        product_price,
        product_id,
        product_number,
        total_product_price,
        total_product_profits,
        product_profits,
        user_email,
        bill_id,
      );
    }
  }

  @override
  goToPdfViewPage(Uint8List pdfBytes) {
    Get.toNamed(AppRoutes.pdf_view, arguments: {"pdfBytes": pdfBytes});
  }

  @override
  createPdf() async {
    statusreqest = Statusreqest.loading;
    update();
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    await addCustomerBill();
    if (bill_id != null) {
      try {
        if (!is_saved) {
          totalPriceAccount();
          totalProfits();
          await addProductListToFirebase(user_email, bill_id!);
          is_saved = true;
          update();
        } else {
          total_product_price = 0;
          total_product_profits = 0;
          totalPriceAccount();
          totalProfits();
        }
        generateRandomInvoiceId(customer_name!);
        pdfBytes = await createInvoice(
          bill_prodects_list,
          "${bill_add_date.day.toString().padLeft(2, '0')}/${bill_add_date.month.toString().padLeft(2, '0')}/${bill_add_date.year}",
          "سويد للتجارة",
          bill_no!,
          total_product_price,
          "بيع",
          customer_name!,
          customer_city!,
          05395443779,
        );
        goToPdfViewPage(pdfBytes);
        statusreqest = Statusreqest.success;
        update();
      } on Exception catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    } else {
      custom_snackBar();
    }
  }

  @override
  // ignore: non_constant_identifier_names
  hiden_search_Menu() {
    if (show_search_popupMenu) {
      show_search_popupMenu = false;
      update();
    }
  }

  @override
  setProductFromSearch(String _product_name) {
    if (all_product_list.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 100), () {
        FocusScope.of(Get.context!).requestFocus(focusNode2);
      });
      product_name = _product_name;
      serach_for_product_controller.text = product_name!;
    }
    show_search_popupMenu = false;
    update();
  }

  @override
  deleteProduct(int product_index) {
    bill_prodects_list.removeAt(product_index);
    update();
  }

  @override
  generateRandomInvoiceId(String username) {
    generateRandomInvoiceId(String username) {
      final now = DateTime.now();
      final initials = username.substring(0, 2).toUpperCase();
      final date =
          '${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
      final random = Random();
      final randomNumber = random.nextInt(100000); // 0 - 99999
      final numberStr = randomNumber.toString().padLeft(5, '0');
      return '$initials-$date-$numberStr';
    }

    bill_no = generateRandomInvoiceId(username);
  }

  @override
  addDept() async {
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      if (customer_name != null && customer_id != null) {
        await customerDeptsData.addDepts(
          customer_id!,
          customer_name!,
          customer_city!,
          user_email,
          total_product_price,
          bill_add_date,
        );
      } else {
        statusreqest = Statusreqest.faliure;
        update();
      }
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  addBillToDepts() async {
    String user_email =
        services.sharedPreferences.getString(AppShared.user_email)!;
    try {
      if (customer_name != null && customer_id != null) {
        await customerDeptsData.addBillToDepts(
          bill_no!,
          bill_id!,
          customer_id!,
          bill_payment_type!,
          user_email,
          total_product_price,
          bill_add_date,
        );
      } else {
        statusreqest = Statusreqest.faliure;
        update();
      }
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void onInit() {
    getAllCustomers();
    getBillProdects();
    getAllProducts();
    super.onInit();
  }

  @override
  void onClose() {
    if (!is_saved) {
      deleteBill();
    }
    super.onClose();
  }
}
