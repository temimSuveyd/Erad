import 'package:Erad/core/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:Erad/core/constans/routes.dart';
import 'package:Erad/data/model/home/home_modle.dart';

List<HomeModle> home_sales_data = [
  HomeModle(AppImages.customers, AppRoutes.customers_view_page, "زبائني"),
  HomeModle(AppImages.suppliers, AppRoutes.suppliers_view, "موردين"),

  HomeModle(AppImages.categorey, AppRoutes.categoreys_view_page, "تصنيف"),
  HomeModle(AppImages.products, AppRoutes.home_page, "بَضَائِعُي"),

  HomeModle(
    AppImages.customersBills,
    AppRoutes.customer_bills_view_page,
    "فواتير العملاء",
  ),
  HomeModle(
    AppImages.suppliersBills,
    AppRoutes.supplier_bills_view_page,
    "فواتير الموردين",
  ),
  HomeModle(
    AppImages.customersDepts,
    AppRoutes.customer_debts_view_page,
    "ديون العملاء",
  ),
  HomeModle(
    AppImages.suppliersDepts,
    AppRoutes.customer_debts_view_page,
    "ديوني",
  ),

  HomeModle(AppImages.reports, AppRoutes.home_page, "تقارير"),
  HomeModle(AppImages.expenses, AppRoutes.home_page, "مصاريفي"),
  HomeModle(AppImages.withdrawal, AppRoutes.home_page, "سحب"),
];
