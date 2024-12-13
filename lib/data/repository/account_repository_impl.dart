import 'package:ecoparking_management/data/datasource/account_datasource.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountDataSource _dataSource = getIt.get<AccountDataSource>();

  @override
  Future<AuthResponse> singInWithEmail({
    required String email,
    required String password,
  }) {
    return _dataSource.singInWithEmail(email: email, password: password);
  }

  @override
  Future<Map<String, dynamic>> getUserProfile({
    required String userId,
  }) {
    return _dataSource.getUserProfile(userId: userId);
  }

  @override
  Future<Map<String, dynamic>> updateProfile({
    required UserProfile profile,
  }) {
    return _dataSource.updateProfile(profile: profile);
  }

  @override
  Future<Map<String, dynamic>> getEmployeeInfo({
    required String profileId,
  }) {
    return _dataSource.getEmployeeInfo(profileId: profileId);
  }

  @override
  Future<Map<String, dynamic>> getOwnerInfo({
    required String profileId,
  }) {
    return _dataSource.getOwnerInfo(profileId: profileId);
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }
}
