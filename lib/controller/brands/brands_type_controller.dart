
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/brands/brands_data.dart';
import 'package:erad/view/prodects/brands_type_view/widgets/custom_add_brands_type_dialog.dart';
import 'package:erad/view/custom_widgets/custom_delete_dialog.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';

abstract class BrandsTypeController extends GetxController {
  show_dialog();
  add_brands_type();
  get_brands_type();
  initData();
  searchForBrandsType();
  show_edit_dialog(
    String salesPice,
    String buiyngPrice,
    String size,
    String productName,
  );
  editBrandsType(
    String salesPice,
    String buiyngPrice,
    String size,
    String productName,
  );
  deleteBrandsType(String productName);
  show_delete_dialog(String productName);
}

class BrandsTypeControllerImp extends BrandsTypeController {
  Statusreqest statusreqest = Statusreqest.success;
  TextEditingController product_sales_price_controller =
      TextEditingController();
  TextEditingController product_buying_controller = TextEditingController();
  TextEditingController product_size_controller = TextEditingController();
  TextEditingController serach_for_brands_type_controller =
      TextEditingController();
  BrandsData brandData = BrandsData();
  var brandsTypeList = [].obs;
  Services services = Get.find();
  String? categorey_type;
  String? categorey_name;
  String? brand_name;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  show_dialog() async {
    custom_add_brands_type_dialog(
      () {
        add_brands_type();
        Get.back();
      },
      product_buying_controller,
      product_sales_price_controller,
      product_size_controller,
      "سعر البيع",
      "سعر الشراء",
      "حجم المنتج",
      key,
    );
  }

  @override
  add_brands_type() {
    statusreqest = Statusreqest.loading;
    update();
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;

    if (product_size_controller.text.isNotEmpty ||
        product_buying_controller.text.isNotEmpty ||
        product_sales_price_controller.text.isNotEmpty) {
      int productBuingPrice = int.parse(product_buying_controller.text);
      int productSalesPrice = int.parse(product_sales_price_controller.text);
      String productSize = product_size_controller.text;
      int profits = productSalesPrice - productBuingPrice;
      try {
        brandData.addBrandsType(
          categorey_name!,
          userID,
          categorey_type!,
          brand_name!,
          productSize,
          productBuingPrice,
          productSalesPrice,
          profits,
        );

        statusreqest = Statusreqest.success;
        update();
      } catch (e) {
        statusreqest = Statusreqest.faliure;
        update();
      }
    } else {
      custom_snackBar();
    }
  }

  @override
  get_brands_type() {
    statusreqest = Statusreqest.loading;
    update();
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      brandData
          .getBrandsType(
            userID,
            categorey_type!,
            categorey_name!,
            brand_name!,
          )
          .listen((event) {
            brandsTypeList.value = event.docs;
            if (brandsTypeList.isEmpty) {
              statusreqest = Statusreqest.empty;
              update();
            } else {
              statusreqest = Statusreqest.success;
              update();
            }
          });
      update();
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  searchForBrandsType() {
    String search = serach_for_brands_type_controller.text;
    if (search.isEmpty) {
      get_brands_type();
    } else {
      brandsTypeList.value =
          brandsTypeList.where((doc) {
            final data = doc.data();
            final fileView = data["product_name"].toString().toLowerCase();
            return fileView.contains(search.toLowerCase());
          }).toList();
      if (brandsTypeList.isEmpty) {
        statusreqest = Statusreqest.empty;
      }
    }
    update();
  }

  @override
  show_edit_dialog(
    String salesPice,
    String buiyngPrice,
    String size,
    String prandName,
  ) {
    custom_add_brands_type_dialog(
      () {
        editBrandsType(salesPice, buiyngPrice, size, prandName);
        Get.back();
      },
      product_buying_controller,
      product_sales_price_controller,
      product_size_controller,
      salesPice,
      buiyngPrice,
      size,
      key,
    );
  }

  @override
  editBrandsType(
    String salesPice,
    String buiyngPrice,
    String size,
    String productName,
  ) {
    statusreqest = Statusreqest.loading;
    update();
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    String productBuingPrice =
        product_buying_controller.text.isEmpty
            ? buiyngPrice
            : product_buying_controller.text;
    String productSalesPrice =
        product_sales_price_controller.text.isEmpty
            ? salesPice
            : product_buying_controller.text;
    String productSize =
        product_size_controller.text.isEmpty
            ? size
            : product_size_controller.text;
    try {
      brandData.editBrandsType(
        userID,
        productBuingPrice,
        productSalesPrice,
        productSize,
        productName,
      );
      product_buying_controller.clear();
      product_size_controller.clear();
      product_sales_price_controller.clear();
      statusreqest = Statusreqest.success;
    } catch (e) {
      statusreqest = Statusreqest.faliure;
    }
    update();
  }

  @override
  deleteBrandsType(String productName) {
    String userID =
        services.sharedPreferences.getString(AppShared.userID)!;
    try {
      brandData.deleteBrandsType(userID, productName);
    } catch (e) {
      statusreqest = Statusreqest.faliure;
      update();
    }
  }

  @override
  show_delete_dialog(String productName) {
    custom_delete_dialog(() {
      deleteBrandsType(productName);
    });
  }

  @override
  initData() {
    categorey_type = Get.arguments["categorey_type"];
    categorey_name = Get.arguments["categorey_name"];
    brand_name = Get.arguments["brand_name"];
  }

  @override
  void onInit() {
    initData();
    get_brands_type();
    super.onInit();
  }
}
