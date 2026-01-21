import 'package:erad/core/config/supabase_config.dart';

class WithdrawnFundData {
  Future<String> addWithdrawnFund(
    String userID,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    DateTime repeatDate,
    String userName,
    String categoryId,
  ) async {
    try {
      final response =
          await SupabaseConfig.client
              .from('withdrawn_funds')
              .insert({
                'user_id': userID,
                'category_id': categoryId,
                'date': date.toIso8601String(),
                'amount': totalAmount,
                'is_repeat_withdrawn_fund': isRepeatExpense,
                'repeat_date': repeatDate.toIso8601String(),
                'user_name': userName,
              })
              .select('id')
              .single();
      return response['id'];
    } catch (e) {
      print('Error adding withdrawn fund: $e');
      rethrow;
    }
  }

  Future<void> editWithdrawnFund(
    String userID,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    DateTime repeatDate,
    String id,
    String categoryID,
  ) async {
    try {
      await SupabaseConfig.client
          .from('withdrawn_funds')
          .update({
            'date': date.toIso8601String(),
            'amount': totalAmount,
            'is_repeat_withdrawn_fund': isRepeatExpense,
            'repeat_date': repeatDate.toIso8601String(),
          })
          .eq('id', id)
          .eq('user_id', userID);
    } catch (e) {
      print('Error editing withdrawn fund: $e');
      rethrow;
    }
  }

  Future<void> deleteWithdrawnFund(
    String userID,
    String id,
    String categoryID,
  ) async {
    try {
      await SupabaseConfig.client
          .from('withdrawn_funds')
          .delete()
          .eq('id', id)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting withdrawn fund: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getWithdrawnFund(
    String userID,
    String categoryID,
  ) {
    return SupabaseConfig.client
        .from('withdrawn_funds')
        .stream(primaryKey: ['id'])
        .map(
          (data) =>
              data
                  .where(
                    (item) =>
                        item['user_id'] == userID &&
                        item['category_id'] == categoryID,
                  )
                  .toList(),
        );
  }

  // withdrawn fund category
  Future<String> addWithdrawnFundCategory(
    String userID,
    String userName,
  ) async {
    try {
      final response =
          await SupabaseConfig.client
              .from('withdrawn_fund_categories')
              .insert({'user_id': userID, 'user_name': userName})
              .select('id')
              .single();
      return response['id'];
    } catch (e) {
      print('Error adding withdrawn fund category: $e');
      rethrow;
    }
  }

  Future<void> editWithdrawnFundCategory(
    String userID,
    String userName,
    String id,
  ) async {
    try {
      await SupabaseConfig.client
          .from('withdrawn_fund_categories')
          .update({'user_name': userName})
          .eq('id', id)
          .eq('user_id', userID);
    } catch (e) {
      print('Error editing withdrawn fund category: $e');
      rethrow;
    }
  }

  Future<void> deleteWithdrawnFundCategory(String userID, String id) async {
    try {
      // Delete all withdrawn funds in this category first
      await SupabaseConfig.client
          .from('withdrawn_funds')
          .delete()
          .eq('category_id', id)
          .eq('user_id', userID);

      // Delete the category
      await SupabaseConfig.client
          .from('withdrawn_fund_categories')
          .delete()
          .eq('id', id)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting withdrawn fund category: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getWithdrawnFundCategory(String userID) {
    return SupabaseConfig.client
        .from('withdrawn_fund_categories')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.where((item) => item['user_id'] == userID).toList(),
        );
  }
}
