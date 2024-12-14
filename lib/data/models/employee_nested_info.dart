import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_nested_info.g.dart';

@JsonSerializable()
class EmployeeNestedInfo with EquatableMixin {
  final String id;
  @JsonKey(name: 'parking_id')
  final String parkingId;
  @JsonKey(name: 'profile_id')
  final String profileId;
  @JsonKey(name: 'currency_locale')
  final String currencyLocale;
  @JsonKey(
    name: 'working_start_time',
    fromJson: _timeOfDayFromString,
    toJson: _timeOfDayToString,
  )
  final TimeOfDay? workingStartTime;
  @JsonKey(
    name: 'working_end_time',
    fromJson: _timeOfDayFromString,
    toJson: _timeOfDayToString,
  )
  final TimeOfDay? workingEndTime;
  final EmployeeNestedProfileInfo profile;

  const EmployeeNestedInfo({
    required this.id,
    required this.parkingId,
    required this.profileId,
    required this.currencyLocale,
    required this.profile,
    required this.workingStartTime,
    required this.workingEndTime,
  });

  factory EmployeeNestedInfo.fromJson(Map<String, dynamic> json) =>
      _$EmployeeNestedInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeNestedInfoToJson(this);

  @override
  List<Object?> get props => [
        id,
        parkingId,
        profileId,
        currencyLocale,
        profile,
        workingStartTime,
        workingEndTime,
      ];
}

TimeOfDay? _timeOfDayFromString(String? time) {
  if (time == null) return null;

  final parts = time.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

String? _timeOfDayToString(TimeOfDay? time) {
  if (time == null) return null;

  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

@JsonSerializable()
class EmployeeNestedProfileInfo with EquatableMixin {
  @JsonKey(name: 'full_name')
  final String name;
  final String email;
  final String? phone;

  const EmployeeNestedProfileInfo({
    required this.name,
    required this.email,
    this.phone,
  });

  factory EmployeeNestedProfileInfo.fromJson(Map<String, dynamic> json) =>
      _$EmployeeNestedProfileInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeNestedProfileInfoToJson(this);

  @override
  List<Object?> get props => [name, email, phone];
}
