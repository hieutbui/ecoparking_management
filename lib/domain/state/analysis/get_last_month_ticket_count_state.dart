import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetLastMonthTicketCountState with EquatableMixin {
  const GetLastMonthTicketCountState();

  @override
  List<Object?> get props => [];
}

class GetLastMonthTicketCountInitial extends Initial
    implements GetLastMonthTicketCountState {
  const GetLastMonthTicketCountInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetLastMonthTicketCountLoading extends Initial
    implements GetLastMonthTicketCountState {
  const GetLastMonthTicketCountLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetLastMonthTicketCountSuccess extends Success
    implements GetLastMonthTicketCountState {
  final List<AnalysisData> data;

  const GetLastMonthTicketCountSuccess({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class GetLastMonthTicketCountEmpty extends Success
    implements GetLastMonthTicketCountState {
  const GetLastMonthTicketCountEmpty();

  @override
  List<Object?> get props => [];
}

class GetLastMonthTicketCountFailure extends Failure
    implements GetLastMonthTicketCountState {
  final dynamic exception;

  const GetLastMonthTicketCountFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
