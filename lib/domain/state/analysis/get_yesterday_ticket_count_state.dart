import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetYesterdayTicketCountState with EquatableMixin {
  const GetYesterdayTicketCountState();

  @override
  List<Object?> get props => [];
}

class GetYesterdayTicketCountInitial extends Initial
    implements GetYesterdayTicketCountState {
  const GetYesterdayTicketCountInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetYesterdayTicketCountLoading extends Initial
    implements GetYesterdayTicketCountState {
  const GetYesterdayTicketCountLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetYesterdayTicketCountSuccess extends Success
    implements GetYesterdayTicketCountState {
  final List<AnalysisData> data;

  const GetYesterdayTicketCountSuccess({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class GetYesterdayTicketCountEmpty extends Success
    implements GetYesterdayTicketCountState {
  const GetYesterdayTicketCountEmpty();

  @override
  List<Object?> get props => [];
}

class GetYesterdayTicketCountFailure extends Failure
    implements GetYesterdayTicketCountState {
  final dynamic exception;

  const GetYesterdayTicketCountFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
