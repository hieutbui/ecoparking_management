import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/state/account/get_employee_info_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetEmployeeInfoInteractor with InteractorLoggy {
  final AccountRepository _repository = getIt.get<AccountRepository>();

  Stream<Either<Failure, Success>> execute({
    required String profileId,
  }) async* {
    try {
      yield const Right(GetEmployeeInfoLoading());

      final response = await _repository.getEmployeeInfo(
        profileId: profileId,
      );

      loggy.info('response: $response');

      if (response.isEmpty) {
        yield const Left(GetEmployeeInfoEmpty());
        return;
      }

      yield Right(
        GetEmployeeInfoSuccess(
          employeeInfo: ParkingEmployee.fromJson(response),
        ),
      );
    } catch (e) {
      loggy.error('GetEmployeeInfoInteractor error: $e');
      yield Left(GetEmployeeInfoFailure(exception: e));
    }
  }
}
