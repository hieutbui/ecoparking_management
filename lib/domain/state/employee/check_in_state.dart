import 'package:ecoparking_management/data/models/employee_attendance.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class CheckInState with EquatableMixin {
  const CheckInState();

  @override
  List<Object?> get props => [];
}

class CheckInInitial extends Initial implements CheckInState {
  const CheckInInitial() : super();

  @override
  List<Object?> get props => [];
}

class CheckInLoading extends Initial implements CheckInState {
  const CheckInLoading() : super();

  @override
  List<Object?> get props => [];
}

class CheckInSuccess extends Success implements CheckInState {
  final EmployeeAttendance employeeAttendance;

  const CheckInSuccess({
    required this.employeeAttendance,
  });

  @override
  List<Object?> get props => [
        employeeAttendance,
      ];
}

class CheckInEmpty extends Failure implements CheckInState {
  const CheckInEmpty();

  @override
  List<Object?> get props => [];
}

class CheckInFailure extends Failure implements CheckInState {
  final dynamic exception;

  const CheckInFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
