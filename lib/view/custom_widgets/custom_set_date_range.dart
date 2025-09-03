import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';

Future<DateTimeRange?> selectDateRange(BuildContext context) async {
  return await showDateRangePicker(
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    initialDateRange: DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(days: 30)),
    ),

    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            onSurface: AppColors.primary,
            surface: AppColors.backgroundColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
        ),

        child: child!,
      );
    },
  );
}
