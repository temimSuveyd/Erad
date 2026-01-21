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
          .getBillProducts(userID!, bill_id!)
          .listen(
            (event) {
              productList.value = event;
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
          .getBillProductById(userID!, bill_id!, productId)
          .then((value) {
            product_numper = value!["product_number"];
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
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                "تعديل عدد المنتجات",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Input field
              CustomTextField(
                hintText: "أدخل العدد الجديد",
                suffixIcon: Icons.edit,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "يرجى إدخال العدد";
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return "يرجى إدخال عدد صحيح أكبر من صفر";
                  }
                  return null;
                },
                controller: controller,
                onChanged: (value) {},
              ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: AppColors.textSecondary),
                        ),
                      ),
                      child: Text(
                        "إلغاء",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty &&
                            int.tryParse(controller.text) != null &&
                            int.parse(controller.text) > 0) {
                          onConfirm();
                        } else {
                          custom_snackBar(
                            AppColors.error,
                            "خطأ",
                            "يرجى إدخال عدد صحيح أكبر من صفر",
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "تأكيد",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
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
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.error,
                  size: 32,
                ),
              ),

              const SizedBox(height: 16),

              // Title
              Text(
                "حذف المنتج",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Message
              Text(
                "هل أنت متأكد من أنك تريد حذف هذا المنتج من الفاتورة؟\nلا يمكن التراجع عن هذا الإجراء.",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: AppColors.textSecondary),
                        ),
                      ),
                      child: Text(
                        "إلغاء",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        delete_product(productId);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "حذف",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
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
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.discount_outlined,
                  color: AppColors.warning,
                  size: 32,
                ),
              ),

              const SizedBox(height: 16),

              // Title
              Text(
                "خصم على الفاتورة",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Current discount info
              if (discount_amount > 0)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.info.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.info.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    "الخصم الحالي: ${discount_amount.toStringAsFixed(0)} د.ع",
                    style: TextStyle(
                      color: AppColors.info,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              if (discount_amount > 0) const SizedBox(height: 16),

              // Input field
              CustomTextField(
                hintText: "أدخل مبلغ الخصم (د.ع)",
                suffixIcon: Icons.discount,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "يرجى إدخال مبلغ الخصم";
                  }
                  final discount = double.tryParse(value);
                  if (discount == null || discount <= 0) {
                    return "يرجى إدخال مبلغ صحيح أكبر من صفر";
                  }
                  if (total_price != null && total_price! - discount < 0) {
                    return "مبلغ الخصم أكبر من إجمالي الفاتورة";
                  }
                  return null;
                },
                controller: discount_controller,
                onChanged: (value) {},
              ),

              const SizedBox(height: 16),

              // Info message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.warning.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.warning,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "سيتم إضافة هذا الخصم إلى الخصم الحالي",
                        style: TextStyle(
                          color: AppColors.warning,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        discount_controller.clear();
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: AppColors.textSecondary),
                        ),
                      ),
                      child: Text(
                        "إلغاء",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => onConfirm(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.warning,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "تطبيق الخصم",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
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
      await customerBillData.updateTotalPrice(
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
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_forever_outlined,
                  color: AppColors.error,
                  size: 40,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              Text(
                "حذف الفاتورة",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Message
              Text(
                "هل أنت متأكد من أنك تريد حذف هذه الفاتورة نهائياً؟",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Warning message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.error,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "تحذير مهم:",
                            style: TextStyle(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "• سيتم حذف جميع المنتجات المرتبطة بالفاتورة\n• سيتم حذف الفاتورة من سجل الديون\n• لا يمكن التراجع عن هذا الإجراء",
                            style: TextStyle(
                              color: AppColors.error,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: AppColors.textSecondary),
                        ),
                      ),
                      child: Text(
                        "إلغاء",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        deleteBill();
                        Get.close(0);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "حذف نهائي",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Prevent accidental dismissal
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
      customerDeptsData.deleteBillFromDepts(billId, customerId, userID);
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
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.payments_outlined,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),

              const SizedBox(height: 16),

              // Title
              Text(
                "تغيير طريقة الدفع",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                "اختر طريقة الدفع المناسبة للفاتورة",
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Payment options
              Column(
                children: [
                  // Cash payment option
                  GestureDetector(
                    onTap:
                        billModel?.payment_type == "monetary"
                            ? null
                            : () {
                              updatePaymentType("monetary");
                              Get.back();
                            },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            billModel?.payment_type == "monetary"
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              billModel?.payment_type == "monetary"
                                  ? AppColors.primary
                                  : AppColors.border,
                          width: billModel?.payment_type == "monetary" ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.attach_money_rounded,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "دفع نقدي",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "تم دفع المبلغ كاملاً نقداً",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (billModel?.payment_type == "monetary")
                            Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Credit payment option
                  GestureDetector(
                    onTap:
                        billModel?.payment_type != "monetary"
                            ? null
                            : () {
                              updatePaymentType("Religion");
                              Get.back();
                            },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            billModel?.payment_type != "monetary"
                                ? AppColors.warning.withValues(alpha: 0.1)
                                : AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              billModel?.payment_type != "monetary"
                                  ? AppColors.warning
                                  : AppColors.border,
                          width: billModel?.payment_type != "monetary" ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.warning.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.schedule_outlined,
                              color: AppColors.warning,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "دفع آجل (دين)",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "سيتم إضافة المبلغ إلى ديون العميل",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (billModel?.payment_type != "monetary")
                            Icon(
                              Icons.check_circle,
                              color: AppColors.warning,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Cancel button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Get.back(),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: AppColors.textSecondary),
                    ),
                  ),
                  child: Text(
                    "إلغاء",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
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
