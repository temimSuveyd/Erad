import 'package:erad/core/config/supabase_config.dart';

class CategoreysData {
  Future<void> addCategoreys(String categoryName, String userID) async {
    try {
      await SupabaseConfig.client.from('categories').insert({
        'user_id': userID,
        'category_name': categoryName,
      });
    } catch (e) {
      print('Error adding category: $e');
      rethrow;
    }
  }

  Future<void> deleteCategorey(String categoryName, String userID) async {
    try {
      await SupabaseConfig.client
          .from('categories')
          .delete()
          .eq('category_name', categoryName)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting category: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getCategoreys(String userID) {
    return SupabaseConfig.client
        .from('categories')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.where((item) => item['user_id'] == userID).toList(),
        );
  }

  Future<void> addCategoryType(
    String categoryName,
    String userID,
    String categoryType,
  ) async {
    try {
      // First get the category ID
      final categoryResponse =
          await SupabaseConfig.client
              .from('categories')
              .select('id')
              .eq('user_id', userID)
              .eq('category_name', categoryName)
              .single();

      await SupabaseConfig.client.from('category_types').insert({
        'user_id': userID,
        'category_id': categoryResponse['id'],
        'category_type': categoryType,
        'category_name': categoryName,
      });
    } catch (e) {
      print('Error adding category type: $e');
      rethrow;
    }
  }

  Future<void> deleteCategoryType(String userID, String categoryType) async {
    try {
      await SupabaseConfig.client
          .from('category_types')
          .delete()
          .eq('category_type', categoryType)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting category type: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getCategoreysType(
    String userID,
    String categoryName,
  ) {
    return SupabaseConfig.client
        .from('category_types')
        .stream(primaryKey: ['id'])
        .map(
          (data) =>
              data
                  .where(
                    (item) =>
                        item['user_id'] == userID &&
                        item['category_name'] == categoryName,
                  )
                  .toList(),
        );
  }
}
