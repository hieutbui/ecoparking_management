import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_nested_vehicle.g.dart';

@JsonSerializable()
class TicketNestedVehicle with EquatableMixin {
  @JsonKey(name: 'license_plate')
  final String licensePlate;

  const TicketNestedVehicle({
    required this.licensePlate,
  });

  factory TicketNestedVehicle.fromJson(Map<String, dynamic> json) =>
      _$TicketNestedVehicleFromJson(json);

  Map<String, dynamic> toJson() => _$TicketNestedVehicleToJson(this);

  @override
  List<Object?> get props => [
        licensePlate,
      ];
}
