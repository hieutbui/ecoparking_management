import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/state/account/sing_out_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class SignOutInteractor with InteractorLoggy {
  final AccountRepository _accountRepository = getIt.get<AccountRepository>();

  Stream<Either<Failure, Success>> execute() async* {
    try {
      yield const Right(SignOutInitial());

      await _accountRepository.signOut();

      loggy.info('execute(): sign out success');
      yield const Right(SignOutSuccess());
    } catch (e) {
      loggy.error('execute(): sign out failure: $e');
      yield Left(SignOutFailure(exception: e));
    }
  }
}
