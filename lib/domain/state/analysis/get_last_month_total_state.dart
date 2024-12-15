import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetLastMonthTotalState with EquatableMixin {
  const GetLastMonthTotalState();

  @override
  List<Object?> get props => [];
}

class GetLastMonthTotalInitial extends Initial
    implements GetLastMonthTotalState {
  const GetLastMonthTotalInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetLastMonthTotalLoading extends Initial
    implements GetLastMonthTotalState {
  const GetLastMonthTotalLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetLastMonthTotalSuccess extends Success
    implements GetLastMonthTotalState {
  final List<AnalysisData> data;

  const GetLastMonthTotalSuccess({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class GetLastMonthTotalEmpty extends Success implements GetLastMonthTotalState {
  const GetLastMonthTotalEmpty();

  @override
  List<Object?> get props => [];
}

class GetLastMonthTotalFailure extends Failure
    implements GetLastMonthTotalState {
  final dynamic exception;

  const GetLastMonthTotalFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
