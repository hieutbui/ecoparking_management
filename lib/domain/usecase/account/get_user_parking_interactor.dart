import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/parking_roles.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/state/account/get_user_parking_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetUserParkingInteractor with InteractorLoggy {
  final AccountRepository _accountRepository = getIt.get<AccountRepository>();

  Stream<Either<Failure, Success>> execute({
    required String userId,
  }) async* {
    try {
      yield const Right(GetUserParkingLoading());

      final response = await _accountRepository.getUserParking(
        userId: userId,
      );

      loggy.info('response: $response');

      if (response == null || response.isEmpty) {
        yield const Left(GetUserParkingEmpty());
        return;
      }

      final List<ParkingRoles> parkingRoles = response
          .map(
            (role) => ParkingRoles.fromJson(role),
          )
          .toList();

      yield Right(
        GetUserParkingSuccess(
          userParking: parkingRoles,
        ),
      );
    } catch (e) {
      loggy.error('GetUserParkingInteractor error: $e');
      yield Left(GetUserParkingFailure(exception: e));
    }
  }
}
