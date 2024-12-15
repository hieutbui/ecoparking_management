import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetLast12MonthsTotalState with EquatableMixin {
  const GetLast12MonthsTotalState();

  @override
  List<Object?> get props => [];
}

class GetLast12MonthsTotalInitial extends Initial
    implements GetLast12MonthsTotalState {
  const GetLast12MonthsTotalInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetLast12MonthsTotalLoading extends Initial
    implements GetLast12MonthsTotalState {
  const GetLast12MonthsTotalLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetLast12MonthsTotalSuccess extends Success
    implements GetLast12MonthsTotalState {
  final List<AnalysisData> data;

  const GetLast12MonthsTotalSuccess({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class GetLast12MonthsTotalEmpty extends Success
    implements GetLast12MonthsTotalState {
  const GetLast12MonthsTotalEmpty();

  @override
  List<Object?> get props => [];
}

class GetLast12MonthsTotalFailure extends Failure
    implements GetLast12MonthsTotalState {
  final dynamic exception;

  const GetLast12MonthsTotalFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
