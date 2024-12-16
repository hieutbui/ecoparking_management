import 'package:ecoparking_management/data/models/ticket_nested_vehicle.dart';
import 'package:ecoparking_management/data/models/ticket_status.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_info.g.dart';

@JsonSerializable()
class TicketInfo with EquatableMixin {
  final String id;
  @JsonKey(name: 'parking_id')
  final String parkingId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'vehicle_id')
  final String vehicleId;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  final int days;
  final int hours;
  final num total;
  final TicketStatus status;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'payment_intent_id')
  final String? paymentIntentId;
  @JsonKey(name: 'entry_time')
  final DateTime? entryTime;
  @JsonKey(name: 'exit_time')
  final DateTime? exitTime;
  final TicketNestedVehicle? vehicle;

  const TicketInfo({
    required this.id,
    required this.parkingId,
    required this.userId,
    required this.vehicleId,
    required this.startTime,
    required this.endTime,
    required this.days,
    required this.hours,
    required this.total,
    required this.status,
    required this.createdAt,
    this.paymentIntentId,
    this.entryTime,
    this.exitTime,
    this.vehicle,
  });

  factory TicketInfo.fromJson(Map<String, dynamic> json) =>
      _$TicketInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TicketInfoToJson(this);

  @override
  List<Object?> get props => [
        id,
        parkingId,
        userId,
        vehicleId,
        startTime,
        endTime,
        days,
        hours,
        total,
        status,
        createdAt,
        paymentIntentId,
        entryTime,
        exitTime,
        vehicle,
      ];
}
