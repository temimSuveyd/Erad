import 'package:erad/core/config/supabase_config.dart';

class CustomersData {
  Future<void> addCustomer(
    String userID,
    String customerName,
    String customerCity,
  ) async {
    try {
      await SupabaseConfig.client.from('customers').insert({
        'user_id': userID,
        'customer_name': customerName,
        'customer_city': customerCity,
      });
    } catch (e) {
      print('Error adding customer: $e');
      rethrow;
    }
  }

  Future<void> deleteCustomer(String userID, String customerId) async {
    try {
      await SupabaseConfig.client
          .from('customers')
          .delete()
          .eq('id', customerId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting customer: $e');
      rethrow;
    }
  }

  Future<void> editCustomer(
    String userID,
    String customerName,
    String customerCity,
    String customerId,
  ) async {
    try {
      await SupabaseConfig.client
          .from('customers')
          .update({
            'customer_name': customerName,
            'customer_city': customerCity,
          })
          .eq('id', customerId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error editing customer: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getAllCustomers(String userID) {
    return SupabaseConfig.client
        .from('customers')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.where((item) => item['user_id'] == userID).toList(),
        );
  }

  Stream<Map<String, dynamic>?> getCustomerByID(
    String userID,
    String customerId,
  ) {
    return SupabaseConfig.client
        .from('customers')
        .stream(primaryKey: ['id'])
        .map(
          (data) =>
              data
                      .where(
                        (item) =>
                            item['user_id'] == userID &&
                            item['id'] == customerId,
                      )
                      .isNotEmpty
                  ? data.firstWhere(
                    (item) =>
                        item['user_id'] == userID && item['id'] == customerId,
                  )
                  : null,
        );
  }
}
