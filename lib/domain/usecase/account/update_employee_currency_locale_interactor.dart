import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/state/account/update_employee_currency_locale_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class UpdateEmployeeCurrencyLocaleInteractor with InteractorLoggy {
  final AccountRepository _repository = getIt.get<AccountRepository>();

  Stream<Either<Failure, Success>> execute({
    required String employeeId,
    required String currencyLocale,
  }) async* {
    try {
      yield const Right(UpdateEmployeeCurrencyLocaleLoading());

      final result = await _repository.updateEmployeeCurrencyLocale(
        employeeId: employeeId,
        currencyLocale: currencyLocale,
      );

      if (result.isEmpty) {
        yield const Left(UpdateEmployeeCurrencyLocaleEmpty());
      }

      yield Right(
        UpdateEmployeeCurrencyLocaleSuccess(
          employee: ParkingEmployee.fromJson(result),
        ),
      );
    } catch (e) {
      loggy.error(e);
      yield Left(UpdateEmployeeCurrencyLocaleFailure(exception: e));
    }
  }
}
