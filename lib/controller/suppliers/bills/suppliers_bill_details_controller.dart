import 'dart:typed_data';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/function/pdf_maker.dart';
import 'package:erad/core/function/file_saver.dart';
import 'package:erad/data/data_score/remote/depts/supplier_depts_data.dart';
import 'package:erad/data/data_score/remote/supplier/supplier_bill_data.dart';
import 'package:erad/data/model/customer_bill_details/bill_details_product_model.dart';
// import 'package:erad/data/model/supplier_bill_details/bill_details_product_model.dart';
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
  deleteBillFromSupplierDepts();
  updateBillInSupplierDepts(double totalPrice);
  getSupplierBillDetails();
  getSupplierBillProducts();
  initSupplierBillData();
  editSupplierProductData(String productId);
  getSupplierProductById(String productId);
  showEditSupplierProductDialog(
    TextEditingController controller,
    Function() onConfirm,
  );
  updateSupplierProductData(int productNumber, String productId);
  showDeleteSupplierProductDialog(String productId);
  deleteSupplierProduct(String productId);
  totalSupplierPriceAccount();
  totalSupplierProfits();
  updateSupplierBillData();
  showSupplierDiscountDialog(Function() onConfirm);
  updateSupplierBillTotalPrice(double discountAmount);
  discountOnSupplierBill();
  deleteSupplierBill();
  showDeleteSupplierBillDialog();
  goToSupplierPdfViewPage(Uint8List pdfBytes);
  createSupplierBillPdf();
  addSupplierDiscount(double discount);
  updateSupplierPaymentType(String billStatus);
  showEditSupplierPaymentTypeDialog();
  addSupplierDept();
  addSupplierBillToDepts();
}

