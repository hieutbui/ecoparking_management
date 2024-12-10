import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AccountRepository {
  Future<AuthResponse> singInWithEmail({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> getUserProfile({
    required String userId,
  });

  Future<Map<String, dynamic>?> getUserParking({
    required String userId,
  });

  Future<Map<String, dynamic>> updateProfile({
    required UserProfile profile,
  });

  Future<void> signOut();
}
