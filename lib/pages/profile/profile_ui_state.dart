import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileUIState with EquatableMixin {
  const ProfileUIState();

  @override
  List<Object?> get props => [];
}

class ProfileUIInitial extends ProfileUIState {
  const ProfileUIInitial();

  @override
  List<Object?> get props => [];
}

class ProfileUIEmptyProfile extends ProfileUIState {
  const ProfileUIEmptyProfile();

  @override
  List<Object?> get props => [];
}

class ProfileUIAuthenticated extends ProfileUIState {
  final UserProfile userProfile;

  const ProfileUIAuthenticated({
    required this.userProfile,
  });

  @override
  List<Object?> get props => [userProfile];
}
