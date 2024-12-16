import 'package:ecoparking_management/data/models/parking_info.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetParkingInfoState with EquatableMixin {
  const GetParkingInfoState();

  @override
  List<Object?> get props => [];
}

class GetParkingInfoInitial extends Initial implements GetParkingInfoState {
  const GetParkingInfoInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetParkingInfoLoading extends Initial implements GetParkingInfoState {
  const GetParkingInfoLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetParkingInfoSuccess extends Success implements GetParkingInfoState {
  final ParkingInfo parkingInfo;

  const GetParkingInfoSuccess({required this.parkingInfo});

  @override
  List<Object?> get props => [parkingInfo];
}

class GetParkingInfoFailure extends Failure implements GetParkingInfoState {
  final dynamic exception;

  const GetParkingInfoFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class GetParkingInfoEmpty extends Failure implements GetParkingInfoState {
  const GetParkingInfoEmpty();

  @override
  List<Object?> get props => [];
}
