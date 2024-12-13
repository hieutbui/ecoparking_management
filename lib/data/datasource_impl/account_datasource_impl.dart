import 'package:ecoparking_management/data/datasource/account_datasource.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/data/supabase_data/tables/parking_employee_table.dart';
import 'package:ecoparking_management/data/supabase_data/tables/parking_owner_table.dart';
import 'package:ecoparking_management/data/supabase_data/tables/parking_table.dart';
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
  Future<Map<String, dynamic>> getEmployeeInfo({
    required String profileId,
  }) async {
    const table = ParkingEmployeeTable();
    const parkingTable = ParkingTable();

    final queryString = '*, parking(${parkingTable.name})';

    return Supabase.instance.client
        .from(table.tableName)
        .select(queryString)
        .eq(table.profileId, profileId)
        .single();
  }

  @override
  Future<Map<String, dynamic>> getOwnerInfo({
    required String profileId,
  }) async {
    const table = ParkingOwnerTable();
    const parkingTable = ParkingTable();

    final queryString = '*, parking(${parkingTable.name})';

    return Supabase.instance.client
        .from(table.tableName)
        .select(queryString)
        .eq(table.profileId, profileId)
        .single();
  }

  @override
  Future<Map<String, dynamic>> updateEmployeeCurrencyLocale({
    required String employeeId,
    required String currencyLocale,
  }) async {
    const table = ParkingEmployeeTable();

    return Supabase.instance.client
        .from(table.tableName)
        .update({table.currencyLocale: currencyLocale})
        .eq(table.id, employeeId)
        .select()
        .single();
  }

  @override
  Future<Map<String, dynamic>> updateOwnerCurrencyLocale({
    required String ownerId,
    required String currencyLocale,
  }) async {
    const table = ParkingOwnerTable();

    return Supabase.instance.client
        .from(table.tableName)
        .update({table.currencyLocale: currencyLocale})
        .eq(table.id, ownerId)
        .select()
        .single();
  }

  @override
  Future<void> signOut() async {
    return Supabase.instance.client.auth.signOut();
  }
}
