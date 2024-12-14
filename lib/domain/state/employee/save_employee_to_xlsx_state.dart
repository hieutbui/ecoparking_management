import 'package:ecoparking_management/data/models/save_employee_to_xlsx_status.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class SaveEmployeeToXlsxState with EquatableMixin {
  const SaveEmployeeToXlsxState();

  @override
  List<Object?> get props => [];
}

class SaveEmployeeToXlsxInitial extends Initial
    implements SaveEmployeeToXlsxState {
  const SaveEmployeeToXlsxInitial() : super();

  @override
  List<Object?> get props => [];
}

class SaveEmployeeToXlsxLoading extends Initial
    implements SaveEmployeeToXlsxState {
  const SaveEmployeeToXlsxLoading() : super();

  @override
  List<Object?> get props => [];
}

class SaveEmployeeToXlsxSuccess extends Success
    implements SaveEmployeeToXlsxState {
  final SaveEmployeeToXlsxStatus status;

  const SaveEmployeeToXlsxSuccess({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}

class SaveEmployeeToXlsxFailure extends Failure
    implements SaveEmployeeToXlsxState {
  final dynamic exception;

  const SaveEmployeeToXlsxFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
