import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateUserProfileState with EquatableMixin {
  const UpdateUserProfileState();

  @override
  List<Object?> get props => [];
}

class UpdateUserProfileInitial extends Initial
    implements UpdateUserProfileState {
  const UpdateUserProfileInitial() : super();

  @override
  List<Object?> get props => [];
}

class UpdateUserProfileLoading extends Initial
    implements UpdateUserProfileState {
  const UpdateUserProfileLoading() : super();

  @override
  List<Object?> get props => [];
}

class UpdateUserProfileSuccess extends Success
    implements UpdateUserProfileState {
  final UserProfile userProfile;

  const UpdateUserProfileSuccess({
    required this.userProfile,
  });

  @override
  List<Object?> get props => [userProfile];
}

class UpdateUserProfileFailure extends Failure
    implements UpdateUserProfileState {
  final dynamic exception;

  const UpdateUserProfileFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}

class UpdateUserProfileEmpty extends Failure implements UpdateUserProfileState {
  const UpdateUserProfileEmpty() : super();

  @override
  List<Object?> get props => [];
}
