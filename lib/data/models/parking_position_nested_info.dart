import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_position_nested_info.g.dart';

@JsonSerializable()
class ParkingPositionNestedInfo with EquatableMixin {
  @JsonKey(name: 'parking_name')
  final String parkingName;

  const ParkingPositionNestedInfo({
    required this.parkingName,
  });

  factory ParkingPositionNestedInfo.fromJson(Map<String, dynamic> json) =>
      _$ParkingPositionNestedInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingPositionNestedInfoToJson(this);

  @override
  List<Object?> get props => [parkingName];
}
