import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<Uint8List> createInvoice(
  // bill data
  List products,
  String bill_date,
  String company_name,
  String bill_id,
  double total_price ,
  String bill_type,
  // customer data
  String customer_name,
  String customer_city,
  int customer_phone
) async {
  final PdfDocument document = PdfDocument();
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  // Load font
  final ByteData fontData = await rootBundle.load(
    "assets/fonts/Cairo/Cairo-Medium.ttf",
  );
  final Uint8List fontBytes = fontData.buffer.asUint8List();

  // Fonts
  final PdfFont titleFont = PdfTrueTypeFont(
    fontBytes,
    18,
    style: PdfFontStyle.bold,
  );
  final PdfFont headerFont = PdfTrueTypeFont(
    fontBytes,
    14,
    style: PdfFontStyle.bold,
  );
  final PdfFont normalFont = PdfTrueTypeFont(fontBytes, 12);

  // Text formats
  final PdfStringFormat rightAlignedFormat = PdfStringFormat(
    alignment: PdfTextAlignment.right,
    textDirection: PdfTextDirection.rightToLeft,
  );
  final PdfStringFormat leftAlignedFormat = PdfStringFormat(
    alignment: PdfTextAlignment.left,
    textDirection: PdfTextDirection.rightToLeft,
  );

  graphics.drawString(
    "نوع الفاتورة : $bill_type",
    normalFont,
    bounds: const Rect.fromLTWH(10, 0, 490, 25),
    format: rightAlignedFormat,
  );
  graphics.drawString(
    "تاريخ الفاتورة: $bill_date",
    normalFont,
    bounds: const Rect.fromLTWH(10, 20, 490, 30),
    format: rightAlignedFormat,
  );
  graphics.drawString(
    "رقم الفاتورة: $bill_id",
    normalFont,
    bounds: const Rect.fromLTWH(10, 40, 490, 35),
    format: rightAlignedFormat,
  );

  // logo
  graphics.drawString(
    company_name,
    titleFont,
    bounds: const Rect.fromLTWH(10, 20, 200, 35),
    format: leftAlignedFormat,
  );
  graphics.drawLine(
    PdfPen(PdfColor(0, 0, 0), width: 1),
    Offset(0, 70),
    Offset(600, 70),
  );

  // Customer Info - Middle Left
  graphics.drawString(
    'فاتورة إلى:',
    headerFont,
    bounds: const Rect.fromLTWH(10, 90, 490, 30),
    format: rightAlignedFormat,
  );
  graphics.drawString(
    "اسم : $customer_name",
    normalFont,
    bounds: const Rect.fromLTWH(10, 120, 490, 25),
    format: rightAlignedFormat,
  );
  graphics.drawString(
    "مدينة: $customer_city",
    normalFont,
    bounds: const Rect.fromLTWH(10, 140, 490, 30),
    format: rightAlignedFormat,
  );
  graphics.drawString(
    "رقم:$customer_phone",
    normalFont,
    bounds: const Rect.fromLTWH(10, 160, 490, 35),
    format: rightAlignedFormat,
  );

  // Table
  PdfGrid grid = PdfGrid();
  grid.columns.add(count: 4);
  grid.headers.add(1);
  PdfGridRow header = grid.headers[0];
  header.cells[0].value = 'الصنف';
  header.cells[1].value = 'الكمية';
  header.cells[2].value = 'سعر الوحدة';
  header.cells[3].value = 'الإجمالي';

  // Fix for header cells iteration
  for (int i = 0; i < header.cells.count; i++) {
    header.cells[i].stringFormat = rightAlignedFormat;
  }

  // Grid Style
  grid.style = PdfGridStyle(
    font: normalFont,
    cellPadding: PdfPaddings(left: 10, right: 10, top: 0, bottom: 10),
    backgroundBrush: PdfSolidBrush(PdfColor(245, 245, 245)),
    textBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
  );

  header.style = PdfGridRowStyle(
    backgroundBrush: PdfSolidBrush(PdfColor(70, 70, 70)),
    textBrush: PdfSolidBrush(PdfColor(255, 255, 255)),
    font: headerFont,
  );

  // Add products
  for (var product in products) {
    PdfGridRow row = grid.rows.add();
    row.height = 25; // Set a smaller row height

    // Center align all cells
    row.cells[0].value = product['product_name'] ?? '';
    row.cells[1].value = product['product_number']?.toString() ?? '0';
    row.cells[2].value =
        '\$ ${product['product_price']?.toStringAsFixed(2) ?? '0'}';
    row.cells[3].value =
        '\$ ${product['total_product_price']?.toStringAsFixed(2) ?? '0.00'}';

    // Center align all cells in the row
    for (int i = 0; i < row.cells.count; i++) {
      row.cells[i].stringFormat = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle,
      );
    }
  }

  // Draw table
  grid.draw(page: page, bounds: const Rect.fromLTWH(0, 200, 500, 0));


  // Add total text at the bottom
  final totalText = 'الإجمالي: ${total_price.toStringAsFixed(2)}';
  final totalBounds = Rect.fromLTWH(
    0,
    page.graphics.clientSize.height - 100,
    500,
    30,
  );
  page.graphics.drawString(
    totalText,
    headerFont,
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: totalBounds,
    format: rightAlignedFormat,
  );

  final List<int> bytes = await document.save();
  document.dispose();
  return Uint8List.fromList(bytes);
}
