import 'package:ecoparking_management/data/datasource/account_datasource.dart';
import 'package:ecoparking_management/data/supabase_data/tables/profile_table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountDataSourceImpl implements AccountDataSource {
  @override
  Future<AuthResponse> singInWithEmail({
    required String email,
    required String password,
  }) async {
    return Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<Map<String, dynamic>> getUserProfile({
    required String userId,
  }) async {
    const table = ProfileTable();

    return Supabase.instance.client
        .from(table.tableName)
        .select()
        .eq(table.id, userId)
        .single();
  }
}
