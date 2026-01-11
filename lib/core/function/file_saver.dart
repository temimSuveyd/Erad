import 'package:erad/core/function/file_saver_io.dart';
import 'package:flutter/foundation.dart';

// Web için conditional import

abstract class FileSaver {
  static Future<void> saveFile({
    required Uint8List bytes,
    required String fileName,
    String? mimeType,
  }) async {
    if (kIsWeb) {
      // await FileSaverWeb.saveFile(
      //   bytes: bytes,
      //   fileName: fileName,
      //   mimeType: mimeType,
      // );
    } else {
      await FileSaverIO.saveFile(
        bytes: bytes,
        fileName: fileName,
        mimeType: mimeType,
      );
    }
  }
}
