import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_attendance.g.dart';

@JsonSerializable()
class EmployeeAttendance with EquatableMixin {
  final String id;
  @JsonKey(name: 'employee_id')
  final String employeeId;
  @JsonKey(name: 'parking_id')
  final String parkingId;
  final DateTime date;
  @JsonKey(
    name: 'clock_in',
    fromJson: _timeOfDayFromString,
    toJson: _timeOfDayToString,
  )
  final TimeOfDay? clockIn;
  @JsonKey(
    name: 'clock_out',
    fromJson: _timeOfDayFromString,
    toJson: _timeOfDayToString,
  )
  final TimeOfDay? clockOut;

  const EmployeeAttendance({
    required this.id,
    required this.employeeId,
    required this.parkingId,
    required this.date,
    this.clockIn,
    this.clockOut,
  });

  factory EmployeeAttendance.fromJson(Map<String, dynamic> json) =>
      _$EmployeeAttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeAttendanceToJson(this);

  @override
  List<Object?> get props => [
        id,
        employeeId,
        parkingId,
        date,
        clockIn,
        clockOut,
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
