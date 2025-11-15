import 'dart:convert';

/// [expenses] listesindeki stringleri güvenli ve hatasız şekilde Map'e çevirir.
/// Sadece geçerli JSON stringlerini parse eder.
/// JSON olmayan veya bozuk stringleri tamamen atlar.
/// Hiçbir regex veya manuel düzeltme yapmaz, sadece jsonDecode kullanır.
/// Hatalı stringler atlanır, uygulama asla crash olmaz.
List<Map<String, dynamic>> fromStringToList(List<String>? expenses) {
  if (expenses == null || expenses.isEmpty) return [];

  final List<Map<String, dynamic>> result = [];

  for (final str in expenses) {
    final cleaned = str.trim();
    if (cleaned.isEmpty) continue;

    try {
      final decoded = jsonDecode(cleaned);
      if (decoded is Map<String, dynamic>) {
        result.add(decoded);
      }
    } catch (e) {
      // Hatalı stringi atla
    }
  }
  return result;
}
