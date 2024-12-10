import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/state/account/update_user_profile_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class UpdateUserProfileInteractor with InteractorLoggy {
  final AccountRepository _accountRepository = getIt.get<AccountRepository>();

  Stream<Either<Failure, Success>> execute({
    required UserProfile userProfile,
  }) async* {
    try {
      yield const Right(UpdateUserProfileLoading());

      final response = await _accountRepository.updateProfile(
        profile: userProfile,
      );

      if (response.isEmpty) {
        yield const Left(UpdateUserProfileEmpty());
        return;
      }

      yield Right(
        UpdateUserProfileSuccess(userProfile: UserProfile.fromJson(response)),
      );
    } catch (e) {
      loggy.error('UpdateUserProfileInteractor error: $e');
      yield Left(UpdateUserProfileFailure(exception: e));
    }
  }
}
