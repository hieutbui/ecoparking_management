import 'package:ecoparking_management/data/models/parking_owner.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetOwnerInfoState with EquatableMixin {
  const GetOwnerInfoState();

  @override
  List<Object?> get props => [];
}

class GetOwnerInfoInitial extends Initial implements GetOwnerInfoState {
  const GetOwnerInfoInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetOwnerInfoLoading extends Initial implements GetOwnerInfoState {
  const GetOwnerInfoLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetOwnerInfoSuccess extends Success implements GetOwnerInfoState {
  final ParkingOwner ownerInfo;

  const GetOwnerInfoSuccess({required this.ownerInfo});

  @override
  List<Object?> get props => [ownerInfo];
}

class GetOwnerInfoEmpty extends Failure implements GetOwnerInfoState {
  const GetOwnerInfoEmpty();

  @override
  List<Object?> get props => [];
}

class GetOwnerInfoFailure extends Failure implements GetOwnerInfoState {
  final dynamic exception;

  const GetOwnerInfoFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
