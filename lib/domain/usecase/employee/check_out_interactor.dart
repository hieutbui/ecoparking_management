import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/employee_attendance.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/check_out_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckOutInteractor with InteractorLoggy {
  final EmployeeRepository _employeeRepository =
      getIt.get<EmployeeRepository>();

  Stream<Either<Failure, Success>> execute({
    required String employeeId,
    required String parkingId,
    required TimeOfDay clockOut,
    required DateTime date,
  }) async* {
    try {
      yield const Right(CheckOutLoading());

      final dateFormatter = DateFormat('yyyy-MM-dd');

      final result = await _employeeRepository.checkOut(
        employeeId: employeeId,
        parkingId: parkingId,
        clockOut: '${clockOut.hour}:${clockOut.minute}',
        date: dateFormatter.format(date),
      );

      if (result.isEmpty) {
        yield const Left(CheckOutEmpty());
      } else {
        final employeeAttendance = EmployeeAttendance.fromJson(result);

        yield Right(CheckOutSuccess(employeeAttendance: employeeAttendance));
      }
    } catch (e) {
      yield Left(CheckOutFailure(exception: e));
    }
  }
}
