import 'package:flutter/material.dart';

bool isDateInRange({
  required DateTime billDate,
  required DateTimeRange range,
}) {
  // Sadece yıl-ay-gün karşılaştırması için normalize et
  DateTime normalize(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  final bill = normalize(billDate);
  final start = normalize(range.start);
  final end = normalize(range.end);

  // Eğer tek bir gün seçilmişse
  if (start == end) {
    return bill == start;
  }

  // Tarih aralığı kontrolü (başlangıç ve bitiş dahil)
  return !bill.isBefore(start) && !bill.isAfter(end);
}
