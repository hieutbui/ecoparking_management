import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_employee_info.g.dart';

@JsonSerializable()
class CurrentEmployeeInfo with EquatableMixin {
  final String id;
  @JsonKey(name: 'employee_id')
  final String employeeId;
  final String name;
  final String email;
  final String? phone;

  const CurrentEmployeeInfo({
    required this.id,
    required this.employeeId,
    required this.name,
    required this.email,
    this.phone,
  });

  factory CurrentEmployeeInfo.fromJson(Map<String, dynamic> json) =>
      _$CurrentEmployeeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentEmployeeInfoToJson(this);

  @override
  List<Object?> get props => [
        id,
        employeeId,
        name,
        email,
        phone,
      ];
}
