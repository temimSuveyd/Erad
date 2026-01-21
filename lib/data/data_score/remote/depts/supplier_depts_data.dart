import 'package:erad/core/constans/bill_status.dart';
import 'package:erad/core/config/supabase_config.dart';

class SupplierDeptsData {
  Future<void> addDepts(
    String supplierId,
    String supplierName,
    String supplierCity,
    String userID,
    double totalPrice,
    DateTime billAddTime,
  ) async {
    try {
      // Check if debt already exists
      final existingDebt =
          await SupabaseConfig.client
              .from('supplier_debts')
              .select('id')
              .eq('user_id', userID)
              .eq('supplier_id', supplierId)
              .maybeSingle();

      if (existingDebt == null) {
        await SupabaseConfig.client.from('supplier_debts').insert({
          'user_id': userID,
          'supplier_id': supplierId,
          'supplier_name': supplierName,
          'supplier_city': supplierCity,
          'total_price': totalPrice,
          'bill_date': billAddTime.toIso8601String(),
        });
      }
    } catch (e) {
      print('Error adding debt: $e');
      rethrow;
    }
  }

  Future<void> addBillToDepts(
    String billNo,
    String billId,
    String supplierId,
    String paymentType,
    String userID,
    double totalPrice,
    DateTime billAddTime,
  ) async {
    try {
      // Get debt ID
      final debtResponse =
          await SupabaseConfig.client
              .from('supplier_debts')
              .select('id')
              .eq('user_id', userID)
              .eq('supplier_id', supplierId)
              .single();

      await SupabaseConfig.client.from('debt_bills').insert({
        'user_id': userID,
        'debt_id': debtResponse['id'],
        'debt_type': 'supplier',
        'bill_id': billId,
        'entity_id': supplierId,
        'total_price': totalPrice,
        'bill_date': billAddTime.toIso8601String(),
        'payment_type': paymentType,
        'bill_no': billNo,
        'bill_status': BillStatus.itwasFormed,
      });
    } catch (e) {
      print('Error adding bill to debt: $e');
      rethrow;
    }
  }

  Future<void> addPaymentToDepts(
    String supplierId,
    String userID,
    double totalPrice,
    DateTime paymentDate,
  ) async {
    try {
      // Get debt ID
      final debtResponse =
          await SupabaseConfig.client
              .from('supplier_debts')
              .select('id')
              .eq('user_id', userID)
              .eq('supplier_id', supplierId)
              .single();

      await SupabaseConfig.client.from('debt_payments').insert({
        'user_id': userID,
        'debt_id': debtResponse['id'],
        'debt_type': 'supplier',
        'payment_date': paymentDate.toIso8601String(),
        'total_price': totalPrice,
      });
    } catch (e) {
      print('Error adding payment to debt: $e');
      rethrow;
    }
  }

  Future<void> deleteBillFromDepts(
    String billId,
    String supplierId,
    String userID,
  ) async {
    try {
      await SupabaseConfig.client
          .from('debt_bills')
          .delete()
          .eq('bill_id', billId)
          .eq('entity_id', supplierId)
          .eq('user_id', userID)
          .eq('debt_type', 'supplier');
    } catch (e) {
      print('Error deleting bill from debt: $e');
      rethrow;
    }
  }

  Future<void> deletePaymentFromDepts(
    String paymentId,
    String supplierId,
    String userID,
  ) async {
    try {
      await SupabaseConfig.client
          .from('debt_payments')
          .delete()
          .eq('id', paymentId)
          .eq('user_id', userID)
          .eq('debt_type', 'supplier');
    } catch (e) {
      print('Error deleting payment from debt: $e');
      rethrow;
    }
  }

  Future<void> updateTotalPriceInBill(
    String billId,
    String supplierId,
    String userID,
    double totalPrice,
  ) async {
    try {
      await SupabaseConfig.client
          .from('debt_bills')
          .update({'total_price': totalPrice})
          .eq('bill_id', billId)
          .eq('entity_id', supplierId)
          .eq('user_id', userID)
          .eq('debt_type', 'supplier');
    } catch (e) {
      print('Error updating total price in bill: $e');
      rethrow;
    }
  }

  Future<void> updateTotalDept(
    String supplierId,
    String userID,
    double totalPrice,
  ) async {
    try {
      await SupabaseConfig.client
          .from('supplier_debts')
          .update({'total_price': totalPrice})
          .eq('supplier_id', supplierId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error updating total debt: $e');
      rethrow;
    }
  }

  Future<void> deleteDepts(String supplierId, String userID) async {
    try {
      // Get debt ID
      final debtResponse =
          await SupabaseConfig.client
              .from('supplier_debts')
              .select('id')
              .eq('user_id', userID)
              .eq('supplier_id', supplierId)
              .single();

      final debtId = debtResponse['id'];

      // Delete all bills and payments
      await SupabaseConfig.client
          .from('debt_bills')
          .delete()
          .eq('debt_id', debtId)
          .eq('user_id', userID);

      await SupabaseConfig.client
          .from('debt_payments')
          .delete()
          .eq('debt_id', debtId)
          .eq('user_id', userID);

      // Delete the debt
      await SupabaseConfig.client
          .from('supplier_debts')
          .delete()
          .eq('id', debtId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting debt: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getAllDepts(String userID) {
    return SupabaseConfig.client
        .from('supplier_debts')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.where((item) => item['user_id'] == userID).toList(),
        );
  }

  Stream<List<Map<String, dynamic>>> getAllPayments(
    String userID,
    String supplierId,
  ) {
    return SupabaseConfig.client
        .from('debt_payments')
        .stream(primaryKey: ['id'])
        .map(
          (data) =>
              data
                  .where(
                    (item) =>
                        item['user_id'] == userID &&
                        item['debt_type'] == 'supplier',
                  )
                  .toList(),
        );
  }

  Stream<List<Map<String, dynamic>>> getBillById(
    String userID,
    String supplierId,
  ) {
    return SupabaseConfig.client
        .from('debt_bills')
        .stream(primaryKey: ['id'])
        .map(
          (data) =>
              data
                  .where(
                    (item) =>
                        item['user_id'] == userID &&
                        item['entity_id'] == supplierId &&
                        item['debt_type'] == 'supplier',
                  )
                  .toList(),
        );
  }

  Future<Map<String, dynamic>?> getDeptDetails(
    String userID,
    String supplierId,
  ) async {
    try {
      final response =
          await SupabaseConfig.client
              .from('supplier_debts')
              .select()
              .eq('user_id', userID)
              .eq('supplier_id', supplierId)
              .single();
      return response;
    } catch (e) {
      print('Error getting debt details: $e');
      return null;
    }
  }
}
