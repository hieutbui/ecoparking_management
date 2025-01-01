import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_attendance_to_xlsx_status.g.dart';

@JsonSerializable()
class SaveAttendanceToXlsxStatus with EquatableMixin {
  final SaveAttendanceToXlsxStatusEnum status;

  const SaveAttendanceToXlsxStatus({
    required this.status,
  });

  factory SaveAttendanceToXlsxStatus.fromJson(Map<String, dynamic> json) =>
      _$SaveAttendanceToXlsxStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SaveAttendanceToXlsxStatusToJson(this);

  @override
  List<Object?> get props => [
        status,
      ];
}

enum SaveAttendanceToXlsxStatusEnum {
  success,
  error;

  @override
  String toString() {
    return this == SaveAttendanceToXlsxStatusEnum.success ? 'success' : 'error';
  }
}
