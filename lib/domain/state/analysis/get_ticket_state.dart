import 'package:ecoparking_management/data/models/ticket_info.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetTicketState with EquatableMixin {
  const GetTicketState();

  @override
  List<Object?> get props => [];
}

class GetTicketInitial extends Initial implements GetTicketState {
  const GetTicketInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetTicketLoading extends Initial implements GetTicketState {
  const GetTicketLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetTicketSuccess extends Success implements GetTicketState {
  final List<TicketInfo> tickets;

  const GetTicketSuccess({required this.tickets});

  @override
  List<Object?> get props => [tickets];
}

class GetTicketFailure extends Failure implements GetTicketState {
  final dynamic exception;

  const GetTicketFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class GetTicketEmpty extends Success implements GetTicketState {
  const GetTicketEmpty();

  @override
  List<Object?> get props => [];
}
