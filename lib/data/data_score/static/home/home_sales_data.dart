import 'package:flutter/material.dart';
import 'package:Erad/core/constans/routes.dart';
import 'package:Erad/data/model/home/home_modle.dart';

List<HomeModle> home_sales_data = [
  HomeModle(Icons.person, AppRoutes.customers_view_page, "زبائني"),
  HomeModle(Icons.inventory, AppRoutes.categoreys_view_page, "تصنيف"),
  HomeModle(
    Icons.document_scanner,
    AppRoutes.customer_bills_view_page,
    "فواتير العملاء",
  ),
  HomeModle(
    Icons.money_off,
    AppRoutes.customer_debts_view_page,
    "ديون العملاء",
  ),
];


