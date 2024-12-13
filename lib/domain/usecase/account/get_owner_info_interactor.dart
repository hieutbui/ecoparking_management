import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/parking_owner.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/state/account/get_owner_info_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetOwnerInfoInteractor with InteractorLoggy {
  final AccountRepository _repository = getIt.get<AccountRepository>();

  Stream<Either<Failure, Success>> execute({
    required String profileId,
  }) async* {
    try {
      yield const Right(GetOwnerInfoLoading());

      final response = await _repository.getOwnerInfo(
        profileId: profileId,
      );

      loggy.info('response: $response');

      if (response.isEmpty) {
        yield const Left(GetOwnerInfoEmpty());
        return;
      }

      yield Right(
        GetOwnerInfoSuccess(
          ownerInfo: ParkingOwner.fromJson(response),
        ),
      );
    } catch (e) {
      loggy.error('GetOwnerInfoInteractor error: $e');
      yield Left(GetOwnerInfoFailure(exception: e));
    }
  }
}
