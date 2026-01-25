import 'package:cloud_firestore/cloud_firestore.dart';

class BrandsData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // add brands
  void addBrand(
    String categoreyName,
    String userID,
    String categoreyType,
    String brandName,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands")
        .doc(brandName)
        .set({
          "brand_name": brandName,
          "categorey_name": categoreyName,
          "categorey_type": categoreyType,
        });
  }

  void updateBrand(
    String oldBrandName,
    String newBrandName,
    String categoreyName,
    String categoreyType,
    String userID,
  ) {
    // Delete old document
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands")
        .doc(oldBrandName)
        .delete();

    // Create new document with updated name
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands")
        .doc(newBrandName)
        .set({
          "brand_name": newBrandName,
          "categorey_name": categoreyName,
          "categorey_type": categoreyType,
        });
  }

  void deleteBramd(String userID, String brandName) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands")
        .doc(brandName)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBrands(
    String userID,
    String categoreyType,
    String categoreyName,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("brands")
        .where("categorey_name", isEqualTo: categoreyName)
        .where("categorey_type", isEqualTo: categoreyType)
        .snapshots();
  }

  void addBrandsType(
    String categoreyName,
    String userID,
    String categoreyType,
    String brandName,
    String productSize,
    int productBuingPrice,
    int productSalesPrice,
    int productProfits,
  ) {
    String productName = "$categoreyType $brandName $productSize";
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands_type")
        .doc(productName)
        .set({
          "product_profits": productProfits,
          "product_name": productName,
          "product_size": productSize,
          "product_buing_price": productBuingPrice,
          "product_sales_price": productSalesPrice,
          "categorey_name": categoreyName,
          "brand_name": brandName,
        });
  }

  void editBrandsType(
    String userID,
    String productBuingPrice,
    String productSalesPrice,
    String productSize,
    String productName,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands_type")
        .doc(productName)
        .update({
          "product_size": productSize,
          "product_buing_price": productBuingPrice,
          "product_sales_price": productSalesPrice,
        });
  }

  void deleteBrandsType(String userID, String productName) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands_type")
        .doc(productName)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBrandsType(
    String userID,
    String categoreyType,
    String categoreyName,
    String brandName,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("brands_type")
        .where("categorey_name", isEqualTo: categoreyName)
        .where("brand_name", isEqualTo: brandName)
        .snapshots();
  }
}
