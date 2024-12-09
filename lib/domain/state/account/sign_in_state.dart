import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SignInState with EquatableMixin {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends Initial implements SignInState {
  const SignInInitial() : super();

  @override
  List<Object?> get props => [];
}

class SignInLoading extends Initial implements SignInState {
  const SignInLoading() : super();

  @override
  List<Object?> get props => [];
}

class SignInSuccess extends Success implements SignInState {
  final AuthResponse response;

  const SignInSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class SignInFailure extends Failure implements SignInState {
  final dynamic exception;

  const SignInFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class SignInAuthFailure extends Failure implements SignInState {
  final AuthException exception;

  const SignInAuthFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class SignInEmailEmpty extends Failure implements SignInState {
  const SignInEmailEmpty();

  @override
  List<Object?> get props => [];
}
