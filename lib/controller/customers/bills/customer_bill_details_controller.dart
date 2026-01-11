import 'dart:typed_data';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/function/pdf_maker.dart';
import 'package:erad/core/function/file_saver.dart';
import 'package:erad/data/data_score/remote/depts/customer_depts_data.dart';
import 'package:erad/data/model/customer_bill_details/bill_details_product_model.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:erad/view/custom_widgets/custom_snackBar.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart'
    hide custom_snackBar;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/customer/customer_bill_data.dart';
import 'package:erad/data/data_score/remote/brands/product_data.dart';
import 'package:erad/data/model/customer_bills_view/bill_model.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

abstract class CustomerBillDetailsController extends GetxController {
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

class CustomerBillDetailsControllerImp extends CustomerBillDetailsController {
  Statusreqest statusreqest = Statusreqest.loading;
  Services services = Get.find();
  CustomerBillData customerBillData = CustomerBillData();
  CustomerDeptsData customerDeptsData = CustomerDeptsData();
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
      if (userID == null || bill_id == null) {
        statusreqest = Statusreqest.faliure;
        update();
        return;
      }

      statusreqest = Statusreqest.loading;
      update();
      await customerBillData.getBillById(userID!, bill_id!).then((value) {
        billModel = BillModel.formatJson(value);
        total_earn = billModel?.total_earn ?? 0.0;
        total_price = billModel?.total_price ?? 0.0;
        discount_amount = billModel?.discount_amount ?? 0.0;
            });
      statusreqest = Statusreqest.success;
    } catch (e) {
      print('Error in getBillDetails: $e');
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  getBillProducts() {
    try {
      if (userID == null || bill_id == null) {
        statusreqest = Statusreqest.faliure;
        update();
        return;
      }

      statusreqest = Statusreqest.loading;
      update();
      customerBillData
          .getBillProdects(userID!, bill_id!)
          .listen(
            (event) {
              productList.value = event.docs;
              if (productList.isEmpty) {
                statusreqest = Statusreqest.empty;
              } else {
                statusreqest = Statusreqest.success;
              }
              update();
            },
            onError: (error) {
              print('Error in getBillProducts: $error');
              statusreqest = Statusreqest.faliure;
              update();
            },
          );
    } catch (e) {
      print('Exception in getBillProducts: $e');
      statusreqest = Statusreqest.faliure;
      update();
    }
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
      await customerBillData
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
  Future updateProductData(int productNumber, String productId) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await customerBillData.updateProductData(
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
      backgroundColor: AppColors.background,
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
      await customerBillData.deleteProduct(bill_id!, productId, userID!);
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
    try {
      userID = services.sharedPreferences.getString(AppShared.userID);
      final arguments = Get.arguments;
      if (arguments != null && arguments is Map) {
        bill_id = arguments["bill_id"];
      }

      if (userID == null || bill_id == null) {
        print('Error: userID or bill_id is null');
        statusreqest = Statusreqest.faliure;
        update();
      }
    } catch (e) {
      print('Error in initData: $e');
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  show_discount_dialog(Function() onConfirm) {
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
  update_bill_total_brice(double discount) async {
    try {
      statusreqest = Statusreqest.loading;
      update();
      await addDiscount(discount);
      total_earn = total_earn! - discount;
      total_price = total_price! - discount;
      await customerBillData.update_total_price(
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
      await customerBillData.deleteCustomerBill(userID!, bill_id!);

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
      backgroundColor: AppColors.background,
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
      String companyName =
          services.sharedPreferences.getString(AppShared.company_name)!;
      pdfBytes = await createInvoice(
        productList.toList(),
        "${billModel!.bill_date!.day.toString().padLeft(2, '0')}/${billModel!.bill_date!.month.toString().padLeft(2, '0')}/${billModel!.bill_date!.year}",
        companyName,
        billModel!.bill_no!,
        billModel!.total_price!,
        "بيع",
        billModel!.customer_name!,
        billModel!.customer_city!,
      );
      String pdfFileName = "${billModel!.bill_no}.pdf";
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
  updateBillInDepts(double totalPrice) {
    try {
      final String userID =
          services.sharedPreferences.getString(AppShared.userID)!;
      final String customerId = billModel!.customer_id!;
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
      final String customerId = billModel!.customer_id!;
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
      customerBillData.addDiscount(bill_id!, userID, discount);
      discount_amount = discount + discount_amount;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  addBillToDepts() async {
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      await customerDeptsData.addBillToDepts(
        billModel!.bill_no!,
        bill_id!,
        billModel!.customer_id!,
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
    String userID = services.sharedPreferences.getString(AppShared.userID)!;
    try {
      await customerDeptsData.addDepts(
        billModel!.customer_id!,
        billModel!.customer_name!,
        billModel!.customer_city!,
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
      customerBillData.updatePaymentType(userID, bill_id!, paymentType);
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
                      billModel?.payment_type == "monetary"
                          ? null
                          : () {
                            updatePaymentType("monetary");
                            Get.back();
                          },
                  tileColor:
                      billModel?.payment_type == "monetary"
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
                      billModel?.payment_type != "monetary"
                          ? null
                          : () {
                            updatePaymentType("Religion");
                            Get.back();
                          },
                  tileColor:
                      billModel?.payment_type != "monetary"
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
    try {
      await initData();
      if (userID != null && bill_id != null) {
        await getBillDetails();
        getBillProducts();
      }
    } catch (e) {
      print('Error in onInit: $e');
      statusreqest = Statusreqest.faliure;
      update();
    }
    super.onInit();
  }
}
