import 'package:ecoparking_management/data/models/live_overview/current_employee_info.dart';
import 'package:ecoparking_management/data/models/live_overview/current_ticket.dart';
import 'package:ecoparking_management/data/models/live_overview/live_overview_infos.dart';
import 'package:ecoparking_management/data/models/ticket_status.dart';
import 'package:ecoparking_management/pages/live_overview/live_overview_view.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LiveOverview extends StatefulWidget {
  const LiveOverview({super.key});

  @override
  LiveOverviewController createState() => LiveOverviewController();
}

class LiveOverviewController extends State<LiveOverview> with ControllerLoggy {
  final ValueNotifier<int> rowPerPageCurrentEmployeesNotifier =
      ValueNotifier<int>(PaginatedDataTable.defaultRowsPerPage);
  final ValueNotifier<int> rowPerPageCurrentTicketsNotifier =
      ValueNotifier<int>(PaginatedDataTable.defaultRowsPerPage);

  List<String> get currentEmployeesTableTitles => <String>[
        'Employee ID',
        'Name',
        'Email',
        'Phone',
      ];
  List<String> get currentParkingLotAllotmentTableTitles => <String>[
        'License Plate',
        'Entry Time',
        'Actual Exit',
        'Booked Start',
        'Booked Exit',
        'Status',
        'Duration',
        'Charge',
      ];

  //TODO: Implement fetch data from API
  final dummyLiveOverview = LiveOverviewInfos(
    parkingLotsOccupied: 6,
    parkingLotsTotal: 10,
    currentEmployees: 2,
    totalCustomers: 100,
    totalRevenue: 10000000,
    currencyLocale: 'vi_VN',
    currentParkingLotAllotment: <CurrentTicket>[
      CurrentTicket(
        ticketId: '1',
        licensePlate: '51A-12345',
        bookedStartTime: DateTime.now(),
        entryTime: DateTime.now().subtract(const Duration(minutes: 1)),
        bookedExitTime: DateTime.now().add(const Duration(hours: 2)),
        actualExitTime: null,
        status: TicketStatus.active,
        days: 0,
        hours: 1,
        total: 100000,
      ),
      CurrentTicket(
        ticketId: '2',
        licensePlate: '51A-12346',
        bookedStartTime: DateTime.now(),
        entryTime: DateTime.now().subtract(const Duration(minutes: 1)),
        bookedExitTime: DateTime.now().add(const Duration(hours: 2)),
        actualExitTime: null,
        status: TicketStatus.active,
        days: 0,
        hours: 1,
        total: 100000,
      ),
      CurrentTicket(
        ticketId: '3',
        licensePlate: '51A-12347',
        entryTime: DateTime.now().subtract(const Duration(hours: 2)),
        bookedStartTime: DateTime.now().subtract(const Duration(hours: 2)),
        bookedExitTime: DateTime.now(),
        actualExitTime: DateTime.now(),
        status: TicketStatus.completed,
        days: 0,
        hours: 1,
        total: 100000,
      ),
      CurrentTicket(
        ticketId: '4',
        licensePlate: '51A-12348',
        entryTime: null,
        bookedStartTime: DateTime.now().add(const Duration(hours: 2)),
        bookedExitTime: DateTime.now().add(const Duration(hours: 2)),
        actualExitTime: null,
        status: TicketStatus.paid,
        days: 0,
        hours: 1,
        total: 100000,
      ),
    ],
    currentEmployeesInfo: <CurrentEmployeeInfo>[
      const CurrentEmployeeInfo(
        id: '1',
        employeeId: '1',
        email: 'employ1@example.com',
        name: 'Employee 1',
        phone: '0123456789',
      ),
      const CurrentEmployeeInfo(
        id: '2',
        employeeId: '2',
        name: 'Employee 2',
        email: 'employ2@example.com',
        phone: '0123456789',
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _disposeNotifiers();
    super.dispose();
  }

  void _disposeNotifiers() {
    rowPerPageCurrentEmployeesNotifier.dispose();
    rowPerPageCurrentTicketsNotifier.dispose();
  }

  String getFormattedCurrency(num value, String locale) {
    final format = NumberFormat.simpleCurrency(locale: locale);

    return format.format(value);
  }

  List<DataRow> currentEmployeeRow(List<CurrentEmployeeInfo> employee) {
    return employee
        .map(
          (e) => DataRow(
            //TODO: Show employee info when press on row
            cells: <DataCell>[
              DataCell(
                Text(
                  e.employeeId,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.email,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.phone ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataRow> currentTicketRow(List<CurrentTicket> tickets) {
    Color statusColor(TicketStatus status) {
      switch (status) {
        case TicketStatus.active:
          return Theme.of(context).colorScheme.onTertiaryContainer;
        case TicketStatus.completed:
          return Theme.of(context).colorScheme.secondaryContainer;
        case TicketStatus.cancelled:
          return Theme.of(context).colorScheme.error;
        case TicketStatus.paid:
          return Theme.of(context).colorScheme.onSecondary;
        default:
          return Theme.of(context).colorScheme.onTertiary;
      }
    }

    return tickets
        .map(
          (e) => DataRow(
            //TODO: Show ticket info in dialog when press on row
            cells: <DataCell>[
              DataCell(
                Text(
                  e.licensePlate,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.entryTime != null
                      ? DateFormat('hh:mm a').format(e.entryTime!)
                      : '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.actualExitTime != null
                      ? DateFormat('hh:mm a').format(e.actualExitTime!)
                      : '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  DateFormat('hh:mm a').format(e.bookedStartTime),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  DateFormat('hh:mm a').format(e.bookedExitTime),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.status.displayString,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: statusColor(e.status),
                      ),
                ),
              ),
              DataCell(
                Text(
                  '${e.days}d ${e.hours}h',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  getFormattedCurrency(e.total, 'vi_VN'),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  void onCurrentEmployeesRowsPerPageChanged(int? selectedRowsPerPage) {
    if (selectedRowsPerPage != null) {
      rowPerPageCurrentEmployeesNotifier.value = selectedRowsPerPage;
    }
  }

  void onCurrentTicketRowsPerPageChanged(int? selectedRowsPerPage) {
    if (selectedRowsPerPage != null) {
      rowPerPageCurrentTicketsNotifier.value = selectedRowsPerPage;
    }
  }

  @override
  Widget build(BuildContext context) => LiveOverviewView(controller: this);
}
