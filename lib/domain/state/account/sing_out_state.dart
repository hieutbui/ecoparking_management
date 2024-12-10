import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class SignOutState with EquatableMixin {
  const SignOutState();

  @override
  List<Object?> get props => [];
}

class SignOutInitial extends Initial implements SignOutState {
  const SignOutInitial() : super();

  @override
  List<Object?> get props => [];
}

class SignOutSuccess extends Success implements SignOutState {
  const SignOutSuccess() : super();

  @override
  List<Object?> get props => [];
}

class SignOutFailure extends Failure implements SignOutState {
  final dynamic exception;

  const SignOutFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
