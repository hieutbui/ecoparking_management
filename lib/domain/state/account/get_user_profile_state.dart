import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetUserProfileState with EquatableMixin {
  const GetUserProfileState();

  @override
  List<Object?> get props => [];
}

class GetUserProfileInitial extends Initial implements GetUserProfileState {
  const GetUserProfileInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetUserProfileLoading extends Initial implements GetUserProfileState {
  const GetUserProfileLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetUserProfileSuccess extends Success implements GetUserProfileState {
  final UserProfile response;

  const GetUserProfileSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetUserProfileFailure extends Failure implements GetUserProfileState {
  final dynamic exception;

  const GetUserProfileFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class GetUserProfileEmpty extends Failure implements GetUserProfileState {
  const GetUserProfileEmpty();

  @override
  List<Object?> get props => [];
}
