import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CreateNewEmployeeState with EquatableMixin {
  const CreateNewEmployeeState();

  @override
  List<Object?> get props => [];
}

class CreateNewEmployeeInitial extends Initial
    implements CreateNewEmployeeState {
  const CreateNewEmployeeInitial() : super();

  @override
  List<Object?> get props => [];
}

class CreateNewEmployeeLoading extends Initial
    implements CreateNewEmployeeState {
  const CreateNewEmployeeLoading();

  @override
  List<Object?> get props => [];
}

class CreateNewEmployeeSuccess extends Success
    implements CreateNewEmployeeState {
  final ParkingEmployee employee;
  final User user;

  const CreateNewEmployeeSuccess({
    required this.employee,
    required this.user,
  });

  @override
  List<Object?> get props => [employee, user];
}

class CreateNewEmployeeEmpty extends Failure implements CreateNewEmployeeState {
  const CreateNewEmployeeEmpty();

  @override
  List<Object?> get props => [];
}

class CreateNewEmployeeAuthFailure extends Failure
    implements CreateNewEmployeeState {
  final AuthException exception;

  const CreateNewEmployeeAuthFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}

class CreateNewEmployeeFailure extends Failure
    implements CreateNewEmployeeState {
  final dynamic exception;

  const CreateNewEmployeeFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
