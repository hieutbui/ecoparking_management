import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/state/account/sign_in_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInInteractor with InteractorLoggy {
  final AccountRepository _accountRepository = getIt.get<AccountRepository>();

  Stream<Either<Failure, Success>> execute({
    required String email,
    required String password,
  }) async* {
    try {
      yield const Right(SignInLoading());

      if (email.isEmpty || password.isEmpty) {
        yield const Left(SignInEmailEmpty());
        return;
      }

      final response = await _accountRepository.singInWithEmail(
        email: email,
        password: password,
      );

      yield Right(SignInSuccess(response: response));
    } on AuthException catch (e) {
      loggy.error('SignInInteractor error: $e');
      yield Left(SignInAuthFailure(exception: e));
    } catch (e) {
      loggy.error('SignInInteractor error: $e');
      yield Left(SignInFailure(exception: e));
    }
  }
}
