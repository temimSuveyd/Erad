import 'package:cloud_firestore/cloud_firestore.dart';

class BrandsData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // add brands
  addBrand(
    String categorey_name,
    String userID,
    String categorey_type,
    String brand_name,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands")
        .doc(brand_name)
        .set({
          "brand_name": brand_name,
          "categorey_name": categorey_name,
          "categorey_type": categorey_type,
        });
  }

  deleteBramd(String userID, String brand_name) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands")
        .doc(brand_name)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBrands(
    String userID,
    String categorey_type,
    String categorey_name,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("brands")
        .where("categorey_name", isEqualTo: categorey_name)
        .where("categorey_type", isEqualTo: categorey_type)
        .snapshots();
  }

  addBrandsType(
    String categorey_name,
    String userID,
    String categorey_type,
    String brand_name,
    String product_size,
    int product_buing_price,
    int product_sales_price,
    int product_profits,
  ) {
    String product_name = "${categorey_type} ${brand_name} ${product_size}";
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands_type")
        .doc(product_name)
        .set({
          "product_profits": product_profits,
          "product_name": product_name,
          "product_size": product_size,
          "product_buing_price": product_buing_price,
          "product_sales_price": product_sales_price,
          "categorey_name": categorey_name,
          "brand_name": brand_name,
        });
  }

  editBrandsType(
    String userID,
    String product_buing_price,
    String product_sales_price,
    String product_size,
    String product_name,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands_type")
        .doc(product_name)
        .update({
          "product_size": product_size,
          "product_buing_price": product_buing_price,
          "product_sales_price": product_sales_price,
        });
  }

  deleteBrandsType(String userID, String product_name) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("brands_type")
        .doc(product_name)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBrandsType(
    String userID,
    String categorey_type,
    String categorey_name,
    String brand_name,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("brands_type")
        .where("categorey_name", isEqualTo: categorey_name)
        .where("brand_name", isEqualTo: brand_name)
        .snapshots();
  }
}
