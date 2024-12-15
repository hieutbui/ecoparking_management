import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetLastYearTicketCountState with EquatableMixin {
  const GetLastYearTicketCountState();

  @override
  List<Object?> get props => [];
}

class GetLastYearTicketCountInitial extends Initial
    implements GetLastYearTicketCountState {
  const GetLastYearTicketCountInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetLastYearTicketCountLoading extends Initial
    implements GetLastYearTicketCountState {
  const GetLastYearTicketCountLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetLastYearTicketCountSuccess extends Success
    implements GetLastYearTicketCountState {
  final List<AnalysisData> data;

  const GetLastYearTicketCountSuccess({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class GetLastYearTicketCountEmpty extends Success
    implements GetLastYearTicketCountState {
  const GetLastYearTicketCountEmpty();

  @override
  List<Object?> get props => [];
}

class GetLastYearTicketCountFailure extends Failure
    implements GetLastYearTicketCountState {
  final dynamic exception;

  const GetLastYearTicketCountFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
