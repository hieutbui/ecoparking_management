import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/state/account/get_user_profile_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetUserProfileInteractor with InteractorLoggy {
  final AccountRepository _accountRepository = getIt.get<AccountRepository>();

  Stream<Either<Failure, Success>> execute({
    required String userId,
  }) async* {
    try {
      yield const Right(GetUserProfileLoading());

      final response = await _accountRepository.getUserProfile(
        userId: userId,
      );

      loggy.info('response: $response');

      if (response.isEmpty) {
        yield const Left(GetUserProfileEmpty());
        return;
      }

      yield Right(
        GetUserProfileSuccess(response: UserProfile.fromJson(response)),
      );
    } catch (e) {
      yield Left(GetUserProfileFailure(exception: e));
    }
  }
}
