import 'package:ecoparking_management/data/datasource/account_datasource.dart';
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
}
