  import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

AppBar Custom_pdf_view_page_appBar(void Function() onPressed) {
    return AppBar(
      title: Text("ملف الفاتورة"),
      actions: [IconButton(onPressed: () {
       onPressed();
      }, icon: Icon(Icons.share, size: 30, color: AppColors.black))],
      backgroundColor: AppColors.backgroundColor,
      automaticallyImplyLeading: true,
    );
  }