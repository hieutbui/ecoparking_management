import 'package:ecoparking_management/data/models/parking_position_nested_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_employee.g.dart';

@JsonSerializable()
class ParkingEmployee with EquatableMixin {
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
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final ParkingPositionNestedInfo? parking;

  const ParkingEmployee({
    required this.id,
    required this.parkingId,
    required this.parking,
    required this.profileId,
    required this.currencyLocale,
    required this.createdAt,
    this.workingStartTime,
    this.workingEndTime,
  });

  factory ParkingEmployee.fromJson(Map<String, dynamic> json) =>
      _$ParkingEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingEmployeeToJson(this);

  @override
  List<Object?> get props => [
        id,
        parkingId,
        parking,
        profileId,
        currencyLocale,
        workingStartTime,
        workingEndTime,
        createdAt,
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
