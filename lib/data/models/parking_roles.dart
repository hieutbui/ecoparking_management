import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_roles.g.dart';

@JsonSerializable()
class ParkingRoles with EquatableMixin {
  @JsonKey(name: 'user_role')
  final UserParkingRole userRole;
  @JsonKey(name: 'parking_name')
  final String parkingName;

  const ParkingRoles({
    required this.userRole,
    required this.parkingName,
  });

  factory ParkingRoles.fromJson(Map<String, dynamic> json) =>
      _$ParkingRolesFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingRolesToJson(this);

  @override
  List<Object?> get props => [
        userRole,
        parkingName,
      ];
}

enum UserParkingRole {
  owner,
  employee;

  @override
  String toString() {
    switch (this) {
      case owner:
        return 'owner';
      case employee:
        return 'employee';
    }
  }

  String toDisplayString() {
    switch (this) {
      case owner:
        return 'Owner';
      case employee:
        return 'Employee';
    }
  }
}
