import 'package:erad/core/middleWare/app_middleware.dart';
import 'package:erad/bindings/customer_bills_view_binding.dart';
import 'package:erad/bindings/customer_debts_view_binding.dart';
import 'package:erad/view/customer/customer_bills_add/customer_bill_add.dart';
import 'package:erad/view/expenses/expenses_category/expenses_category.dart';
import 'package:erad/view/expenses/expenses_view/expenses_page.dart';
import 'package:erad/view/reports/reports_view_page.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/supplier_bill_details_view.dart';
import 'package:erad/view/supplier/depts/supplier_debts_view/suppliers_debts_view_page.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_add/suppliers_bill_add.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_view/suppliers_bills_view_page.dart';
import 'package:erad/view/supplier/depts/suppliers_debt_details/suppliers_debts_details_page.dart';
import 'package:erad/view/supplier/suppliers_view/customers_view_page.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_category/withdrawn_funds_category.dart';
import 'package:erad/view/withdrawn_funds/withdrawn_funds_view/withdrawn_funds_page.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/view/customer/Customer_bills_view/customer_bills_view_page.dart';
import 'package:erad/view/customer/Customer_debts_view/customer_debts_view_page.dart';
import 'package:erad/view/prodects/brands_type_view/brand_type_view_page.dart';
import 'package:erad/view/prodects/brands_view/brands_view_page.dart';
import 'package:erad/view/prodects/categorey_type_view/categorey_type_view_page.dart';
import 'package:erad/view/prodects/categoreys_view/categoreys_view_page.dart';
import 'package:erad/view/customer/customer_bill_details/customer_bill_details_view.dart';
import 'package:erad/view/customer/customer_debt_details/customer_debts_details_page.dart';
import 'package:erad/view/customer/customers_view/customers_view_page.dart';
import 'package:erad/view/login/login_page.dart';
import 'package:erad/view/home/home_page.dart';
import 'package:erad/view/pdf_view/pdf_view_page.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: "/",
    page: () => const LoginPage(),
    transition: Transition.leftToRight,
    transitionDuration: const Duration(milliseconds: 350),
    middlewares: [AppMiddleware()],
  ),
  GetPage(
    name: AppRoutes.home_page,
    page: () => const HomePage(),
    transition: Transition.leftToRight,
    transitionDuration: const Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.pdf_view,
    page: () => PdfViewPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),

  GetPage(
    name: AppRoutes.login_page,
    page: () => LoginPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),

  // customer
  GetPage(
    name: AppRoutes.customer_bills_add_page,
    page: () => CustomerBillAddPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.customer_bills_details_page,
    page: () => CustomerBillDetailsPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.customer_bills_view_page,
    page: () => CustomerBillsViewPage(),
    binding: CustomerBillsViewBinding(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.customer_debt_details_page,
    page: () => CustomerDebtsDetailsPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.customer_debts_view_page,
    page: () => CustomerDebtsViewPage(),
    binding: CustomerDebtsViewBinding(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  // category
  GetPage(
    name: AppRoutes.categoreys_view_page,
    page: () => CategoreysViewPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.categorey_type_view_page,
    page: () => CategoreyTypeViewPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.brands_page,
    page: () => BrandsViewPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.brands_page_type_page,
    page: () => BrandsTypeViewPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),

  GetPage(
    name: AppRoutes.customers_view_page,
    page: () => CustomersViewPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),

  //  supplier
  GetPage(
    name: AppRoutes.suppliers_view,
    page: () => SuppliersViewPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),

  GetPage(
    name: AppRoutes.supplier_bills_view_page,
    page: () => SuppliersBillsViewPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),

  GetPage(
    name: AppRoutes.supplier_bills_add_page,
    page: () => SuppliersBillAddPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),

  GetPage(
    name: AppRoutes.supplier_bill_details_page,
    page: () => SupplierBillDetailsPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.supplier_depts_view_page,
    page: () => SupplierDebtsViewPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.supplier_depts_details_page,
    page: () => SupplierDebtsDetailsPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),

  // expenses
  GetPage(
    name: AppRoutes.expenses_page,
    page: () => ExpensesPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.expenses_category_page,
    page: () => ExpensesCategoryPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.reports_view_page,
    page: () => ReportsViewPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.withdrawn_fund_category_page,
    page: () => WithdrawnFundsCategoryPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
  GetPage(
    name: AppRoutes.withdrawn_fund_page,
    page: () => WithdrawnFundsPage(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 350),
  ),
];
