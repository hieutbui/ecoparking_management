import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateEmployeeWorkingTimeState with EquatableMixin {
  const UpdateEmployeeWorkingTimeState();

  @override
  List<Object?> get props => [];
}

class UpdateEmployeeWorkingTimeInitial extends Initial
    implements UpdateEmployeeWorkingTimeState {
  const UpdateEmployeeWorkingTimeInitial() : super();

  @override
  List<Object?> get props => [];
}

class UpdateEmployeeWorkingTimeLoading extends Initial
    implements UpdateEmployeeWorkingTimeState {
  const UpdateEmployeeWorkingTimeLoading() : super();

  @override
  List<Object?> get props => [];
}

class UpdateEmployeeWorkingTimeSuccess extends Success
    implements UpdateEmployeeWorkingTimeState {
  final ParkingEmployee employee;

  const UpdateEmployeeWorkingTimeSuccess({required this.employee});

  @override
  List<Object?> get props => [employee];
}

class UpdateEmployeeWorkingTimeFailure extends Failure
    implements UpdateEmployeeWorkingTimeState {
  final dynamic exception;

  const UpdateEmployeeWorkingTimeFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class UpdateEmployeeWorkingTimeEmpty extends Failure
    implements UpdateEmployeeWorkingTimeState {
  const UpdateEmployeeWorkingTimeEmpty();

  @override
  List<Object?> get props => [];
}
