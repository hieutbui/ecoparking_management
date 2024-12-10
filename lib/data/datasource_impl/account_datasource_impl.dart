import 'package:ecoparking_management/data/datasource/account_datasource.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/data/supabase_data/database_function_name.dart';
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

  @override
  Future<Map<String, dynamic>?> getUserParking({
    required String userId,
  }) async {
    return Supabase.instance.client.rpc(
      DatabaseFunctionName.getParkingRolesByUser.functionName,
      params: {'user_id': userId},
    );
  }

  @override
  Future<Map<String, dynamic>> updateProfile({
    required UserProfile profile,
  }) async {
    const table = ProfileTable();

    return Supabase.instance.client
        .from(table.tableName)
        .update(profile.toJson())
        .eq(table.id, profile.id)
        .select()
        .single();
  }

  @override
  Future<void> signOut() async {
    return Supabase.instance.client.auth.signOut();
  }
}
