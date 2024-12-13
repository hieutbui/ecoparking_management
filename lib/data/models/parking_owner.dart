import 'package:ecoparking_management/data/models/parking_position_nested_info.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_owner.g.dart';

@JsonSerializable()
class ParkingOwner with EquatableMixin {
  final String id;
  @JsonKey(name: 'profile_id')
  final String profileId;
  @JsonKey(name: 'parking_id')
  final String parkingId;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'currency_locale')
  final String currencyLocale;
  final ParkingPositionNestedInfo? parking;

  const ParkingOwner({
    required this.id,
    required this.profileId,
    required this.parkingId,
    required this.parking,
    required this.createdAt,
    required this.currencyLocale,
  });

  factory ParkingOwner.fromJson(Map<String, dynamic> json) =>
      _$ParkingOwnerFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingOwnerToJson(this);

  @override
  List<Object?> get props => [
        id,
        profileId,
        parkingId,
        parking,
        createdAt,
        currencyLocale,
      ];
}
