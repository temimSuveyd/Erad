import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class FileSaverIO {
  static Future<void> saveFile({
    required Uint8List bytes,
    required String fileName,
    String? mimeType,
  }) async {
    try {
      // Downloads klasörünü al
      Directory? downloadsDirectory;

      if (Platform.isWindows) {
        // Windows için Downloads klasörü
        final String userProfile = Platform.environment['USERPROFILE'] ?? '';
        if (userProfile.isNotEmpty) {
          downloadsDirectory = Directory('$userProfile\\Downloads');
        }
      } else if (Platform.isAndroid) {
        // Android için external storage
        downloadsDirectory = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        // iOS için documents directory
        downloadsDirectory = await getApplicationDocumentsDirectory();
      } else {
        // Diğer platformlar için documents directory
        downloadsDirectory = await getApplicationDocumentsDirectory();
      }

      if (downloadsDirectory == null) {
        throw Exception('Downloads directory not found');
      }

      // Dosya yolunu oluştur
      final String filePath =
          '${downloadsDirectory.path}${Platform.pathSeparator}$fileName';
      final File file = File(filePath);

      // Dosyayı yaz
      await file.writeAsBytes(bytes);

      print('File saved to: $filePath');

      // Başarı mesajı göster (opsiyonel)
      // Bu kısmı controller'da handle edebilirsiniz
    } catch (e) {
      print('Error saving file: $e');
      throw Exception('Failed to save file: $e');
    }
  }
}
