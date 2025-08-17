import 'dart:developer';
import 'dart:typed_data';

import 'package:Erad/core/constans/routes.dart';
import 'package:Erad/core/function/pdf_maker.dart';
import 'package:Erad/data/data_score/remote/depts/customer_depts.dart';
import 'package:Erad/data/model/customer_bill_details/bill_details_product_model.dart';
import 'package:Erad/view/custom_widgets/custom_textfield_erroe_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/core/class/handling_data.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/core/constans/sharedPreferences.dart';
import 'package:Erad/core/services/app_services.dart';
import 'package:Erad/data/data_score/remote/customer/customer_bill_data.dart';
import 'package:Erad/data/data_score/remote/brands/product_data.dart';
import 'package:Erad/data/model/customer_bills_view/bill_model.dart';
import 'package:Erad/view/custom_widgets/custom_search_text_field.dart';

abstract class CustomerBillDetailsController extends GetxController {
  deleteBillFromDepts();
  updateBillInDepts(double total_price);
  getBillDetails();
  getBillProducts();
  initData();
  editProductData(String productId);
  getProductById(String product_id);
  // ignore: non_constant_identifier_names
  show_edit_prodcut_dialog(
    TextEditingController controller,
    Function() onConfirm,
  );
  updateProductData(int product_number, String product_id);
  // ignore: non_constant_identifier_names
  show_delete_product_dialog(String productId);
  // ignore: non_constant_identifier_names
  delete_product(String productId);
  totalPriceAccount();
  totalProfits();
  updateBillData();
  // ignore: non_constant_identifier_names
  show_discount_dialog(Function() onConfirm);
  // ignore: non_constant_identifier_names
  update_bill_brice(double discountAmount);
  // ignore: non_constant_identifier_names
  discount_on_bill();
  deleteBill();
  // ignore: non_constant_identifier_names
  show_delete_bill_dialog();
  goToPdfViewPage(Uint8List pdfBytes);
  createPdf();

  addDiscount(double discount);
}

class CustomerBillDetailsControllerImp extends CustomerBillDetailsController {
  Statusreqest statusreqest = Statusreqest.loading;
  Services services = Get.find();
  CustomerBillData customerBillData = CustomerBillData();
  CustomerDeptsData customerDeptsData = CustomerDeptsData();
  var productList = [].obs;
  late Uint8List pdfBytes;
  BillModel? billModel;
  String? user_email;
  String? bill_id;
  double? total_price;
  double? total_earn;
  double discount_amount = 0.0;

  // products data
  int? product_numper;
  int? product_price;
  int? total_product_price;
  ProductData productData = ProductData();
  BillDetailsProductsModel? billProductsModel;
  TextEditingController product_number_text_controller =
      TextEditingController();
  TextEditingController discount_controller = TextEditingController();

