import 'package:erad/core/config/supabase_config.dart';

class ExpensesData {
  Future<String> addExpenses(
    String userID,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    DateTime repeatDate,
    String title,
    String categoryId,
  ) async {
    try {
      final response =
          await SupabaseConfig.client
              .from('expenses')
              .insert({
                'user_id': userID,
                'category_id': categoryId,
                'date': date.toIso8601String(),
                'amount': totalAmount,
                'is_repeat_expense': isRepeatExpense,
                'repeat_date': repeatDate.toIso8601String(),
                'title': title,
              })
              .select('id')
              .single();
      return response['id'];
    } catch (e) {
      print('Error adding expense: $e');
      rethrow;
    }
  }

  Future<void> editExpenses(
    String userID,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    DateTime repeatDate,
    String title,
    String id,
    String categoryID,
  ) async {
    try {
      await SupabaseConfig.client
          .from('expenses')
          .update({
            'date': date.toIso8601String(),
            'amount': totalAmount,
            'is_repeat_expense': isRepeatExpense,
            'repeat_date': repeatDate.toIso8601String(),
            'title': title,
          })
          .eq('id', id)
          .eq('user_id', userID);
    } catch (e) {
      print('Error editing expense: $e');
      rethrow;
    }
  }

  Future<void> deleteExpenses(
    String userID,
    String id,
    String categoryID,
  ) async {
    try {
      await SupabaseConfig.client
          .from('expenses')
          .delete()
          .eq('id', id)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting expense: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getExpenses(
    String userID,
    String categoryID,
  ) {
    return SupabaseConfig.client
        .from('expenses')
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

  // expenses category
  Future<String> addExpensesCategory(String userID, String title) async {
    try {
      final response =
          await SupabaseConfig.client
              .from('expense_categories')
              .insert({'user_id': userID, 'title': title})
              .select('id')
              .single();
      return response['id'];
    } catch (e) {
      print('Error adding expense category: $e');
      rethrow;
    }
  }

  Future<void> editExpensesCategory(
    String userID,
    String title,
    String id,
  ) async {
    try {
      await SupabaseConfig.client
          .from('expense_categories')
          .update({'title': title})
          .eq('id', id)
          .eq('user_id', userID);
    } catch (e) {
      print('Error editing expense category: $e');
      rethrow;
    }
  }

  Future<void> deleteExpensesCategory(String userID, String id) async {
    try {
      // Delete all expenses in this category first
      await SupabaseConfig.client
          .from('expenses')
          .delete()
          .eq('category_id', id)
          .eq('user_id', userID);

      // Delete the category
      await SupabaseConfig.client
          .from('expense_categories')
          .delete()
          .eq('id', id)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting expense category: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getExpensesCategory(String userID) {
    return SupabaseConfig.client
        .from('expense_categories')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.where((item) => item['user_id'] == userID).toList(),
        );
  }
}
