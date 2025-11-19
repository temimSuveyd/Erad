import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:erad/data/data_score/remote/depts/customer_depts_data.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/custom_show_popupMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/function/convertToDropdownItems.dart';
import 'package:erad/core/function/pdf_maker.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/customer/customers_data.dart';
import 'package:erad/data/data_score/remote/customer/customer_bill_data.dart';
import 'package:erad/data/data_score/remote/brands/product_data.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/custom_willPop_dailog.dart';
import 'package:path_provider/path_provider.dart';

abstract class CustomeraddBiilController extends GetxController {
  Future addCustomerBill();
  getCustomerById();
  getAllCustomers();
  setCustomer(String id);
  setDate(DateTime billDate);
  setPaymentType(String paymentType);
  getAllProducts();
  addProduct(String productId);
  getProductById(String productId);
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
  setProductFromSearch(String prodectName);
  addProductListToFirebase(String userID, String billId);
  deleteProduct(int productIndex);
  generateRandomInvoiceId(String username);
  void printPdf();
}

class CustomerBiilAddControllerImp extends CustomeraddBiilController {
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
  final ProductData _productData = ProductData();
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
      String userID = services.sharedPreferences.getString(AppShared.userID)!;
      try {
        bill_id = await customerBillData.addCustomerBill(
          customer_name!,
          customer_city!,
          customer_id!,
          bill_payment_type!,
          userID,
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
    String userID = services.sharedPreferences.getString(AppShared.userID)!;

    try {
      customersData.getCustomerByID(userID, customer_id!).listen((event) {
        customerData = event.data();
        customer_city = customerData!["customer_city"];
        customer_name = customerData!["customer_name"];
        if (customerData!.isEmpty) {
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
  setDate(DateTime billDate) {
    bill_add_date = billDate;
    update();
  }

  @override
  setPaymentType(String paymentType) {
    bill_payment_type = paymentType;
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
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      customersData.getAllCustomers(userID).listen((event) {
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
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    if (bill_id == null) {
      Get.back();
    } else {
      try {
        customerBillData.deleteCustomerBill(userID, bill_id!);
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
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      _productData.getAllproduct(userID).listen((event) {
        all_product_list.value = event.docs;
        if (all_product_list.isEmpty) {
          statusreqest = Statusreqest.empty;
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
  addProduct(String productId) async {
    if (productId.isNotEmpty) {
      await getProductById(productId);
      int numperOfNumper = int.parse(number_of_products_controller.text);
      try {
        bill_prodects_list.add({
          "product_name": product_name!,
          "product_id": productId,
          "product_number": numperOfNumper,

          "total_product_price": numperOfNumper * product_price!,
          "total_product_profits": numperOfNumper * prodect_profits!,

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
  getProductById(String productId) async {
    try {
      String userID = services.sharedPreferences.getString(AppShared.userID)!;
      final productData = await _productData.getBrandsTypeBayId(
        userID,
        productId,
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

      String userID = services.sharedPreferences.getString(AppShared.userID)!;
      try {
        customerBillData.getBillProdects(userID, bill_id!).listen((event) {
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
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    if (!is_saved) {
      statusreqest = Statusreqest.loading;
      update();
      try {
        await addCustomerBill();
        if (bill_id != null && bill_prodects_list.isNotEmpty) {
          is_saved = true;
          generateRandomInvoiceId(customer_name!);
          await addProductListToFirebase(userID, bill_id!);
          totalPriceAccount();
          totalProfits();
          customerBillData.updateCustomerBill(
            userID,
            bill_id!,
            bill_no!,
            total_product_price,
            total_product_profits,
          );
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
        userID,
        bill_id!,
        bill_no!,
        total_product_price,
        total_product_profits,
      );
    }
  }

  @override
  Future<void> addProductListToFirebase(String userID, String billId) async {
    for (var product in bill_prodects_list) {
      String productName = product["product_name"];

      String productId = product["product_id"];
      int productNumber = product["product_number"];

      int productProfits = product["product_profits"];
      int productPrice = product["product_price"];

      int totalProductPrice = product["total_product_price"];
      int totalProductProfits = product["total_product_profits"];

      customerBillData.addProductToBill(
        productName,
        productPrice,
        productId,
        productNumber,
        totalProductPrice,
        totalProductProfits,
        productProfits,
        userID,
        billId,
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
    String company_name =
        services.sharedPreferences.getString(AppShared.company_name)!;
    try {
      pdfBytes = await createInvoice(
        bill_prodects_list,
        "${bill_add_date.day.toString().padLeft(2, '0')}/${bill_add_date.month.toString().padLeft(2, '0')}/${bill_add_date.year}",
        company_name,
        bill_no!,
        total_product_price,
        "بيع",
        customer_name!,
        customer_city!,
      );
      String pdfFileName = "${bill_no}.pdf";
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download", pdfFileName)
        ..click();
      html.Url.revokeObjectUrl(url);
      statusreqest = Statusreqest.success;
      update();
    } on Exception {
      statusreqest = Statusreqest.faliure;
      update();
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
  deleteProduct(int productIndex) {
    bill_prodects_list.removeAt(productIndex);
    update();
  }

  @override
  generateRandomInvoiceId(String username) {
    final random = Random();
    final letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final firstLetter = letters[random.nextInt(letters.length)];
    final secondLetter = letters[random.nextInt(letters.length)];
    final number = random.nextInt(1000).toString().padLeft(3, '0');
    bill_no = '$firstLetter$secondLetter$number';
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

  @override
  void printPdf() async {
    if (!is_saved) {
      await saveBillData();
      createPdf();
      goToPdfViewPage(pdfBytes);
    }
  }
}
