import 'package:erad/core/constans/bill_status.dart';
import 'package:erad/core/config/supabase_config.dart';

class SupplierBillData {
  Future<String> addSupplierBill(
    String supplierName,
    String supplierCity,
    String supplierId,
    String paymentType,
    String userID,
    DateTime billAddTime,
  ) async {
    try {
      final response =
          await SupabaseConfig.client
              .from('supplier_bills')
              .insert({
                'user_id': userID,
                'supplier_id': supplierId,
                'supplier_name': supplierName,
                'supplier_city': supplierCity,
                'total_product_price': 0,
                'total_profits': 0,
                'bill_date': billAddTime.toIso8601String(),
                'payment_type': paymentType,
                'bill_no': '',
                'bill_status': BillStatus.itwasFormed,
                'discount_amount': 0,
              })
              .select('id')
              .single();
      return response['id'];
    } catch (e) {
      print('Error adding supplier bill: $e');
      rethrow;
    }
  }

  Future<void> addDiscount(
    String billId,
    String userID,
    double discountAmount,
  ) async {
    try {
      // Get current discount amount
      final currentBill =
          await SupabaseConfig.client
              .from('supplier_bills')
              .select('discount_amount')
              .eq('id', billId)
              .eq('user_id', userID)
              .single();

      final currentDiscount =
          (currentBill['discount_amount'] as num).toDouble();
      final newDiscount = currentDiscount + discountAmount;

      await SupabaseConfig.client
          .from('supplier_bills')
          .update({'discount_amount': newDiscount})
          .eq('id', billId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error adding discount: $e');
      rethrow;
    }
  }

  Future<void> addProductToBill(
    String productName,
    int productPrice,
    String productId,
    int productNumber,
    int totalProductPrice,
    int totalProductProfits,
    int productProfits,
    String userID,
    String billId,
  ) async {
    try {
      await SupabaseConfig.client.from('bill_products').insert({
        'user_id': userID,
        'bill_id': billId,
        'bill_type': 'supplier',
        'product_id': productId,
        'product_name': productName,
        'product_price': productPrice,
        'product_number': productNumber,
        'total_product_price': totalProductPrice,
        'total_product_profits': totalProductProfits,
        'product_profits': productProfits,
      });
    } catch (e) {
      print('Error adding product to bill: $e');
      rethrow;
    }
  }

  Future<void> deleteSupplierBill(String userID, String billId) async {
    try {
      // Delete all products first
      await SupabaseConfig.client
          .from('bill_products')
          .delete()
          .eq('bill_id', billId)
          .eq('user_id', userID)
          .eq('bill_type', 'supplier');

      // Delete the bill
      await SupabaseConfig.client
          .from('supplier_bills')
          .delete()
          .eq('id', billId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting supplier bill: $e');
      rethrow;
    }
  }

  Future<void> updateSupplierBill(
    String userID,
    String billId,
    String billNo,
    double totalPrice,
    double totalProfits,
  ) async {
    try {
      await SupabaseConfig.client
          .from('supplier_bills')
          .update({
            'total_product_price': totalPrice,
            'total_profits': totalProfits,
            'bill_no': billNo,
          })
          .eq('id', billId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error updating supplier bill: $e');
      rethrow;
    }
  }

  Future<void> updateTotalPrice(
    String userID,
    String billId,
    double totalPrice,
    double totalProfits,
  ) async {
    try {
      await SupabaseConfig.client
          .from('supplier_bills')
          .update({
            'total_product_price': totalPrice,
            'total_profits': totalProfits,
          })
          .eq('id', billId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error updating total price: $e');
      rethrow;
    }
  }

  Future<void> updateProductData(
    String productId,
    int productNumber,
    int totalProductPrice,
    String userID,
    String billId,
  ) async {
    try {
      await SupabaseConfig.client
          .from('bill_products')
          .update({
            'product_number': productNumber,
            'total_product_price': totalProductPrice,
          })
          .eq('id', productId)
          .eq('bill_id', billId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error updating product data: $e');
      rethrow;
    }
  }

  Future<void> updateBillStatus(
    String userID,
    String billId,
    String billStatus,
  ) async {
    try {
      await SupabaseConfig.client
          .from('supplier_bills')
          .update({'bill_status': billStatus})
          .eq('id', billId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error updating bill status: $e');
      rethrow;
    }
  }

  Future<void> updatePaymentType(
    String userID,
    String billId,
    String paymentType,
  ) async {
    try {
      await SupabaseConfig.client
          .from('supplier_bills')
          .update({'payment_type': paymentType})
          .eq('id', billId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error updating payment type: $e');
      rethrow;
    }
  }

  Future<void> deleteProduct(
    String billId,
    String productId,
    String userID,
  ) async {
    try {
      await SupabaseConfig.client
          .from('bill_products')
          .delete()
          .eq('id', productId)
          .eq('bill_id', billId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting product: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getBillProducts(
    String userID,
    String billId,
  ) {
    return SupabaseConfig.client
        .from('bill_products')
        .stream(primaryKey: ['id'])
        .map(
          (data) =>
              data
                  .where(
                    (item) =>
                        item['user_id'] == userID &&
                        item['bill_id'] == billId &&
                        item['bill_type'] == 'supplier',
                  )
                  .toList(),
        );
  }

  Future<Map<String, dynamic>?> getBillProductById(
    String userID,
    String billId,
    String productId,
  ) async {
    try {
      final response =
          await SupabaseConfig.client
              .from('bill_products')
              .select()
              .eq('id', productId)
              .eq('bill_id', billId)
              .eq('user_id', userID)
              .single();
      return response;
    } catch (e) {
      print('Error getting bill product by ID: $e');
      return null;
    }
  }

  Stream<List<Map<String, dynamic>>> getAllBills(String userID) {
    return SupabaseConfig.client
        .from('supplier_bills')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.where((item) => item['user_id'] == userID).toList(),
        );
  }

  Future<Map<String, dynamic>?> getBillById(
    String userID,
    String billId,
  ) async {
    try {
      final response =
          await SupabaseConfig.client
              .from('supplier_bills')
              .select()
              .eq('id', billId)
              .eq('user_id', userID)
              .single();
      return response;
    } catch (e) {
      print('Error getting bill by ID: $e');
      return null;
    }
  }
}
