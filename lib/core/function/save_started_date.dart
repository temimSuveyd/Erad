import 'package:erad/core/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Future<DateTimeRange> saveCustomDateRange() async {
  final Services services = Get.find();
  final prefs = services.sharedPreferences;
  final now = DateTime.now();
  final storedDateString = prefs.getString("saved_date");
  late DateTimeRange resultRange;

  if (storedDateString != null) {
    final storedDate = DateTime.parse(storedDateString);
    final difference = now.difference(storedDate).inDays;

    if (difference >= 30) {
      await prefs.setString("saved_date", now.toIso8601String());
      resultRange = DateTimeRange(start: now, end: now);
    } else {
      resultRange = DateTimeRange(start: storedDate, end: now);
    }
  } else {
    await prefs.setString("saved_date", now.toIso8601String());
    resultRange = DateTimeRange(start: now, end: now);
  }

  return resultRange;
}
