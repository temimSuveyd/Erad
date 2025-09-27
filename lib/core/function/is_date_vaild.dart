import 'package:flutter/material.dart';

bool isBillDateValid({
  required DateTime billDate,
  DateTimeRange? selectedRange,
  required DateTime fallbackDate,
}) {
  // Sadece yıl-ay-gün karşılaştırması için normalize et
  DateTime normalize(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  final bill = normalize(billDate);

  if (selectedRange == null) {
    final fallback = normalize(fallbackDate);
    return bill == fallback;
  }

  final start = normalize(selectedRange.start);
  final end = normalize(selectedRange.end);

  if (start == end) {
    return bill == start;
  }

  return !bill.isBefore(start) && !bill.isAfter(end);
}
