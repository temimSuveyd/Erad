import 'package:erad/core/config/supabase_config.dart';

class ProductData {
  Stream<List<Map<String, dynamic>>> getAllproduct(String userID) {
    return SupabaseConfig.client
        .from('products')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.where((item) => item['user_id'] == userID).toList(),
        );
  }

  Future<Map<String, dynamic>?> getBrandsTypeBayId(
    String userID,
    String productId,
  ) async {
    try {
      final response =
          await SupabaseConfig.client
              .from('products')
              .select()
              .eq('id', productId)
              .eq('user_id', userID)
              .single();
      return response;
    } catch (e) {
      print('Error getting product by ID: $e');
      return null;
    }
  }
}
