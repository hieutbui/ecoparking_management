import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_employee_to_xlsx_status.g.dart';

@JsonSerializable()
class SaveEmployeeToXlsxStatus with EquatableMixin {
  final SaveEmployeeToXlsxStatusEnum status;

  const SaveEmployeeToXlsxStatus({
    required this.status,
  });

  factory SaveEmployeeToXlsxStatus.fromJson(Map<String, dynamic> json) =>
      _$SaveEmployeeToXlsxStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SaveEmployeeToXlsxStatusToJson(this);

  @override
  List<Object?> get props => [
        status,
      ];
}

enum SaveEmployeeToXlsxStatusEnum {
  success,
  error;

  @override
  String toString() {
    return this == SaveEmployeeToXlsxStatusEnum.success ? 'success' : 'error';
  }
}
