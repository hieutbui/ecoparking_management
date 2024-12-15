import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetLast12MonthsTicketCountState with EquatableMixin {
  const GetLast12MonthsTicketCountState();

  @override
  List<Object?> get props => [];
}

class GetLast12MonthsTicketCountInitial extends Initial
    implements GetLast12MonthsTicketCountState {
  const GetLast12MonthsTicketCountInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetLast12MonthsTicketCountLoading extends Initial
    implements GetLast12MonthsTicketCountState {
  const GetLast12MonthsTicketCountLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetLast12MonthsTicketCountSuccess extends Success
    implements GetLast12MonthsTicketCountState {
  final List<AnalysisData> data;

  const GetLast12MonthsTicketCountSuccess({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class GetLast12MonthsTicketCountEmpty extends Success
    implements GetLast12MonthsTicketCountState {
  const GetLast12MonthsTicketCountEmpty();

  @override
  List<Object?> get props => [];
}

class GetLast12MonthsTicketCountFailure extends Failure
    implements GetLast12MonthsTicketCountState {
  final dynamic exception;

  const GetLast12MonthsTicketCountFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
