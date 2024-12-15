import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetYesterdayTotalState with EquatableMixin {
  const GetYesterdayTotalState();

  @override
  List<Object?> get props => [];
}

class GetYesterdayTotalInitial extends Initial
    implements GetYesterdayTotalState {
  const GetYesterdayTotalInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetYesterdayTotalLoading extends Initial
    implements GetYesterdayTotalState {
  const GetYesterdayTotalLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetYesterdayTotalSuccess extends Success
    implements GetYesterdayTotalState {
  final List<AnalysisData> data;

  const GetYesterdayTotalSuccess({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class GetYesterdayTotalEmpty extends Success implements GetYesterdayTotalState {
  const GetYesterdayTotalEmpty();

  @override
  List<Object?> get props => [];
}

class GetYesterdayTotalFailure extends Failure
    implements GetYesterdayTotalState {
  final dynamic exception;

  const GetYesterdayTotalFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
