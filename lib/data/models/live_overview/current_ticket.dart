import 'package:ecoparking_management/data/models/ticket_status.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_ticket.g.dart';

@JsonSerializable()
class CurrentTicket with EquatableMixin {
  @JsonKey(name: 'ticket_id')
  final String ticketId;
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  @JsonKey(name: 'entry_time')
  final DateTime? entryTime;
  @JsonKey(name: 'booked_start_time')
  final DateTime bookedStartTime;
  @JsonKey(name: 'booked_exit_time')
  final DateTime bookedExitTime;
  @JsonKey(name: 'actual_exit_time')
  final DateTime? actualExitTime;
  final TicketStatus status;
  final int days;
  final int hours;
  final num total;

  const CurrentTicket({
    required this.ticketId,
    required this.licensePlate,
    required this.bookedStartTime,
    required this.bookedExitTime,
    required this.status,
    required this.days,
    required this.hours,
    required this.total,
    this.entryTime,
    this.actualExitTime,
  });

  factory CurrentTicket.fromJson(Map<String, dynamic> json) =>
      _$CurrentTicketFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentTicketToJson(this);

  @override
  List<Object?> get props => [
        ticketId,
        licensePlate,
        entryTime,
        bookedStartTime,
        bookedExitTime,
        actualExitTime,
        status,
        days,
        hours,
        total,
      ];
}
