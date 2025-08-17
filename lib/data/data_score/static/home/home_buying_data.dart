import 'package:flutter/material.dart';
import 'package:Erad/core/constans/routes.dart';
import 'package:Erad/data/model/home/home_modle.dart';

// ignore: non_constant_identifier_names
List<HomeModle> home_buying_data = [
  HomeModle(Icons.person, AppRoutes.suppliers_view, "موردين"),
  HomeModle(Icons.category_rounded, AppRoutes.home_page, "بَضَائِعُي"),
  HomeModle(Icons.document_scanner, AppRoutes.customer_bills_view_page, "فواتيري"),
  HomeModle(Icons.money_off, AppRoutes.customer_debts_view_page, "ديوني"),
  HomeModle(Icons.attach_money_outlined, AppRoutes.home_page, "إدارة أموالي"),
  // HomeModle(Icons.settings, AppRoutes.home_page, "إدارة النظام"),

];