import 'dart:typed_data';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/function/pdf_maker.dart';
import 'package:erad/data/data_score/remote/depts/supplier_depts_data.dart';
import 'package:erad/data/data_score/remote/supplier/supplier_bill_data.dart';
import 'package:erad/data/model/customer_bill_details/bill_details_product_model.dart';
import 'package:erad/data/model/supplier_bill_view/bill_model.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:erad/view/custom_widgets/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/brands/product_data.dart';

import 'package:erad/view/custom_widgets/custom_text_field.dart';

abstract class SuppliersBillDetailsController extends GetxController {
  deleteBillFromDepts();
  updateBillInDepts(double totalPrice);
  getBillDetails();
  getBillProducts();
  initData();
  editProductData(String productId);
  getProductById(String productId);
  // ignore: non_constant_identifier_names
  show_edit_prodcut_dialog(
    TextEditingController controller,
    Function() onConfirm,
  );
  updateProductData(int productNumber, String productId);
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
  update_bill_total_brice(double discountAmount);
  // ignore: non_constant_identifier_names
  discount_on_bill();
  deleteBill();
  // ignore: non_constant_identifier_names
  show_delete_bill_dialog();
  goToPdfViewPage(Uint8List pdfBytes);
  createPdf();
  addDiscount(double discount);
  updatePaymentType(String billStatus);
  showEditPaymentTypeDailog();
  addDept();
  addBillToDepts();
}

class SuppliersBillDetailsControllerImp extends SuppliersBillDetailsController {
  Statusreqest statusreqest = Statusreqest.loading;
  Services services = Get.find();
  SupplierBillData supplierBillData = SupplierBillData();
  SupplierDeptsData customerDeptsData = SupplierDeptsData();
  var productList = [].obs;
  late Uint8List pdfBytes;
  BillModel? billModel;
  String? userID;
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
      await supplierBillData.getBillById(userID!, bill_id!).then((value) {
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
      supplierBillData.getBillProdects(userID!, bill_id!).listen((event) {
        productList.value = event.docs;
        if (productList.isEmpty) {
          statusreqest = Statusreqest.empty;
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
      total_price = total_price! + price;
    }
    total_price = total_price! - discount_amount;
  }

  @override
  totalProfits() {
    total_earn = 0;
    for (var responce in productList) {
      int earn = responce["prodect_profits"];
      int numper = responce["product_number"];
      total_earn = total_earn! + earn * numper;
    }
    total_earn = total_earn! - discount_amount;
  }

  @override
  Future getProductById(String productId) async {
    try {
      await supplierBillData
          .getBillProdectBayId(userID!, bill_id!, productId)
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
                validator: (p0) {
                  return null;
                },
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
  Future updateProductData(int productNumber, String productId) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await supplierBillData.updateProductData(
        productId,
        productNumber,
        product_price! * productNumber,
        userID!,
        bill_id!,
      );

      statusreqest = Statusreqest.success;
    } on Exception {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  show_delete_product_dialog(String productId) {
    Get.defaultDialog(
      backgroundColor: AppColors.backgroundColor,
      onCancel: () {},
      buttonColor: AppColors.primary,
      onConfirm: () {
        delete_product(productId);
        Get.back();
      },
      middleText: "",
      title: "حذف المنتج",
      textConfirm: "حذف",
      textCancel: "ألغى",
    );
  }

  @override
  Future delete_product(String productId) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await supplierBillData.deleteProduct(bill_id!, productId, userID!);
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
      await supplierBillData.updateSupplierBill(
        userID!,
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
    userID = services.sharedPreferences.getString(AppShared.userID);
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
                validator: (p0) {
                  return null;
                },
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
  update_bill_total_brice(double discount) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await addDiscount(discount);
      total_earn = total_earn! - discount;
      total_price = total_price! - discount;
      await supplierBillData.update_total_price(
        userID!,
        bill_id!,
        total_price!,
        total_earn!,
      );
      await updateBillInDepts(total_price!);
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

          custom_snackBar(Colors.red, "خطأ", "لقد أدخلت قيمة خاطئة");

          update();
        } else {
          if (total_price! - double.parse(discount_controller.text) < 0) {
            discount_controller.clear();

            custom_snackBar(Colors.red, "خطأ", "! قيمة أقل من صفر");
          } else {
            final double discount =
                double.tryParse(discount_controller.text) ?? 0;
            statusreqest = Statusreqest.loading;
            update();
            await update_bill_total_brice(discount);
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
      await supplierBillData.deleteSupplierBill(userID!, bill_id!);

      await deleteBillFromDepts();
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
      // pdfBytes = await createInvoice(
      //   productList.toList(),
      //   "${billModel!.bill_date!.day.toString().padLeft(2, '0')}/${billModel!.bill_date!.month.toString().padLeft(2, '0')}/${billModel!.bill_date!.year}",
      //   "سويد للتجارة",
      //   billModel!.bill_no!,
      //   billModel!.total_price!,
      //   "بيع",
      //   billModel!.supplier_name!,
      //   billModel!.supplier_id!,
      //   05395443779,
      // );
      statusreqest = Statusreqest.success;
      update();
      goToPdfViewPage(pdfBytes);
    } on Exception {
      statusreqest = Statusreqest.success;
      update();
    }
    update();
  }

  @override
  updateBillInDepts(double totalPrice) {
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      final String customerId = billModel!.supplier_id!;
      final String billId = billModel!.bill_id!;
      customerDeptsData.updateTotalPriceInBill(
        billId,
        customerId,
        userID,
        totalPrice,
      );
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  deleteBillFromDepts() {
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      final String customerId = billModel!.supplier_id!;
      final String billId = billModel!.bill_id!;
      customerDeptsData.delteBillFromDepts(billId, customerId, userID);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  addDiscount(double discount) {
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      supplierBillData.addDiscount(bill_id!, userID, discount);
      discount_amount = discount + discount_amount;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  addBillToDepts() async {
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      await customerDeptsData.addBillToDepts(
        billModel!.bill_no!,
        bill_id!,
        billModel!.supplier_id!,
        billModel!.payment_type!,
        userID,
        billModel!.total_price!,
        billModel!.bill_date!,
      );

      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  addDept() async {
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      await customerDeptsData.addDepts(
        billModel!.supplier_id!,
        billModel!.supplier_name!,
        billModel!.supplier_city!,
        userID,
        billModel!.total_price!,
        billModel!.bill_date!,
      );
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  updatePaymentType(String paymentType) {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      supplierBillData.updatePaymentType(userID, bill_id!, paymentType);
      if (paymentType != "monetary") {
        addDept();
        addBillToDepts();
      } else {
        deleteBillFromDepts();
      }
      billModel!.payment_type = paymentType;
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  showEditPaymentTypeDailog() {
    Get.defaultDialog(
      title: "تغيير طريقة الدفع",
      backgroundColor: AppColors.backgroundColor,
      content: Row(
        spacing: 20,
        children: [
          Custom_button(
            icon: Icons.attach_money_rounded,
            title: "نقدي",
            onPressed: () {
              updatePaymentType("monetary");
              Get.back();
            },
            color: AppColors.primary,
          ),
          Custom_button(
            icon: Icons.money_off_csred_outlined,
            title: "دَين",
            onPressed: () {
              updatePaymentType("Religion");
              Get.back();
            },
            color: AppColors.red,
          ),
        ],
      ),
      textCancel: "إلغاء",
      onCancel: () {},
    );
  }

  @override
  void onInit() async {
    initData();
    await getBillDetails();
    getBillProducts();
    super.onInit();
  }
}
