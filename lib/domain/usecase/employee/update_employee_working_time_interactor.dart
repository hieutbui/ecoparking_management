import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/update_employee_working_time_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class UpdateEmployeeWorkingTimeInteractor with InteractorLoggy {
  final EmployeeRepository _employeeRepository =
      getIt.get<EmployeeRepository>();

  Stream<Either<Failure, Success>> execute({
    required String employeeId,
    required String startTime,
    required String endTime,
  }) async* {
    try {
      yield const Right(UpdateEmployeeWorkingTimeLoading());

      final result = await _employeeRepository.updateEmployeeWorkingTime(
        employeeId: employeeId,
        startTime: startTime,
        endTime: endTime,
      );

      if (result.isEmpty) {
        yield const Left(UpdateEmployeeWorkingTimeEmpty());
      }

      final employee = ParkingEmployee.fromJson(result);

      yield Right(UpdateEmployeeWorkingTimeSuccess(employee: employee));
    } catch (e) {
      loggy.error('Error: $e');
      yield Left(UpdateEmployeeWorkingTimeFailure(exception: e));
    }
  }
}
