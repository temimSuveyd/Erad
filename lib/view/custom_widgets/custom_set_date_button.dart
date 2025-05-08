import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Custom_set_date_button extends StatelessWidget {
  const Custom_set_date_button({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: MaterialButton(
        height: 50,
        onPressed: () {
          show_dat_range_picker(context).then((dateRange) {
            if (dateRange != null) {
              // Handle selected date range
              final startDate = dateRange.start;
              final endDate = dateRange.end;
              print('Selected date range: $startDate to $endDate');
            }
          });
        },

        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.grey, width: 2),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("2025/01/10", style: TextStyle(color: AppColors.grey,fontSize: 18)),
            Icon(Icons.date_range,color: AppColors.grey,),
          ],
        ),
      ),
    );
  }

  Future<DateTimeRange?> show_dat_range_picker(BuildContext context) {
    return showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
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
}
