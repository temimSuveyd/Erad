import 'package:erad/view/customer/customer_bills_add/suppliers_bill_add.dart';
import 'package:erad/view/expenses/expenses_page.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/supplier_bill_details_view.dart';
import 'package:erad/view/supplier/depts/supplier_debts_view/suppliers_debts_view_page.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_add/suppliers_bill_add.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_view/suppliers_bills_view_page.dart';
import 'package:erad/view/supplier/depts/suppliers_debt_details/suppliers_debts_details_page.dart';
import 'package:erad/view/supplier/suppliers_view/customers_view_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
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
  GetPage(name: "/", page: () => LoginPage()),
  GetPage(name: AppRoutes.home_page, page: () => HomePage()),
     GetPage(
    name: AppRoutes.pdf_view,
    page: () => PdfViewPage(),
  ),


 GetPage(name: AppRoutes.login_page, page: () => LoginPage()),
   // customer
 
  GetPage(
    name: AppRoutes.customer_bills_add_page,
    page: () => CustomerBillAddPage(),
  ),
  GetPage(
    name: AppRoutes.customer_bills_details_page,
    page: () => CustomerBillDetailsPage(),
  ),
  GetPage(
    name: AppRoutes.customer_bills_view_page,
    page: () => CustomerBillsViewPage(),
  ),
  GetPage(
    name: AppRoutes.customer_debt_details_page,
    page: () => CustomerDebtsDetailsPage(),
  ),
  GetPage(
    name: AppRoutes.customer_debts_view_page,
    page: () => CustomerDebtsViewPage(),
  ),
// category
  GetPage(
    name: AppRoutes.categoreys_view_page,
    page: () => CategoreysViewPage(),
  ),
  GetPage(
    name: AppRoutes.categorey_type_view_page,
    page: () => CategoreyTypeViewPage(),
  ),
  GetPage(name: AppRoutes.brands_page, page: () => BrandsViewPage()),
  GetPage(
    name: AppRoutes.brands_page_type_page,
    page: () => BrandsTypeViewPage(),
  ),

    GetPage(
    name: AppRoutes.customers_view_page,
    page: () => CustomersViewPage(),
  ),

  //  supplier

      GetPage(
    name: AppRoutes.suppliers_view,
    page: () => SuppliersViewPage(),
  ),

        GetPage(
    name: AppRoutes.supplier_bills_view_page,
    page: () => SuppliersBillsViewPage(),
  ),

          GetPage(
    name: AppRoutes.supplier_bills_add_page,
    page: () => SuppliersBillAddPage(),
  ),

            GetPage(
    name: AppRoutes.supplier_bill_details_page,
    page: () => SupplierBillDetailsPage(),
  ),
              GetPage(
    name: AppRoutes.supplier_depts_view_page,
    page: () => SupplierDebtsViewPage(),
  ),
                GetPage(
    name: AppRoutes.supplier_depts_details_page,
    page: () => SupplierDebtsDetailsPage(),
  ),


// expenses
                  GetPage(
    name: AppRoutes.expenses_page,
    page: () => ExpensesPage(),
  ),
];
