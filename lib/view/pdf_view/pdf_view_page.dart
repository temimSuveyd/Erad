import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/pdf/pdf_view_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/pdf_view/widgets/custom_pdf_view_AppBar.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewPage extends GetView<PdfViewControllerImp> {
  const PdfViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PdfViewControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_pdf_view_page_appBar(() {
        controller.sharePdfFile();
      },),
      // body: SfPdfViewer.memory(
      //   controller.pdfBytes!,
      
      // ),
    );
  }
}
