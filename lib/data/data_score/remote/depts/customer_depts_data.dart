import 'package:erad/core/constans/bill_status.dart';
import 'package:erad/core/config/supabase_config.dart';

class CustomerDeptsData {
  Future<void> addDepts(
    String customerId,
    String customerName,
    String customerCity,
    String userID,
    double totalPrice,
    DateTime billAddTime,
  ) async {
    try {
      // Check if debt already exists
      final existingDebt =
          await SupabaseConfig.client
              .from('customer_debts')
              .select('id')
              .eq('user_id', userID)
              .eq('customer_id', customerId)
              .maybeSingle();

      if (existingDebt == null) {
        await SupabaseConfig.client.from('customer_debts').insert({
          'user_id': userID,
          'customer_id': customerId,
          'customer_name': customerName,
          'customer_city': customerCity,
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
    String customerId,
    String paymentType,
    String userID,
    double totalPrice,
    DateTime billAddTime,
  ) async {
    try {
      // Get debt ID
      final debtResponse =
          await SupabaseConfig.client
              .from('customer_debts')
              .select('id')
              .eq('user_id', userID)
              .eq('customer_id', customerId)
              .single();

      await SupabaseConfig.client.from('debt_bills').insert({
        'user_id': userID,
        'debt_id': debtResponse['id'],
        'debt_type': 'customer',
        'bill_id': billId,
        'entity_id': customerId,
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
    String customerId,
    String userID,
    double totalPrice,
    DateTime paymentDate,
  ) async {
    try {
      // Get debt ID
      final debtResponse =
          await SupabaseConfig.client
              .from('customer_debts')
              .select('id')
              .eq('user_id', userID)
              .eq('customer_id', customerId)
              .single();

      await SupabaseConfig.client.from('debt_payments').insert({
        'user_id': userID,
        'debt_id': debtResponse['id'],
        'debt_type': 'customer',
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
    String customerId,
    String userID,
  ) async {
    try {
      await SupabaseConfig.client
          .from('debt_bills')
          .delete()
          .eq('bill_id', billId)
          .eq('entity_id', customerId)
          .eq('user_id', userID)
          .eq('debt_type', 'customer');
    } catch (e) {
      print('Error deleting bill from debt: $e');
      rethrow;
    }
  }

  Future<void> deletePaymentFromDepts(
    String paymentId,
    String customerId,
    String userID,
  ) async {
    try {
      await SupabaseConfig.client
          .from('debt_payments')
          .delete()
          .eq('id', paymentId)
          .eq('user_id', userID)
          .eq('debt_type', 'customer');
    } catch (e) {
      print('Error deleting payment from debt: $e');
      rethrow;
    }
  }

  Future<void> updateTotalPriceInBill(
    String billId,
    String customerId,
    String userID,
    double totalPrice,
  ) async {
    try {
      await SupabaseConfig.client
          .from('debt_bills')
          .update({'total_price': totalPrice})
          .eq('bill_id', billId)
          .eq('entity_id', customerId)
          .eq('user_id', userID)
          .eq('debt_type', 'customer');
    } catch (e) {
      print('Error updating total price in bill: $e');
      rethrow;
    }
  }

  Future<void> updateTotalDept(
    String customerId,
    String userID,
    double totalPrice,
  ) async {
    try {
      await SupabaseConfig.client
          .from('customer_debts')
          .update({'total_price': totalPrice})
          .eq('customer_id', customerId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error updating total debt: $e');
      rethrow;
    }
  }

  Future<void> deleteDepts(String customerId, String userID) async {
    try {
      // Get debt ID
      final debtResponse =
          await SupabaseConfig.client
              .from('customer_debts')
              .select('id')
              .eq('user_id', userID)
              .eq('customer_id', customerId)
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
          .from('customer_debts')
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
        .from('customer_debts')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.where((item) => item['user_id'] == userID).toList(),
        );
  }

  Stream<List<Map<String, dynamic>>> getAllPayments(
    String userID,
    String customerId,
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
                        item['debt_type'] == 'customer',
                  )
                  .toList(),
        );
  }

  Stream<List<Map<String, dynamic>>> getBillById(
    String userID,
    String customerId,
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
                        item['entity_id'] == customerId &&
                        item['debt_type'] == 'customer',
                  )
                  .toList(),
        );
  }

  Future<Map<String, dynamic>?> getDeptDetails(
    String deptId,
  ) async {
    try {

      final response =
          await SupabaseConfig.client
              .from('customer_debts')
              .select()
              .eq('id', deptId)
              .maybeSingle();
      return response;
    } catch (e) {
      return null;
    }
  }
}

// Debug method to check if debt exists by ID
Future<Map<String, dynamic>?> getDeptDetailsByDebtId(
  String userID,
  String debtId,
) async {
  try {
    final response =
        await SupabaseConfig.client
            .from('customer_debts')
            .select()
            .eq('id', debtId)
            .maybeSingle();
    return response;
  } catch (e) {
    return null;
  }
}

// Debug method to list all debts for user
Future<List<Map<String, dynamic>>> getAllDebtsForUser(String userID) async {
  try {
    print('DEBUG: Getting all debts for userID: $userID');
    final response = await SupabaseConfig.client
        .from('customer_debts')
        .select()
        .eq('user_id', userID);
    print('DEBUG: All debts for user: $response');
    return response;
  } catch (e) {
    print('Error getting all debts: $e');
    return [];
  }
}
