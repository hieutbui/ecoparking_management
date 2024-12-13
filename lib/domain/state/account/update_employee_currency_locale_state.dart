import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateEmployeeCurrencyLocaleState with EquatableMixin {
  const UpdateEmployeeCurrencyLocaleState();

  @override
  List<Object?> get props => [];
}

class UpdateEmployeeCurrencyLocaleInitial extends Initial
    implements UpdateEmployeeCurrencyLocaleState {
  const UpdateEmployeeCurrencyLocaleInitial() : super();

  @override
  List<Object?> get props => [];
}

class UpdateEmployeeCurrencyLocaleLoading extends Initial
    implements UpdateEmployeeCurrencyLocaleState {
  const UpdateEmployeeCurrencyLocaleLoading() : super();

  @override
  List<Object?> get props => [];
}

class UpdateEmployeeCurrencyLocaleSuccess extends Success
    implements UpdateEmployeeCurrencyLocaleState {
  final ParkingEmployee employee;

  const UpdateEmployeeCurrencyLocaleSuccess({required this.employee});

  @override
  List<Object?> get props => [employee];
}

class UpdateEmployeeCurrencyLocaleFailure extends Failure
    implements UpdateEmployeeCurrencyLocaleState {
  final dynamic exception;

  const UpdateEmployeeCurrencyLocaleFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class UpdateEmployeeCurrencyLocaleEmpty extends Failure
    implements UpdateEmployeeCurrencyLocaleState {
  const UpdateEmployeeCurrencyLocaleEmpty();

  @override
  List<Object?> get props => [];
}
