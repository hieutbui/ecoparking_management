import 'package:ecoparking_management/data/models/export_data_status.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class ExportDataState with EquatableMixin {
  const ExportDataState();

  @override
  List<Object?> get props => [];
}

class ExportDataInitial extends Initial implements ExportDataState {
  const ExportDataInitial() : super();

  @override
  List<Object?> get props => [];
}

class ExportDataLoading extends Initial implements ExportDataState {
  const ExportDataLoading() : super();

  @override
  List<Object?> get props => [];
}

class ExportDataSuccess extends Success implements ExportDataState {
  final ExportDataStatus status;

  const ExportDataSuccess({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}

class ExportDataFailure extends Failure implements ExportDataState {
  final dynamic exception;

  const ExportDataFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
