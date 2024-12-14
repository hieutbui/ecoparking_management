import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEmployeeState with EquatableMixin {
  const SearchEmployeeState();

  @override
  List<Object?> get props => [];
}

class SearchEmployeeInitial extends Initial implements SearchEmployeeState {
  const SearchEmployeeInitial() : super();

  @override
  List<Object?> get props => [];
}

class SearchEmployeeLoading extends Initial implements SearchEmployeeState {
  const SearchEmployeeLoading() : super();

  @override
  List<Object?> get props => [];
}

class SearchEmployeeSuccess extends Success implements SearchEmployeeState {
  final List<EmployeeNestedInfo> employees;

  const SearchEmployeeSuccess({required this.employees});

  @override
  List<Object?> get props => [employees];
}

class SearchEmployeeFailure extends Failure implements SearchEmployeeState {
  final dynamic exception;

  const SearchEmployeeFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class SearchEmployeeEmpty extends Failure implements SearchEmployeeState {
  const SearchEmployeeEmpty();

  @override
  List<Object?> get props => [];
}
