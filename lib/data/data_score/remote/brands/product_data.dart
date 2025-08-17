import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllproduct(String user_email) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("brands_type")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBrandsTypeBayId(
    String user_email,
    String product_id,
  ) async {
    return await _firestore
        .collection("users")
        .doc(user_email)
        .collection("brands_type")
        .doc(product_id)
        .get();
  }
}
