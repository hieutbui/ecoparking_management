import 'package:ecoparking_management/data/models/employee_attendance.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class CheckOutState with EquatableMixin {
  const CheckOutState();

  @override
  List<Object?> get props => [];
}

class CheckOutInitial extends Initial implements CheckOutState {
  const CheckOutInitial();

  @override
  List<Object?> get props => [];
}

class CheckOutLoading extends Initial implements CheckOutState {
  const CheckOutLoading();

  @override
  List<Object?> get props => [];
}

class CheckOutSuccess extends Success implements CheckOutState {
  final EmployeeAttendance employeeAttendance;

  const CheckOutSuccess({
    required this.employeeAttendance,
  });

  @override
  List<Object?> get props => [
        employeeAttendance,
      ];
}

class CheckOutEmpty extends Failure implements CheckOutState {
  const CheckOutEmpty();

  @override
  List<Object?> get props => [];
}

class CheckOutFailure extends Failure implements CheckOutState {
  final dynamic exception;

  const CheckOutFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
