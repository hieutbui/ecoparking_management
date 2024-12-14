import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetAllEmployeeState with EquatableMixin {
  const GetAllEmployeeState();

  @override
  List<Object?> get props => [];
}

class GetAllEmployeeInitial extends Initial implements GetAllEmployeeState {
  const GetAllEmployeeInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetAllEmployeeLoading extends Initial implements GetAllEmployeeState {
  const GetAllEmployeeLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetAllEmployeeSuccess extends Success implements GetAllEmployeeState {
  final List<EmployeeNestedInfo> listEmployeeInfo;

  const GetAllEmployeeSuccess({required this.listEmployeeInfo});

  @override
  List<Object?> get props => [listEmployeeInfo];
}

class GetAllEmployeeFailure extends Failure implements GetAllEmployeeState {
  final dynamic exception;

  const GetAllEmployeeFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class GetAllEmployeeEmpty extends Failure implements GetAllEmployeeState {
  const GetAllEmployeeEmpty();

  @override
  List<Object?> get props => [];
}
