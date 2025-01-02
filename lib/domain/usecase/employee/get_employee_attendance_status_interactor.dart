import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/employee_attendance.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/get_employee_attendance_status_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetEmployeeAttendanceStatusInteractor with InteractorLoggy {
  final EmployeeRepository _employeeRepository =
      getIt.get<EmployeeRepository>();

  Stream<Either<Failure, Success>> execute({
    required String employeeId,
  }) async* {
    try {
      yield const Right(GetEmployeeAttendanceStatusLoading());

      final result = await _employeeRepository.getEmployeeAttendance(
        employeeId: employeeId,
      );

      if (result == null || result.isEmpty) {
        yield const Right(GetEmployeeAttendanceStatusEmpty());
      } else {
        final employeeAttendance = EmployeeAttendance.fromJson(result);

        yield Right(GetEmployeeAttendanceStatusSuccess(
          employeeAttendance: employeeAttendance,
        ));
      }
    } catch (e) {
      yield Left(GetEmployeeAttendanceStatusFailure(exception: e));
    }
  }
}