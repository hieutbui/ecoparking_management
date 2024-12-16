import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetCurrentEmployeeState with EquatableMixin {
  const GetCurrentEmployeeState();

  @override
  List<Object?> get props => [];
}

class GetCurrentEmployeeInitial extends Initial
    implements GetCurrentEmployeeState {
  const GetCurrentEmployeeInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetCurrentEmployeeLoading extends Initial
    implements GetCurrentEmployeeState {
  const GetCurrentEmployeeLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetCurrentEmployeeSuccess extends Success
    implements GetCurrentEmployeeState {
  final List<EmployeeNestedInfo> employees;

  const GetCurrentEmployeeSuccess({required this.employees});

  @override
  List<Object?> get props => [employees];
}

class GetCurrentEmployeeFailure extends Failure
    implements GetCurrentEmployeeState {
  final dynamic exception;

  const GetCurrentEmployeeFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class GetCurrentEmployeeEmpty extends Success
    implements GetCurrentEmployeeState {
  const GetCurrentEmployeeEmpty();

  @override
  List<Object?> get props => [];
}
