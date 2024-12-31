import 'package:ecoparking_management/data/models/employee_attendance.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetEmployeeAttendanceState with EquatableMixin {
  const GetEmployeeAttendanceState();

  @override
  List<Object?> get props => [];
}

class GetEmployeeAttendanceInitial extends Initial
    implements GetEmployeeAttendanceState {
  const GetEmployeeAttendanceInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetEmployeeAttendanceLoading extends Initial
    implements GetEmployeeAttendanceState {
  const GetEmployeeAttendanceLoading();

  @override
  List<Object?> get props => [];
}

class GetEmployeeAttendanceSuccess extends Success
    implements GetEmployeeAttendanceState {
  final List<EmployeeAttendance> listAttendances;

  const GetEmployeeAttendanceSuccess({
    required this.listAttendances,
  });

  @override
  List<Object?> get props => [
        listAttendances,
      ];
}

class GetEmployeeAttendanceEmpty extends Success
    implements GetEmployeeAttendanceState {
  const GetEmployeeAttendanceEmpty();

  @override
  List<Object?> get props => [];
}

class GetEmployeeAttendanceFailure extends Failure
    implements GetEmployeeAttendanceState {
  final dynamic exception;

  const GetEmployeeAttendanceFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [
        exception,
      ];
}
