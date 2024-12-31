import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/employee_attendance.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/get_employee_attendance_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetEmployeeAttendanceInteractor with InteractorLoggy {
  final EmployeeRepository _employeeRepository =
      getIt.get<EmployeeRepository>();

  Stream<Either<Failure, Success>> execute({
    required String parkingId,
    DateTime? startDate,
    DateTime? endDate,
  }) async* {
    try {
      yield const Right(GetEmployeeAttendanceLoading());

      final result = await _employeeRepository.getAttendance(
        parkingId: parkingId,
        startDate: startDate,
        endDate: endDate,
      );

      if (result == null) {
        yield const Right(GetEmployeeAttendanceEmpty());
      } else if (result.isEmpty) {
        yield const Right(GetEmployeeAttendanceSuccess(listAttendances: []));
      } else {
        final listAttendances =
            result.map((e) => EmployeeAttendance.fromJson(e)).toList();
        yield Right(
            GetEmployeeAttendanceSuccess(listAttendances: listAttendances));
      }
    } catch (e) {
      yield Left(GetEmployeeAttendanceFailure(exception: e));
    }
  }
}