  @override
  Future getBillDetails() async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await customerBillData.getBillById(user_email!, bill_id!).then((value) {
        billModel = BillModel.formatJson(value);
        total_earn = billModel!.total_earn;
        total_price = billModel!.total_price;
        discount_amount = billModel!.discount_amount!;
      });
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  getBillProducts() {
    try {
      statusreqest = Statusreqest.loading;
      update();
      customerBillData.getBillProdects(user_email!, bill_id!).listen((event) {
        productList.value = event.docs;
        if (productList.isEmpty) {
          statusreqest = Statusreqest.noData;
        } else {
          statusreqest = Statusreqest.success;
        }
        update();
      });
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  editProductData(String productId) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await getProductById(productId);
      product_number_text_controller.text = product_numper!.toString();
      show_edit_prodcut_dialog(product_number_text_controller, () async {
        final int number = int.parse(product_number_text_controller.text);
        await updateProductData(number, productId);
        await updateBillData();
        Get.back();
      });
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  totalPriceAccount() {
    total_price = 0;
    for (var responce in productList) {
      int price = responce["total_product_price"];
      total_price = total_price! + price - discount_amount;
    }
  }

  @override
  totalProfits() {
    total_earn = 0;
    for (var responce in productList) {
      int earn = responce["prodect_profits"];
      int numper = responce["product_number"];
      total_earn = total_earn! + earn * numper - discount_amount;
    }
  }

  @override
  Future getProductById(String product_id) async {
    try {
      await customerBillData
          .getBillProdectBayId(user_email!, bill_id!, product_id)
          .then((value) {
            product_numper = value["product_number"];
            product_price = value["product_price"];
          });
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  // ignore: non_constant_identifier_names
  show_edit_prodcut_dialog(
    TextEditingController controller,
    Function() onConfirm,
  ) {
    Get.defaultDialog(
      backgroundColor: AppColors.backgroundColor,
      onCancel: () {},
      buttonColor: AppColors.primary,
      onConfirm: () => onConfirm(),
      middleText: "",
      title: "غير عدد المنتجات",
      textConfirm: "تغير",
      textCancel: "اخرج",
      actions: [
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Custom_textfield(
                hintText: "",
                suffixIcon: Icons.edit,
                validator: (p0) {},
                controller: controller,
                onChanged: (p0) {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Future updateProductData(int product_number, String product_id) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await customerBillData.updateProductData(
        product_id,
        product_number,
        product_price! * product_number,
        user_email!,
        bill_id!,
      );

      statusreqest = Statusreqest.success;
    } on Exception catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  show_delete_product_dialog(String product_id) {
    Get.defaultDialog(
      backgroundColor: AppColors.backgroundColor,
      onCancel: () {},
      buttonColor: AppColors.primary,
      onConfirm: () {
        delete_product(product_id);
        Get.back();
      },
      middleText: "",
      title: "حذف المنتج",
      textConfirm: "حذف",
      textCancel: "ألغى",
    );
  }

  @override
  Future delete_product(String product_id) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await customerBillData.deleteProduct(bill_id!, product_id, user_email!);
      await updateBillData();
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  Future updateBillData() async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      totalPriceAccount();
      totalProfits();
      await customerBillData.updateCustomerBill(
        user_email!,
        bill_id!,
        billModel!.bill_no!,
        total_price!,
        total_earn!,
      );
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }

    update();
  }

  @override
  initData() async {
    user_email = services.sharedPreferences.getString(AppShared.user_email);
    bill_id = Get.arguments["bill_id"];
  }

  @override
  show_discount_dialog(Function() onConfirm) {
    Get.defaultDialog(
      onCancel: () {},
      onConfirm: () {
        onConfirm();
      },
      backgroundColor: AppColors.backgroundColor,
      confirmTextColor: AppColors.backgroundColor,
      cancelTextColor: AppColors.primary,
      buttonColor: AppColors.primary,
      textCancel: "يلغي",
      textConfirm: "خصم",
      middleText: "مبلغ الخصم $discount_amount",
      title: "خصم على الفاتورة",
      actions: [
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Custom_textfield(
                hintText: "تخفيض",
                suffixIcon: Icons.discount,
                validator: (p0) {},
                controller: discount_controller,
                onChanged: (p0) {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  update_bill_brice(double discount) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await addDiscount(discount);
      total_earn = total_earn! - discount;
      total_price = total_price! - discount;
      await customerBillData.update_total_price(
        user_email!,
        bill_id!,
        total_price!,
        total_earn!,
      );
      await updateBillInDepts(total_price! - discount * 2);
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  discount_on_bill() {
    try {
      show_discount_dialog(() async {
        if (discount_controller.text.isEmpty ||
            double.tryParse(discount_controller.text) == null) {
          discount_controller.clear();
          Get.showSnackbar(
            GetSnackBar(
              backgroundColor: AppColors.red,
              animationDuration: Duration(milliseconds: 400),
              duration: Duration(seconds: 3),
              title: "خطأ",
              message: "لقد أدخلت قيمة خاطئة",
              snackStyle: SnackStyle.GROUNDED,
              dismissDirection: DismissDirection.endToStart,
              snackPosition: SnackPosition.TOP,
            ),
          );
          update();
        } else {
          if (total_price! - double.parse(discount_controller.text) < 0) {
            discount_controller.clear();
            Get.showSnackbar(
              GetSnackBar(
                backgroundColor: AppColors.primary,
                animationDuration: Duration(milliseconds: 400),
                duration: Duration(seconds: 3),
                title: "خطأ",
                message: "لا يمكن جعل إجمالي الفاتورة أقل من صفر",
                snackStyle: SnackStyle.GROUNDED,
                dismissDirection: DismissDirection.endToStart,
                snackPosition: SnackPosition.TOP,
              ),
            );
          } else {
            final double discount =
                double.tryParse(discount_controller.text) ?? 0;
            statusreqest = Statusreqest.loading;
            update();
            await update_bill_brice(discount);
            Get.back();
            discount_controller.clear();
            statusreqest = Statusreqest.success;

            update();
          }
        }
      });
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
  }

  @override
  Future deleteBill() async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await customerBillData.deleteCustomerBill(user_email!, bill_id!);
      deleteBillFromDepts();
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }

    update();
  }

  @override
  show_delete_bill_dialog() {
    Get.defaultDialog(
      backgroundColor: AppColors.backgroundColor,
      onCancel: () {},
      buttonColor: AppColors.primary,
      onConfirm: () {
        deleteBill();
        Get.close(0);
        Get.back();
      },
      middleText: "هل أنت متأكد أنك تريد حذف هذا الفاتورة",
      title: "حذف الفاتورة",
      textConfirm: "حذف",
      textCancel: "ألغى",
    );
  }

  @override
  goToPdfViewPage(Uint8List pdfBytes) {
    Get.toNamed(AppRoutes.pdf_view, arguments: {"pdfBytes": pdfBytes});
  }

  @override
  createPdf() async {
    statusreqest = Statusreqest.loading;
    update();

    try {
      pdfBytes = await createInvoice(
        productList.toList(),
        "${billModel!.bill_date!.day.toString().padLeft(2, '0')}/${billModel!.bill_date!.month.toString().padLeft(2, '0')}/${billModel!.bill_date!.year}",
        "سويد للتجارة",
        billModel!.bill_no!,
        billModel!.total_price!,
        "بيع",
        billModel!.customer_name!,
        billModel!.customer_city!,
        05395443779,
      );
      statusreqest = Statusreqest.success;
      update();
      goToPdfViewPage(pdfBytes);
    } on Exception catch (e) {
      statusreqest = Statusreqest.success;
      update();
    }
    update();
  }

  @override
  updateBillInDepts(double total_price) {
    try {
      final String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      final String customer_id = billModel!.customer_id!;
      final String bill_id = billModel!.bill_id!;

      customerDeptsData.updateTotalPriceInBill(
        bill_id,
        customer_id,
        user_email,
        total_price,
      );
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  deleteBillFromDepts() {
    try {
      final String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      final String customer_id = billModel!.customer_id!;
      final String bill_id = billModel!.bill_id!;

      customerDeptsData.delteBillFromDepts(bill_id, customer_id, user_email);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  addDiscount(double discount) {
    try {
      final String user_email =
          services.sharedPreferences.getString(AppShared.user_email)!;
      customerBillData.addDiscount(bill_id!, user_email, discount);
      discount_amount = discount + discount_amount;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  void onInit() async {
    initData();
    await getBillDetails();
    getBillProducts();
    super.onInit();
  }
}
