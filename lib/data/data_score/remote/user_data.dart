import 'dart:developer';
import 'package:erad/core/config/supabase_config.dart';

class UserData {
  Future<String> addUser(String email, String companyName) async {
    try {
      // Get the current authenticated user's UUID
      final currentUser = SupabaseConfig.auth.currentUser;
      if (currentUser == null) {
        throw Exception('User must be authenticated before adding to database');
      }

      final userId = currentUser.id;

      // Check if user profile already exists
      final existingUser =
          await SupabaseConfig.client
              .from('users')
              .select('id, email, company_name')
              .eq('id', userId)
              .maybeSingle();

      if (existingUser == null) {
        // Create new user profile with the authenticated user's UUID
        await SupabaseConfig.client.from('users').insert({
          'id': userId, // Use the authenticated user's UUID
          'email': email,
          'company_name': companyName,
        });

        return userId;
      } else {
        // Update existing user's company name
        await SupabaseConfig.client
            .from('users')
            .update({'company_name': companyName})
            .eq('id', userId);

        return userId;
      }
    } catch (e) {
      log('Veritabanı işlemi hatası: $e');
      rethrow;
    }
  }

  // Alternative: Simpler upsert approach
  Future<String> addUserUpsert(String email, String companyName) async {
    try {
      final currentUser = SupabaseConfig.auth.currentUser;
      if (currentUser == null) {
        throw Exception('User must be authenticated before adding to database');
      }

      final userId = currentUser.id;

      // Use upsert to insert or update in one operation
      await SupabaseConfig.client.from('users').upsert({
        'id': userId,
        'email': email,
        'company_name': companyName,
      });

      return userId;
    } catch (e) {
      log('Veritabanı işlemi hatası: $e');
      rethrow;
    }
  }

  Future<void> updateUserCompany(String userId, String companyName) async {
    try {
      await SupabaseConfig.client
          .from('users')
          .update({'company_name': companyName})
          .eq('id', userId);
    } catch (e) {
      // Ignore errors during login - company update is not critical
      log('Failed to update company: $e');
    }
  }
}
