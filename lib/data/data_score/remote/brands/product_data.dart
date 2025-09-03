import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllproduct(String userID) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("brands_type")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBrandsTypeBayId(
    String userID,
    String product_id,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("brands_type")
        .doc(product_id)
        .get();
  }
}
