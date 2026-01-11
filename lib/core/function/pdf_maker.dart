import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:erad/core/constans/colors.dart'; // AppColor import

Future<Uint8List> createInvoice(
  // bill data
  List products,
  String billDate,
  String companyName,
  String billId,
  double totalPrice,
  String billType,
  // customer data
  String customerName,
  String customerCity,
) async {
  final pdf = pw.Document();

  // Load font for Arabic support
  final fontData = await rootBundle.load("assets/fonts/Cairo/Cairo-Medium.ttf");
  final ttf = pw.Font.ttf(fontData.buffer.asByteData());

  // Use AppColor.primaryColor as main color
  final PdfColor primaryColor = PdfColor.fromInt(AppColors.primary.value);

  // Colors (all use primaryColor)
  final headerBg = primaryColor;
  final headerText = PdfColors.white;
  final tableAltRow1 = PdfColor.fromHex('#f9f7f1');
  final tableAltRow2 = PdfColor.fromHex('#fffbe9');
  final tableBorder = PdfColor.fromInt(
    primaryColor.toInt() & 0x00FFFFFF | ((0.7 * 255).toInt() << 24),
  );
  final black = PdfColors.black;
  final mainAccent = primaryColor;

  // Helper for alternate row color
  PdfColor getRowColor(int i) => i % 2 == 0 ? tableAltRow1 : tableAltRow2;

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(26),
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Container(
            color: PdfColors.white,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                // Logo and Company Name Row
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 6),
                      child: pw.Text(
                        companyName,
                        style: pw.TextStyle(
                          font: ttf,
                          fontSize: 26,
                          color: mainAccent,
                          fontWeight: pw.FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
                // Divider
                pw.Container(
                  height: 2,
                  color: PdfColor.fromInt(
                    mainAccent.toInt() & 0x00FFFFFF |
                        ((0.6 * 255).toInt() << 24),
                  ),
                ),
                pw.SizedBox(height: 10),

                // Fatura bilgileri ve müşteri bilgileri aynı alanda (tek kutu içinde)
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: tableBorder, width: 1),
                    borderRadius: pw.BorderRadius.circular(7),
                    color: tableAltRow1,
                  ),
                  padding: const pw.EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 18,
                  ),
                  margin: const pw.EdgeInsets.only(bottom: 20),
                  alignment: pw.Alignment.centerRight,
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      // Customer Info Left
                      pw.Expanded(
                        flex: 2,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              'إلى العميل الكريم',
                              style: pw.TextStyle(
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 13.5,
                                color: mainAccent,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                            pw.SizedBox(height: 3),
                            pw.Text(
                              'الاسم: $customerName',
                              style: pw.TextStyle(
                                font: ttf,
                                fontSize: 12,
                                color: black,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                            pw.Text(
                              'المدينة: $customerCity',
                              style: pw.TextStyle(
                                font: ttf,
                                fontSize: 12,
                                color: black,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 22),
                      // Invoice Info Right
                      pw.Expanded(
                        flex: 3,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              'نوع الفاتورة: $billType',
                              style: pw.TextStyle(
                                font: ttf,
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold,
                                color: mainAccent,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                            pw.Text(
                              'رقم الفاتورة: $billId',
                              style: pw.TextStyle(
                                font: ttf,
                                fontSize: 12,
                                color: black,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                            pw.Text(
                              'تاريخ الفاتورة: $billDate',
                              style: pw.TextStyle(
                                font: ttf,
                                fontSize: 12,
                                color: black,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Product Table Section Title
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'تفاصيل المنتجات',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 15.5,
                      fontWeight: pw.FontWeight.bold,
                      color: mainAccent,
                    ),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
                pw.SizedBox(height: 9),
                // Styled Product Table
                pw.Table(
                  border: pw.TableBorder(
                    horizontalInside: pw.BorderSide(
                      color: tableBorder,
                      width: 0.7,
                    ),
                    bottom: pw.BorderSide(color: tableBorder, width: 1),
                    top: pw.BorderSide(color: tableBorder, width: 1),
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3.2),
                    1: const pw.FlexColumnWidth(1.1),
                    2: const pw.FlexColumnWidth(1.5),
                    3: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    // Table Header
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: headerBg),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 7),
                          child: pw.Text(
                            'الصنف',
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13.2,
                              color: headerText,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 7),
                          child: pw.Text(
                            'الكمية',
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13.2,
                              color: headerText,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 7),
                          child: pw.Text(
                            'سعر الوحدة',
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13.2,
                              color: headerText,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 7),
                          child: pw.Text(
                            'الإجمالي',
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13.2,
                              color: headerText,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // Product rows
                    ...products.asMap().entries.map((entry) {
                      final i = entry.key;
                      final product = entry.value;
                      return pw.TableRow(
                        decoration: pw.BoxDecoration(color: getRowColor(i)),
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 3,
                            ),
                            child: pw.Text(
                              product['product_name'] ?? '',
                              style: pw.TextStyle(font: ttf, fontSize: 12.5),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text(
                              product['product_number']?.toString() ?? '0',
                              style: pw.TextStyle(font: ttf, fontSize: 12.5),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text(
                              '${(product['product_price'] is num ? product['product_price'].toStringAsFixed(2) : '0.00')}',
                              style: pw.TextStyle(font: ttf, fontSize: 12.5),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text(
                              '${(product['total_product_price'] is num ? product['total_product_price'].toStringAsFixed(2) : '0.00')}',
                              style: pw.TextStyle(
                                font: ttf,
                                fontSize: 12.5,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
                pw.SizedBox(height: 22),

                // Total with marker badge
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      color: mainAccent,
                      borderRadius: pw.BorderRadius.circular(7),
                    ),
                    padding: const pw.EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 28,
                    ),
                    child: pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text(
                          'الإجمالي: ',
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 15.5,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.white,
                          ),
                          textAlign: pw.TextAlign.right,
                        ),
                        pw.Text(
                          totalPrice.toStringAsFixed(2),
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 15.2,
                            fontWeight: pw.FontWeight.bold,
                            letterSpacing: 0.6,
                            color: PdfColors.white,
                          ),
                          textAlign: pw.TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Spacer(),

                // Footnote or signature row (optional)
                pw.SizedBox(height: 22),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'شكراً لتعاملكم معنا',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 13.5,
                      color: mainAccent,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  return pdf.save();
}
