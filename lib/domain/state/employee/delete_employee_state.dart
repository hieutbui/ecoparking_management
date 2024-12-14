import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class DeleteEmployeeState with EquatableMixin {
  const DeleteEmployeeState();

  @override
  List<Object?> get props => [];
}

class DeleteEmployeeInitial extends Initial implements DeleteEmployeeState {
  const DeleteEmployeeInitial() : super();

  @override
  List<Object?> get props => [];
}

class DeleteEmployeeLoading extends Initial implements DeleteEmployeeState {
  const DeleteEmployeeLoading() : super();

  @override
  List<Object?> get props => [];
}

class DeleteEmployeeSuccess extends Success implements DeleteEmployeeState {
  final List<ParkingEmployee> employee;

  const DeleteEmployeeSuccess({required this.employee});

  @override
  List<Object?> get props => [employee];
}

class DeleteEmployeeFailure extends Failure implements DeleteEmployeeState {
  final dynamic exception;

  const DeleteEmployeeFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class DeleteEmployeeEmpty extends Failure implements DeleteEmployeeState {
  const DeleteEmployeeEmpty();

  @override
  List<Object?> get props => [];
}
