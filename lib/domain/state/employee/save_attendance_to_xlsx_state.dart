import 'package:ecoparking_management/data/models/save_attendance_to_xlsx_status.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/initial.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class SaveAttendanceToXlsxState with EquatableMixin {
  const SaveAttendanceToXlsxState();

  @override
  List<Object?> get props => [];
}

class SaveAttendanceToXlsxInitial extends Initial
    implements SaveAttendanceToXlsxState {
  const SaveAttendanceToXlsxInitial();

  @override
  List<Object?> get props => [];
}

class SaveAttendanceToXlsxLoading extends Initial
    implements SaveAttendanceToXlsxState {
  const SaveAttendanceToXlsxLoading();

  @override
  List<Object?> get props => [];
}

class SaveAttendanceToXlsxSuccess extends Success
    implements SaveAttendanceToXlsxState {
  final SaveAttendanceToXlsxStatus status;

  const SaveAttendanceToXlsxSuccess({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}

class SaveAttendanceToXlsxFailure extends Failure
    implements SaveAttendanceToXlsxState {
  final dynamic exception;

  const SaveAttendanceToXlsxFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
