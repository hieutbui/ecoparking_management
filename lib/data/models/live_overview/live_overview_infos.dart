import 'package:ecoparking_management/data/models/live_overview/current_employee_info.dart';
import 'package:ecoparking_management/data/models/live_overview/current_ticket.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'live_overview_infos.g.dart';

@JsonSerializable()
class LiveOverviewInfos with EquatableMixin {
  @JsonKey(name: 'parking_lots_occupied')
  final int parkingLotsOccupied;
  @JsonKey(name: 'parking_lots_total')
  final int parkingLotsTotal;
  @JsonKey(name: 'current_employees')
  final int currentEmployees;
  @JsonKey(name: 'total_customers')
  final int totalCustomers;
  @JsonKey(name: 'total_revenue')
  final num totalRevenue;
  @JsonKey(name: 'currency_locale')
  final String currencyLocale;
  @JsonKey(name: 'current_parking_lot_allotment')
  final List<CurrentTicket> currentParkingLotAllotment;
  @JsonKey(name: 'current_employees_info')
  final List<CurrentEmployeeInfo> currentEmployeesInfo;

  const LiveOverviewInfos({
    required this.parkingLotsOccupied,
    required this.parkingLotsTotal,
    required this.currentEmployees,
    required this.totalCustomers,
    required this.totalRevenue,
    required this.currencyLocale,
    required this.currentParkingLotAllotment,
    required this.currentEmployeesInfo,
  });

  factory LiveOverviewInfos.fromJson(Map<String, dynamic> json) =>
      _$LiveOverviewInfosFromJson(json);

  Map<String, dynamic> toJson() => _$LiveOverviewInfosToJson(this);

  @override
  List<Object?> get props => [
        parkingLotsOccupied,
        parkingLotsTotal,
        currentEmployees,
        totalCustomers,
        totalRevenue,
        currencyLocale,
        currentParkingLotAllotment,
      ];
}
