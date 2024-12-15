import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetLastYearTotalState with EquatableMixin {
  const GetLastYearTotalState();

  @override
  List<Object?> get props => [];
}

class GetLastYearTotalInitial extends Initial implements GetLastYearTotalState {
  const GetLastYearTotalInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetLastYearTotalLoading extends Initial implements GetLastYearTotalState {
  const GetLastYearTotalLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetLastYearTotalSuccess extends Success implements GetLastYearTotalState {
  final List<AnalysisData> data;

  const GetLastYearTotalSuccess({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class GetLastYearTotalEmpty extends Success implements GetLastYearTotalState {
  const GetLastYearTotalEmpty();

  @override
  List<Object?> get props => [];
}

class GetLastYearTotalFailure extends Failure implements GetLastYearTotalState {
  final dynamic exception;

  const GetLastYearTotalFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
