import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_info.g.dart';

@JsonSerializable()
class ParkingInfo with EquatableMixin {
  final String id;
  @JsonKey(name: 'parking_name')
  final String parkingName;
  final String address;
  @JsonKey(name: 'total_slot')
  final int totalSlot;
  @JsonKey(name: 'available_slot')
  final int availableSlot;
  @JsonKey(name: 'price_per_day')
  final double pricePerDay;
  @JsonKey(name: 'price_per_year')
  final double pricePerYear;
  final String? image;
  final String? phone;

  const ParkingInfo({
    required this.id,
    required this.parkingName,
    required this.address,
    required this.totalSlot,
    required this.availableSlot,
    required this.pricePerDay,
    required this.pricePerYear,
    this.image,
    this.phone,
  });

  factory ParkingInfo.fromJson(Map<String, dynamic> json) =>
      _$ParkingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingInfoToJson(this);

  @override
  List<Object?> get props => [
        id,
        parkingName,
        address,
        totalSlot,
        availableSlot,
        pricePerDay,
        pricePerYear,
        image,
        phone,
      ];
}