class SuppliersBillDetailsControllerImp extends SuppliersBillDetailsController {
  Statusreqest statusreqest = Statusreqest.loading;
  Services services = Get.find();
  SupplierBillData supplierBillData = SupplierBillData();
  SupplierDeptsData supplierDeptsData = SupplierDeptsData();
  var supplierProductList = [].obs;
  late Uint8List pdfBytes;
  BillModel? supplierBillModel;
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
  Future getSupplierBillDetails() async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await supplierBillData.getBillById(userID!, bill_id!).then((value) {
        supplierBillModel = BillModel.formatJson(value);
        total_earn = supplierBillModel!.total_earn;
        total_price = supplierBillModel!.total_price;
        discount_amount = supplierBillModel!.discount_amount ?? 0.0;
      });
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  getSupplierBillProducts() {
    try {
      statusreqest = Statusreqest.loading;
      update();
      supplierBillData.getBillProdects(userID!, bill_id!).listen((event) {
        supplierProductList.value = event.docs;
        if (supplierProductList.isEmpty) {
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
  editSupplierProductData(String productId) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await getSupplierProductById(productId);
      product_number_text_controller.text = product_numper!.toString();
      showEditSupplierProductDialog(product_number_text_controller, () async {
        final int number = int.parse(product_number_text_controller.text);
        await updateSupplierProductData(number, productId);
        await updateSupplierBillData();
        Get.back();
      });
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  totalSupplierPriceAccount() {
    total_price = 0;
    for (var responce in supplierProductList) {
      int price = responce["total_product_price"];
      total_price = total_price! + price;
    }
    total_price = total_price! - discount_amount;
  }

  @override
  totalSupplierProfits() {
    total_earn = 0;
    for (var responce in supplierProductList) {
      int earn = responce["prodect_profits"];
      int numper = responce["product_number"];
      total_earn = total_earn! + earn * numper;
    }
    total_earn = total_earn! - discount_amount;
  }

  @override
  Future getSupplierProductById(String productId) async {
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
  showEditSupplierProductDialog(
    TextEditingController controller,
    Function() onConfirm,
  ) {
    Get.defaultDialog(
      backgroundColor: AppColors.background,
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
              CustomTextField(
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
  Future updateSupplierProductData(int productNumber, String productId) async {
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
  showDeleteSupplierProductDialog(String productId) {
    Get.defaultDialog(
      backgroundColor: AppColors.background,
      onCancel: () {},
      buttonColor: AppColors.primary,
      onConfirm: () {
        deleteSupplierProduct(productId);
        Get.back();
      },
      middleText: "",
      title: "حذف المنتج",
      textConfirm: "حذف",
      textCancel: "ألغى",
    );
  }

  @override
  Future deleteSupplierProduct(String productId) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await supplierBillData.deleteProduct(bill_id!, productId, userID!);
      await updateSupplierBillData();
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  Future updateSupplierBillData() async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      totalSupplierPriceAccount();
      totalSupplierProfits();
      await supplierBillData.updateSupplierBill(
        userID!,
        bill_id!,
        supplierBillModel!.bill_no!,
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
  initSupplierBillData() async {
    userID = services.sharedPreferences.getString(AppShared.userID);
    bill_id = Get.arguments["bill_id"];
  }

  @override
  showSupplierDiscountDialog(Function() onConfirm) {
    Get.defaultDialog(
      onCancel: () {},
      onConfirm: () {
        onConfirm();
      },
      backgroundColor: AppColors.background,
      confirmTextColor: AppColors.background,
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
              CustomTextField(
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
  updateSupplierBillTotalPrice(double discount) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await addSupplierDiscount(discount);
      total_earn = total_earn! - discount;
      total_price = total_price! - discount;
      await supplierBillData.update_total_price(
        userID!,
        bill_id!,
        total_price!,
        total_earn!,
      );
      await updateBillInSupplierDepts(total_price!);
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  discountOnSupplierBill() {
    try {
      showSupplierDiscountDialog(() async {
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
            await updateSupplierBillTotalPrice(discount);
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
  Future deleteSupplierBill() async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await supplierBillData.deleteSupplierBill(userID!, bill_id!);

      await deleteBillFromSupplierDepts();
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }

    update();
  }

  @override
  showDeleteSupplierBillDialog() {
    Get.defaultDialog(
      backgroundColor: AppColors.background,
      onCancel: () {},
      buttonColor: AppColors.primary,
      onConfirm: () {
        deleteSupplierBill();
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
  goToSupplierPdfViewPage(Uint8List pdfBytes) {
    Get.toNamed(AppRoutes.pdf_view, arguments: {"pdfBytes": pdfBytes});
  }

  @override
  createSupplierBillPdf() async {
    statusreqest = Statusreqest.loading;
    update();
    try {
      String companyName =
          services.sharedPreferences.getString(AppShared.company_name)!;
      pdfBytes = await createInvoice(
        supplierProductList.toList(),
        "${supplierBillModel!.bill_date!.day.toString().padLeft(2, '0')}/${supplierBillModel!.bill_date!.month.toString().padLeft(2, '0')}/${supplierBillModel!.bill_date!.year}",
        companyName,
        supplierBillModel!.bill_no!,
        supplierBillModel!.total_price!,
        "شراء",
        supplierBillModel!.supplier_name!,
        supplierBillModel!.supplier_city!,
      );
      String pdfFileName = "${supplierBillModel!.bill_no}.pdf";
      await FileSaver.saveFile(
        bytes: pdfBytes,
        fileName: pdfFileName,
        mimeType: 'application/pdf',
      );
      statusreqest = Statusreqest.success;
      update();
    } on Exception {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  updateBillInSupplierDepts(double totalPrice) {
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      final String supplierId = supplierBillModel!.supplier_id!;
      final String billId = supplierBillModel!.bill_id!;
      supplierDeptsData.updateTotalPriceInBill(
        billId,
        supplierId,
        userID,
        totalPrice,
      );
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  deleteBillFromSupplierDepts() {
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      final String supplierId = supplierBillModel!.supplier_id!;
      final String billId = supplierBillModel!.bill_id!;
      supplierDeptsData.delteBillFromDepts(billId, supplierId, userID);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  addSupplierDiscount(double discount) {
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
  addSupplierBillToDepts() async {
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      await supplierDeptsData.addBillToDepts(
        supplierBillModel!.bill_no!,
        bill_id!,
        supplierBillModel!.supplier_id!,
        supplierBillModel!.payment_type!,
        userID,
        supplierBillModel!.total_price!,
        supplierBillModel!.bill_date!,
      );

      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  addSupplierDept() async {
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      await supplierDeptsData.addDepts(
        supplierBillModel!.supplier_id!,
        supplierBillModel!.supplier_name!,
        supplierBillModel!.supplier_city!,
        userID,
        supplierBillModel!.total_price!,
        supplierBillModel!.bill_date!,
      );
      statusreqest = Statusreqest.success;
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  updateSupplierPaymentType(String paymentType) {
    statusreqest = Statusreqest.loading;
    update();
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      supplierBillData.updatePaymentType(userID, bill_id!, paymentType);
      if (paymentType != "monetary") {
        addSupplierDept();
        addSupplierBillToDepts();
      } else {
        deleteBillFromSupplierDepts();
      }
      supplierBillModel!.payment_type = paymentType;
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  showEditSupplierPaymentTypeDialog() {
    Get.defaultDialog(
      title: "تغيير طريقة الدفع",
      backgroundColor: AppColors.background,
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "اختَر طريقة الدفع التي تريدها:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.attach_money_rounded,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    "نقدي",
                    style: TextStyle(color: AppColors.primary),
                  ),
                  onTap:
                      supplierBillModel?.payment_type == "monetary"
                          ? null
                          : () {
                            updateSupplierPaymentType("monetary");
                            Get.back();
                          },
                  tileColor:
                      supplierBillModel?.payment_type == "monetary"
                          ? AppColors.primary.withValues(alpha: 0.12)
                          : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 12),
                ListTile(
                  leading: Icon(
                    Icons.money_off_csred_outlined,
                    color: AppColors.red,
                  ),
                  title: Text("دَين", style: TextStyle(color: AppColors.red)),
                  onTap:
                      supplierBillModel?.payment_type != "monetary"
                          ? null
                          : () {
                            updateSupplierPaymentType("Religion");
                            Get.back();
                          },
                  tileColor:
                      supplierBillModel?.payment_type != "monetary"
                          ? AppColors.red.withValues(alpha: 0.12)
                          : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      textCancel: "إلغاء",
      onCancel: () {},
    );
  }

  @override
  void onInit() async {
    initSupplierBillData();
    await getSupplierBillDetails();
    getSupplierBillProducts();
    super.onInit();
  }
}
