import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

// ignore: non_constant_identifier_names
Future<dynamic> custom_add_brands_type_dialog(
  void Function() onConfirm,
  TextEditingController buyingController,
  TextEditingController salesController,
  TextEditingController sizeController,
  String hinttextSales,
  String hinttextBuying,
  String hinttextSize,
  Key? key,
) {
  return Get.dialog(
    Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Ekran boyutuna göre responsive tasarım
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;
          final isDesktop = screenWidth > 600;
          final isTablet = screenWidth > 400 && screenWidth <= 600;

          final dialogWidth =
              isDesktop
                  ? screenWidth *
                      0.45 // Desktop için %45
                  : isTablet
                  ? screenWidth *
                      0.8 // Tablet için %80
                  : screenWidth * 0.95; // Mobil için %95

          return Container(
            width: dialogWidth,
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 600 : double.infinity,
              minWidth: isDesktop ? 450 : 300,
              maxHeight: screenHeight * 0.8,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 32 : 24),
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Başlık
                      Text(
                        "أضف المنتج",
                        style: TextStyle(
                          fontSize: isDesktop ? 24 : 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: isDesktop ? 32 : 24),

                      // Form alanları
                      if (isDesktop)
                        _buildDesktopLayout(
                          buyingController,
                          salesController,
                          sizeController,
                          hinttextBuying,
                          hinttextSales,
                          hinttextSize,
                        )
                      else
                        _buildMobileLayout(
                          buyingController,
                          salesController,
                          sizeController,
                          hinttextBuying,
                          hinttextSales,
                          hinttextSize,
                        ),

                      SizedBox(height: isDesktop ? 32 : 24),

                      // Butonlar
                      isDesktop
                          ? _buildDesktopButtons(
                            onConfirm,
                            buyingController,
                            salesController,
                            sizeController,
                          )
                          : _buildMobileButtons(
                            onConfirm,
                            buyingController,
                            salesController,
                            sizeController,
                          ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
    barrierDismissible: true,
  );
}

// Desktop için 2 sütunlu layout
Widget _buildDesktopLayout(
  TextEditingController buyingController,
  TextEditingController salesController,
  TextEditingController sizeController,
  String hinttextBuying,
  String hinttextSales,
  String hinttextSize,
) {
  return Column(
    children: [
      // İlk satır: Alış ve Satış fiyatı
      Row(
        children: [
          Expanded(
            child: _ResponsiveTextField(
              keyboardType: TextInputType.number,
              suffixIcon: Icons.attach_money_outlined,
              hintText: hinttextBuying,
              controller: buyingController,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _ResponsiveTextField(
              keyboardType: TextInputType.number,

              suffixIcon: Icons.attach_money_outlined,
              hintText: hinttextSales,
              controller: salesController,
            ),
          ),
        ],
      ),

      const SizedBox(height: 20),

      // İkinci satır: Boyut (ortalanmış)
      Row(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 2,
            child: _ResponsiveTextField(
              keyboardType: TextInputType.text,
              suffixIcon: Icons.scale_outlined,
              hintText: hinttextSize,
              controller: sizeController,
            ),
          ),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    ],
  );
}

// Mobil için tek sütunlu layout
Widget _buildMobileLayout(
  TextEditingController buyingController,
  TextEditingController salesController,
  TextEditingController sizeController,
  String hinttextBuying,
  String hinttextSales,
  String hinttextSize,
) {
  return Column(
    children: [
      _ResponsiveTextField(
        keyboardType: TextInputType.number,

        suffixIcon: Icons.attach_money_outlined,
        hintText: hinttextBuying,
        controller: buyingController,
      ),
      const SizedBox(height: 20),
      _ResponsiveTextField(
        keyboardType: TextInputType.number,

        suffixIcon: Icons.attach_money_outlined,
        hintText: hinttextSales,
        controller: salesController,
      ),
      const SizedBox(height: 20),
      _ResponsiveTextField(
        keyboardType: TextInputType.text,

        suffixIcon: Icons.scale_outlined,
        hintText: hinttextSize,
        controller: sizeController,
      ),
    ],
  );
}

// Responsive TextField widget
class _ResponsiveTextField extends StatelessWidget {
  const _ResponsiveTextField({
    required this.hintText,
    required this.controller,
    required this.suffixIcon,
    required this.keyboardType,
  });

  final String hintText;
  final TextEditingController controller;
  final IconData suffixIcon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;

    return SizedBox(
      height: isDesktop ? 55 : 50,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: isDesktop ? 16 : 14),
        decoration: InputDecoration(
          suffixIcon: Icon(
            suffixIcon,
            size: isDesktop ? 24 : 20,
            color: AppColors.primary,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontSize: isDesktop ? 16 : 14,
          ),
          filled: true,
          fillColor: AppColors.wihet,
          contentPadding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 16 : 12,
            vertical: isDesktop ? 16 : 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

// Desktop için yan yana butonlar
Widget _buildDesktopButtons(
  void Function() onConfirm,
  TextEditingController buyingController,
  TextEditingController salesController,
  TextEditingController sizeController,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(
        onPressed: () {
          buyingController.clear();
          salesController.clear();
          sizeController.clear();
          Get.back();
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          "إلغاء",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),

      const SizedBox(width: 16),

      ElevatedButton(
        onPressed: () {
          onConfirm();
          buyingController.clear();
          salesController.clear();
          sizeController.clear();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          "إضافة",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

// Mobil için alt alta butonlar
Widget _buildMobileButtons(
  void Function() onConfirm,
  TextEditingController buyingController,
  TextEditingController salesController,
  TextEditingController sizeController,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () {
          onConfirm();
          buyingController.clear();
          salesController.clear();
          sizeController.clear();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "إضافة",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),

      const SizedBox(height: 12),

      TextButton(
        onPressed: () {
          buyingController.clear();
          salesController.clear();
          sizeController.clear();
          Get.back();
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "إلغاء",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    ],
  );
}
