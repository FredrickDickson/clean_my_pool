import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient supabase = SupabaseClient(
    'your-supabase-url',  // Replace with your Supabase URL
    'your-supabase-anon-key',  // Replace with your anon key
  );

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'your-supabase-url',
      anonKey: 'your-supabase-anon-key',
    );
  }

  static Future<User?> signIn({required String email, required String password}) async {
    try {
      final response = await supabase.auth.signInWithPassword(email: email, password: password);
      return response.user;
    } catch (e) {
      print('Sign-in error: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}