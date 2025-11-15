import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

AppBar Custom_home_appBar() {
  final now = DateTime.now();
  final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(now);

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.primary,
    centerTitle: true,
    // title: Text(
    //   formattedDateTime,
    //   style: TextStyle(
    //     fontSize: 22,
    //     color: AppColors.wihet,
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
    actions: [
      SizedBox(width: 15),
      SizedBox(
        height: 45,
        width: 45,
        child: Image.asset(AppImages.logo, fit: BoxFit.cover),
      ),
      SizedBox(width: 10),
      Text(
        "إراد",
        style: TextStyle(
          fontSize: 24,
          color: AppColors.wihet,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(flex: 2),

      // Güzel animasyonlu ve sürekli güncellenen saat-bilgi gösterimi
      TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1, end: 0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Opacity(opacity: 1 - value, child: child);
        },
        child: StreamBuilder<DateTime>(
          stream: Stream.periodic(
            const Duration(seconds: 1),
            (_) => DateTime.now(),
          ),
          builder: (context, snapshot) {
            final now = snapshot.data ?? DateTime.now();
            final formatted = DateFormat(
              'EEEE, d MMMM yyyy - HH:mm:ss',
              'ar',
            ).format(now);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.wihet.withOpacity(0.12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    formatted,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      Spacer(flex: 3),
    ],
  );
}
