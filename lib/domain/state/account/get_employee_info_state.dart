import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetEmployeeInfoState with EquatableMixin {
  const GetEmployeeInfoState();

  @override
  List<Object?> get props => [];
}

class GetEmployeeInfoInitial extends Initial implements GetEmployeeInfoState {
  const GetEmployeeInfoInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetEmployeeInfoLoading extends Initial implements GetEmployeeInfoState {
  const GetEmployeeInfoLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetEmployeeInfoSuccess extends Success implements GetEmployeeInfoState {
  final ParkingEmployee employeeInfo;

  const GetEmployeeInfoSuccess({required this.employeeInfo});

  @override
  List<Object?> get props => [employeeInfo];
}

class GetEmployeeInfoEmpty extends Failure implements GetEmployeeInfoState {
  const GetEmployeeInfoEmpty();

  @override
  List<Object?> get props => [];
}

class GetEmployeeInfoFailure extends Failure implements GetEmployeeInfoState {
  final dynamic exception;

  const GetEmployeeInfoFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
