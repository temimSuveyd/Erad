import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String projectUrl = 'https://aylawixsviaggmsufyno.supabase.co';
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF5bGF3aXhzdmlhZ2dtc3VmeW5vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgxMjI5NzAsImV4cCI6MjA4MzY5ODk3MH0.CoagUT2P1xPkOUxZ-1Wy37fS2uhiHAoTbh5SGUZAwIM';

  static Future<void> initialize() async {
    await Supabase.initialize(url: projectUrl, anonKey: anonKey, debug: false);
  }

  static SupabaseClient get client => Supabase.instance.client;
  static GoTrueClient get auth => Supabase.instance.client.auth;
}
