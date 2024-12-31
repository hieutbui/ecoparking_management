import 'package:ecoparking_management/data/models/employee_attendance.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetEmployeeAttendanceStatusState with EquatableMixin {
  const GetEmployeeAttendanceStatusState();

  @override
  List<Object?> get props => [];
}

class GetEmployeeAttendanceStatusInitial extends Initial
    implements GetEmployeeAttendanceStatusState {
  const GetEmployeeAttendanceStatusInitial();

  @override
  List<Object?> get props => [];
}

class GetEmployeeAttendanceStatusLoading extends Initial
    implements GetEmployeeAttendanceStatusState {
  const GetEmployeeAttendanceStatusLoading();

  @override
  List<Object?> get props => [];
}

class GetEmployeeAttendanceStatusSuccess extends Success
    implements GetEmployeeAttendanceStatusState {
  final EmployeeAttendance employeeAttendance;

  const GetEmployeeAttendanceStatusSuccess({
    required this.employeeAttendance,
  });

  @override
  List<Object?> get props => [employeeAttendance];
}

class GetEmployeeAttendanceStatusEmpty extends Success
    implements GetEmployeeAttendanceStatusState {
  const GetEmployeeAttendanceStatusEmpty();

  @override
  List<Object?> get props => [];
}

class GetEmployeeAttendanceStatusFailure extends Failure
    implements GetEmployeeAttendanceStatusState {
  final dynamic exception;

  const GetEmployeeAttendanceStatusFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
