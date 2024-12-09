import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AccountRepository {
  Future<AuthResponse> singInWithEmail({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> getUserProfile({
    required String userId,
  });
}
