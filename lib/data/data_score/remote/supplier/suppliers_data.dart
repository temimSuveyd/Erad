import 'package:erad/core/config/supabase_config.dart';

class SuppliersData {
  Future<void> addSupplier(
    String userID,
    String suppliersName,
    String suppliersCity,
  ) async {
    try {
      await SupabaseConfig.client.from('suppliers').insert({
        'user_id': userID,
        'supplier_name': suppliersName,
        'supplier_city': suppliersCity,
      });
    } catch (e) {
      print('Error adding supplier: $e');
      rethrow;
    }
  }

  Future<void> deleteSupplier(String userID, String suppliersId) async {
    try {
      await SupabaseConfig.client
          .from('suppliers')
          .delete()
          .eq('id', suppliersId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting supplier: $e');
      rethrow;
    }
  }

  Future<void> editSupplier(
    String userID,
    String supplierName,
    String supplierCity,
    String suppliersId,
  ) async {
    try {
      await SupabaseConfig.client
          .from('suppliers')
          .update({
            'supplier_name': supplierName,
            'supplier_city': supplierCity,
          })
          .eq('id', suppliersId)
          .eq('user_id', userID);
    } catch (e) {
      print('Error editing supplier: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getAllSuppliers(String userID) {
    return SupabaseConfig.client
        .from('suppliers')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.where((item) => item['user_id'] == userID).toList(),
        );
  }

  Stream<Map<String, dynamic>?> getSupplierByID(
    String userID,
    String supplierId,
  ) {
    return SupabaseConfig.client
        .from('suppliers')
        .stream(primaryKey: ['id'])
        .map(
          (data) =>
              data
                      .where(
                        (item) =>
                            item['user_id'] == userID &&
                            item['id'] == supplierId,
                      )
                      .isNotEmpty
                  ? data.firstWhere(
                    (item) =>
                        item['user_id'] == userID && item['id'] == supplierId,
                  )
                  : null,
        );
  }
}
