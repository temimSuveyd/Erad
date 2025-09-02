
  import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

Future<DateTimeRange?> show_date_range_picker(BuildContext context) {
    return showDateRangePicker(
          context: context,
          firstDate: DateTime(2025),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primary,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
  }
