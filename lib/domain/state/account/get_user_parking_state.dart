import 'package:ecoparking_management/data/models/parking_roles.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

class GetUserParkingState with EquatableMixin {
  const GetUserParkingState();

  @override
  List<Object?> get props => [];
}

class GetUserParkingInitial extends Initial implements GetUserParkingState {
  const GetUserParkingInitial();

  @override
  List<Object?> get props => [];
}

class GetUserParkingLoading extends Initial implements GetUserParkingState {
  const GetUserParkingLoading();

  @override
  List<Object?> get props => [];
}

class GetUserParkingSuccess extends Success implements GetUserParkingState {
  final ParkingRoles userParking;

  const GetUserParkingSuccess({
    required this.userParking,
  });

  @override
  List<Object?> get props => [userParking];
}

class GetUserParkingEmpty extends Failure implements GetUserParkingState {
  const GetUserParkingEmpty();

  @override
  List<Object?> get props => [];
}

class GetUserParkingFailure extends Failure implements GetUserParkingState {
  final dynamic exception;

  const GetUserParkingFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
