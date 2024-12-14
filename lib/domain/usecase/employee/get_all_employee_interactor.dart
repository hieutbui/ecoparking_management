import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/get_all_employee_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetAllEmployeeInteractor with InteractorLoggy {
  final EmployeeRepository _employeeRepository =
      getIt.get<EmployeeRepository>();

  Stream<Either<Failure, Success>> execute({
    required String parkingId,
  }) async* {
    try {
      yield const Right(GetAllEmployeeLoading());

      final result =
          await _employeeRepository.getAllEmployees(parkingId: parkingId);

      if (result.isEmpty) {
        yield const Left(GetAllEmployeeEmpty());
      }

      final listEmployeeInfo =
          result.map((e) => EmployeeNestedInfo.fromJson(e)).toList();

      yield Right(GetAllEmployeeSuccess(listEmployeeInfo: listEmployeeInfo));
    } catch (e) {
      loggy.error('Error: $e');
      yield Left(GetAllEmployeeFailure(exception: e));
    }
  }
}
