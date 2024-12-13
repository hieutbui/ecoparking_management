import 'package:ecoparking_management/data/models/parking_owner.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateOwnerCurrencyLocaleState with EquatableMixin {
  const UpdateOwnerCurrencyLocaleState();

  @override
  List<Object?> get props => [];
}

class UpdateOwnerCurrencyLocaleInitial extends Initial
    implements UpdateOwnerCurrencyLocaleState {
  const UpdateOwnerCurrencyLocaleInitial() : super();

  @override
  List<Object?> get props => [];
}

class UpdateOwnerCurrencyLocaleLoading extends Initial
    implements UpdateOwnerCurrencyLocaleState {
  const UpdateOwnerCurrencyLocaleLoading() : super();

  @override
  List<Object?> get props => [];
}

class UpdateOwnerCurrencyLocaleSuccess extends Success
    implements UpdateOwnerCurrencyLocaleState {
  final ParkingOwner owner;

  const UpdateOwnerCurrencyLocaleSuccess({required this.owner});

  @override
  List<Object?> get props => [owner];
}

class UpdateOwnerCurrencyLocaleFailure extends Failure
    implements UpdateOwnerCurrencyLocaleState {
  final dynamic exception;

  const UpdateOwnerCurrencyLocaleFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class UpdateOwnerCurrencyLocaleEmpty extends Failure
    implements UpdateOwnerCurrencyLocaleState {
  const UpdateOwnerCurrencyLocaleEmpty();

  @override
  List<Object?> get props => [];
}
