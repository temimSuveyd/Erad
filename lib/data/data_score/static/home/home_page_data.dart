import 'package:erad/core/constans/images.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/data/model/home/home_modle.dart';

List<HomeModle> home_page_data = [
  // customers
  HomeModle(AppImages.customers, AppRoutes.customers_view_page, "زبائني"),
  HomeModle(
    AppImages.customersBills,
    AppRoutes.customer_bills_view_page,
    "فواتير الزبائن",
  ),
  HomeModle(
    AppImages.customersDepts,
    AppRoutes.customer_debts_view_page,
    "ديون الزبائن",
  ),

  // suppliers
  HomeModle(AppImages.suppliers, AppRoutes.suppliers_view, "موردين"),
  HomeModle(
    AppImages.suppliersBills,
    AppRoutes.supplier_bills_view_page,
    "فواتير الموردين",
  ),
  HomeModle(
    AppImages.suppliersDepts,
    AppRoutes.supplier_depts_view_page,
    "ديون الموردين",
  ),

  // products
  HomeModle(AppImages.categorey, AppRoutes.categoreys_view_page, "فئات"),
  HomeModle(AppImages.products, AppRoutes.home_page, "بضائع"),
  HomeModle(AppImages.reports, AppRoutes.reports_view_page, "تقارير"),
  HomeModle(AppImages.expenses, AppRoutes.expenses_category_page, "مصاريف"),
  HomeModle(AppImages.withdrawal, AppRoutes.withdrawn_fund_category_page, "سحب"),
];
