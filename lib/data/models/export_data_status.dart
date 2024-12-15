import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'export_data_status.g.dart';

@JsonSerializable()
class ExportDataStatus with EquatableMixin {
  final ExportDataStatusEnum status;

  const ExportDataStatus({
    required this.status,
  });

  factory ExportDataStatus.fromJson(Map<String, dynamic> json) =>
      _$ExportDataStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ExportDataStatusToJson(this);

  @override
  List<Object?> get props => [
        status,
      ];
}

enum ExportDataStatusEnum {
  success,
  error;

  @override
  String toString() {
    return this == ExportDataStatusEnum.success ? 'success' : 'error';
  }
}
