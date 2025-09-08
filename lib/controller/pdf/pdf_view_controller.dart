import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

abstract class PdfViewController extends GetxController {
  initData();
  sharePdfFile();
}

class PdfViewControllerImp extends PdfViewController {
  Uint8List? pdfBytes;
  @override
  initData() {
    pdfBytes = Get.arguments["pdfBytes"];
  }


  @override
  sharePdfFile()async {
        try {
  final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/invoice.pdf');
      await file.writeAsBytes(pdfBytes!.toList());
    if (pdfBytes != null) {
      Share.shareXFiles(
        [
  XFile.fromData(
    pdfBytes!,
  ),
        ],
        text: 'سويد للتجارة',
      );
    }
} on Exception {
Get.defaultDialog();
}

  }
  @override
  void onInit() {
    initData();
    super.onInit();
  }
  

}
