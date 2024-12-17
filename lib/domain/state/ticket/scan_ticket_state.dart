import 'package:ecoparking_management/data/models/ticket_info.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class ScanTicketState with EquatableMixin {
  const ScanTicketState();

  @override
  List<Object?> get props => [];
}

class ScanTicketInitial extends Initial implements ScanTicketState {
  const ScanTicketInitial();

  @override
  List<Object?> get props => [];
}

class ScanTicketLoading extends Initial implements ScanTicketState {
  const ScanTicketLoading();

  @override
  List<Object?> get props => [];
}

class ScanTicketSuccess extends Success implements ScanTicketState {
  final TicketInfo ticketInfo;

  const ScanTicketSuccess({required this.ticketInfo});

  @override
  List<Object?> get props => [ticketInfo];
}

class ScanTicketFailure extends Failure implements ScanTicketState {
  final dynamic exception;

  const ScanTicketFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class ScanTicketEmpty extends Failure implements ScanTicketState {
  const ScanTicketEmpty();

  @override
  List<Object?> get props => [];
}
