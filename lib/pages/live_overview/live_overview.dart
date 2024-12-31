import 'dart:async';
import 'package:ecoparking_management/config/app_config.dart';
import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/data/models/ticket_info.dart';
import 'package:ecoparking_management/data/models/ticket_status.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/data/supabase_data/supabase_schema.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/domain/state/analysis/get_current_employee_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_parking_info_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_ticket_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_current_employee_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_parking_info_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_ticket_interactor.dart';
import 'package:ecoparking_management/pages/live_overview/live_overview_view.dart';
import 'package:ecoparking_management/pages/live_overview/models/parking_occupied.dart';
import 'package:ecoparking_management/utils/dialog_utils.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LiveOverview extends StatefulWidget {
  const LiveOverview({super.key});

  @override
  LiveOverviewController createState() => LiveOverviewController();
}

class LiveOverviewController extends State<LiveOverview> with ControllerLoggy {
  final ProfileService _profileService = getIt.get<ProfileService>();

  final GetParkingInfoInteractor _getParkingInfoInteractor =
      getIt.get<GetParkingInfoInteractor>();
  final GetCurrentEmployeeInteractor _getCurrentEmployeeInteractor =
      getIt.get<GetCurrentEmployeeInteractor>();
  final GetTicketInteractor _getTicketInteractor =
      getIt.get<GetTicketInteractor>();

  final ValueNotifier<GetParkingInfoState> getParkingInfoStateNotifier =
      ValueNotifier<GetParkingInfoState>(const GetParkingInfoInitial());
  final ValueNotifier<GetCurrentEmployeeState> getCurrentEmployeeStateNotifier =
      ValueNotifier<GetCurrentEmployeeState>(const GetCurrentEmployeeInitial());
  final ValueNotifier<GetTicketState> getTicketStateNotifier =
      ValueNotifier<GetTicketState>(const GetTicketInitial());

  final ValueNotifier<ParkingOccupied> parkingOccupied =
      ValueNotifier<ParkingOccupied>(
    const ParkingOccupied(occupied: 0, total: 0),
  );
  final ValueNotifier<int> countCurrentEmployee = ValueNotifier<int>(0);
  final ValueNotifier<List<EmployeeNestedInfo>> currentEmployeesNotifier =
      ValueNotifier<List<EmployeeNestedInfo>>(<EmployeeNestedInfo>[]);
  final ValueNotifier<int> totalCustomersNotifier = ValueNotifier<int>(0);
  final ValueNotifier<num> totalRevenueNotifier = ValueNotifier<num>(0);
  final ValueNotifier<List<TicketInfo>> currentParkingLotAllotmentNotifier =
      ValueNotifier<List<TicketInfo>>(<TicketInfo>[]);
  final ValueNotifier<int> rowPerPageCurrentEmployeesNotifier =
      ValueNotifier<int>(PaginatedDataTable.defaultRowsPerPage);
  final ValueNotifier<int> rowPerPageCurrentTicketsNotifier =
      ValueNotifier<int>(PaginatedDataTable.defaultRowsPerPage);
  final ValueNotifier<int> rowPerPageAllTicketsNotifier =
      ValueNotifier<int>(PaginatedDataTable.defaultRowsPerPage);

  List<String> get currentEmployeesTableTitles => <String>[
        'Mã NV',
        'Tên NV',
        'Email',
        'SĐT',
      ];
  List<String> get currentParkingLotAllotmentTableTitles => <String>[
        'Biển số',
        'Thời gian vào',
        'Thời gian ra',
        'Đăng ký vào',
        'Đăng ký ra',
        'Trạng thái',
        'Thời gian đặt',
        'Tổng tiền',
      ];

  bool get isEmployee =>
      _profileService.userProfile?.accountType == AccountType.employee;

  StreamSubscription? _parkingInfoSubscription;
  StreamSubscription? _currentEmployeeSubscription;

  @override
  void initState() {
    super.initState();
    _getParkingInfo();
    _getCurrentEmployee();
    _getTicket();
    _listenRealtimeChanges();
  }

  @override
  void dispose() {
    _unsubscribeListenRealtime();
    _disposeSubscriptions();
    _disposeNotifiers();
    super.dispose();
  }

  void _listenRealtimeChanges() {
    const realtimePurpose = 'live_overview';

    Supabase.instance.client
        .channel('${AppConfig.appTitle}/$realtimePurpose')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          callback: _realtimeCallback,
          schema: SupabaseSchema.public.name,
        )
        .subscribe();
  }

  void _realtimeCallback(PostgresChangePayload payload) {
    const ticketTableName = 'ticket';
    const parkingTableName = 'parking';
    const parkingEmployeeTableName = 'parking_employee';

    switch (payload.table) {
      case ticketTableName:
        _handleRealtimeTicket(payload);
        break;
      case parkingTableName:
        _handleRealtimeParking(payload);
        break;
      case parkingEmployeeTableName:
        _handleRealtimeParkingEmployee(payload);
        break;
      default:
        break;
    }
  }

  void _handleRealtimeTicket(PostgresChangePayload payload) {
    switch (payload.eventType) {
      case PostgresChangeEvent.delete:
        _handleTicketDelete(payload);
        break;
      case PostgresChangeEvent.update:
        _handleTicketUpdate(payload);
        break;
      case PostgresChangeEvent.insert:
        _handleTicketInsert(payload);
        break;
      default:
        break;
    }
  }

  void _handleRealtimeParking(PostgresChangePayload payload) {
    switch (payload.eventType) {
      case PostgresChangeEvent.delete:
        _handleParkingDelete(payload);
        break;
      case PostgresChangeEvent.update:
        _handleParkingUpdate(payload);
        break;
      case PostgresChangeEvent.insert:
        _handleParkingInsert(payload);
        break;
      default:
        break;
    }
  }

  void _handleRealtimeParkingEmployee(PostgresChangePayload payload) {
    switch (payload.eventType) {
      case PostgresChangeEvent.delete:
        _handleParkingEmployeeDelete(payload);
        break;
      case PostgresChangeEvent.update:
        _handleParkingEmployeeUpdate(payload);
        break;
      case PostgresChangeEvent.insert:
        _handleParkingEmployeeInsert(payload);
        break;
      default:
        break;
    }
  }

  void _handleTicketDelete(PostgresChangePayload payload) {
    _getTicket();
  }

  void _handleTicketUpdate(PostgresChangePayload payload) {
    _getTicket();
  }

  void _handleTicketInsert(PostgresChangePayload payload) {
    _getTicket();
  }

  void _handleParkingUpdate(PostgresChangePayload payload) {
    _getParkingInfo();
  }

  void _handleParkingInsert(PostgresChangePayload payload) {
    _getParkingInfo();
  }

  void _handleParkingDelete(PostgresChangePayload payload) {
    _getParkingInfo();
  }

  void _handleParkingEmployeeUpdate(PostgresChangePayload payload) {
    _getCurrentEmployee();
  }

  void _handleParkingEmployeeInsert(PostgresChangePayload payload) {
    _getCurrentEmployee();
  }

  void _handleParkingEmployeeDelete(PostgresChangePayload payload) {
    _getCurrentEmployee();
  }

  Future<String?> _getParkingId() async {
    final profile = _profileService.userProfile;

    if (profile == null || !_profileService.isAuthenticated) {
      await _showRequiredLogin();

      return null;
    }

    if (profile.accountType == AccountType.employee) {
      final parkingEmployee = _profileService.parkingEmployee;

      if (parkingEmployee == null) {
        await _showRequiredLogin();

        return null;
      } else {
        return parkingEmployee.parkingId;
      }
    } else if (profile.accountType == AccountType.parkingOwner) {
      final parkingOwner = _profileService.parkingOwner;

      if (parkingOwner == null) {
        await _showRequiredLogin();

        return null;
      } else {
        return parkingOwner.parkingId;
      }
    }

    return null;
  }

  Future<void> _showRequiredLogin() async {
    await DialogUtils.showRequiredLogin(context);
    _navigateToLogin();
  }

  void _navigateToLogin() {
    if (mounted) {
      NavigationUtils.navigateTo(
        context: context,
        path: AppPaths.login,
      );
    }
  }

  void _getParkingInfo() async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      await _showRequiredLogin();

      return;
    }

    _parkingInfoSubscription =
        _getParkingInfoInteractor.execute(parkingId: parkingId).listen(
              (result) => result.fold(
                _handleGetParkingInfoFailure,
                _handleGetParkingInfoSuccess,
              ),
            );
  }

  void _getCurrentEmployee() async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      await _showRequiredLogin();

      return;
    }

    _currentEmployeeSubscription =
        _getCurrentEmployeeInteractor.execute(parkingId: parkingId).listen(
              (result) => result.fold(
                _handleGetCurrentEmployeeFailure,
                _handleGetCurrentEmployeeSuccess,
              ),
            );
  }

  void _getTicket() {
    final parkingId = _profileService.parkingOwner?.parkingId;

    if (parkingId == null) {
      return;
    }

    _getTicketInteractor.execute(parkingId: parkingId).listen(
          (result) => result.fold(
            _handleGetTicketFailure,
            _handleGetTicketSuccess,
          ),
        );
  }

  void _unsubscribeListenRealtime() {
    Supabase.instance.client
        .channel('${AppConfig.appTitle}/live_overview')
        .unsubscribe();
  }

  void _disposeNotifiers() {
    rowPerPageCurrentEmployeesNotifier.dispose();
    rowPerPageCurrentTicketsNotifier.dispose();
    getParkingInfoStateNotifier.dispose();
    getCurrentEmployeeStateNotifier.dispose();
    parkingOccupied.dispose();
    countCurrentEmployee.dispose();
    currentEmployeesNotifier.dispose();
    totalCustomersNotifier.dispose();
    totalRevenueNotifier.dispose();
    currentParkingLotAllotmentNotifier.dispose();
    getTicketStateNotifier.dispose();
    rowPerPageAllTicketsNotifier.dispose();
  }

  void _disposeSubscriptions() {
    _parkingInfoSubscription?.cancel();
    _currentEmployeeSubscription?.cancel();
    _parkingInfoSubscription = null;
    _currentEmployeeSubscription = null;
  }

  String getFormattedCurrency(num value) {
    const String defaultLocale = 'vi_VN';

    String locale = defaultLocale;

    final profile = _profileService.userProfile;

    if (profile != null && _profileService.isAuthenticated) {
      if (profile.accountType == AccountType.employee) {
        final employee = _profileService.parkingEmployee;

        if (employee != null) {
          locale = employee.currencyLocale;
        }
      } else if (profile.accountType == AccountType.parkingOwner) {
        final owner = _profileService.parkingOwner;

        if (owner != null) {
          locale = owner.currencyLocale;
        }
      }
    }

    final format = NumberFormat.simpleCurrency(locale: locale);

    return format.format(value);
  }

  List<DataRow> currentEmployeeRow(List<EmployeeNestedInfo> employee) {
    if (employee.isEmpty) {
      return [
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(
                'N/A',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            DataCell(
              Text(
                'N/A',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            DataCell(
              Text(
                'N/A',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            DataCell(
              Text(
                'N/A',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ],
        )
      ];
    }

    return employee
        .map(
          (e) => DataRow(
            //TODO: Show employee info when press on row
            cells: <DataCell>[
              DataCell(
                Text(
                  e.id,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.profile.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.profile.email,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.profile.phone ?? '',
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

  List<DataRow> currentTicketRow(List<TicketInfo> tickets) {
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

    if (tickets.isEmpty) {
      return <DataRow>[
        DataRow(cells: <DataCell>[
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
            ),
          ),
        ]),
      ];
    }

    return tickets
        .map(
          (e) => DataRow(
            //TODO: Show ticket info in dialog when press on row
            cells: <DataCell>[
              DataCell(
                Text(
                  e.vehicle?.licensePlate ?? '',
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
                  e.exitTime != null
                      ? DateFormat('hh:mm a').format(e.exitTime!)
                      : '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  DateFormat('hh:mm a').format(e.startTime),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  DateFormat('hh:mm a').format(e.endTime),
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
                  getFormattedCurrency(e.total),
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

  List<DataRow> allTicketRow(List<TicketInfo> tickets) {
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

    if (tickets.isEmpty) {
      return <DataRow>[
        DataRow(cells: <DataCell>[
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          DataCell(
            Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
            ),
          ),
        ]),
      ];
    }

    return tickets
        .map(
          (e) => DataRow(
            //TODO: Show ticket info in dialog when press on row
            cells: <DataCell>[
              DataCell(
                Text(
                  e.vehicle?.licensePlate ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.entryTime != null
                      ? DateFormat('hh:mm a yyy/MM/dd ').format(e.entryTime!)
                      : '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  e.exitTime != null
                      ? DateFormat('hh:mm a yyy/MM/dd').format(e.exitTime!)
                      : '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  DateFormat('hh:mm a yyy/MM/dd').format(e.startTime),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              DataCell(
                Text(
                  DateFormat('hh:mm a yyy/MM/dd').format(e.endTime),
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
                  getFormattedCurrency(e.total),
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

  void onAllTicketRowsPerPageChanged(int? selectedRowsPerPage) {
    if (selectedRowsPerPage != null) {
      rowPerPageAllTicketsNotifier.value = selectedRowsPerPage;
    }
  }

  void onCheckInPressed() {
    loggy.info('Check In Pressed');
    //TODO: Check In
  }

  void onCheckOutPressed() {
    loggy.info('Check Out Pressed');
    //TODO: Check Out
  }

  void openScanner() {
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.scanner,
    );
  }

  void _handleGetParkingInfoFailure(Failure failure) {
    if (failure is GetParkingInfoFailure) {
      getParkingInfoStateNotifier.value = failure;
    } else if (failure is GetParkingInfoEmpty) {
      getParkingInfoStateNotifier.value = failure;
    } else {
      getParkingInfoStateNotifier.value =
          GetParkingInfoFailure(exception: failure);
    }
  }

  void _handleGetParkingInfoSuccess(Success success) {
    if (success is GetParkingInfoSuccess) {
      getParkingInfoStateNotifier.value = success;
      parkingOccupied.value = ParkingOccupied(
        occupied:
            success.parkingInfo.totalSlot - success.parkingInfo.availableSlot,
        total: success.parkingInfo.totalSlot,
      );
    } else if (success is GetParkingInfoLoading) {
      getParkingInfoStateNotifier.value = success;
    }
  }

  void _handleGetCurrentEmployeeFailure(Failure failure) {
    if (failure is GetCurrentEmployeeFailure) {
      getCurrentEmployeeStateNotifier.value = failure;
    } else {
      getCurrentEmployeeStateNotifier.value =
          GetCurrentEmployeeFailure(exception: failure);
    }
  }

  void _handleGetCurrentEmployeeSuccess(Success success) {
    if (success is GetCurrentEmployeeSuccess) {
      getCurrentEmployeeStateNotifier.value = success;
      currentEmployeesNotifier.value = success.employees;
      countCurrentEmployee.value = success.employees.length;
    } else if (success is GetCurrentEmployeeLoading) {
      getCurrentEmployeeStateNotifier.value = success;
    } else if (success is GetCurrentEmployeeEmpty) {
      loggy.info('GetCurrentEmployeeEmpty');
      getCurrentEmployeeStateNotifier.value = success;
    }
  }

  void _handleGetTicketFailure(Failure failure) {
    if (failure is GetTicketFailure) {
      getTicketStateNotifier.value = failure;
    } else {
      getTicketStateNotifier.value = GetTicketFailure(exception: failure);
    }
  }

  void _handleGetTicketSuccess(Success success) {
    if (success is GetTicketSuccess) {
      getTicketStateNotifier.value = success;
      final formatter = DateFormat('yyyy-MM-dd');
      final now = formatter.format(DateTime.now());
      List<TicketInfo> currentTickets = [];
      for (final ticket in success.tickets) {
        final entryTime = ticket.entryTime;
        final exitTime = ticket.exitTime;
        final startTime = ticket.startTime;
        final endTime = ticket.endTime;
        final startDate = formatter.format(startTime);
        final endDate = formatter.format(endTime);

        if (startDate == now || endDate == now) {
          currentTickets.add(ticket);
        } else if (entryTime != null) {
          final entryDate = formatter.format(entryTime);
          if (entryDate == now) {
            currentTickets.add(ticket);
          }
        } else if (exitTime != null) {
          final exitDate = formatter.format(exitTime);
          if (exitDate == now) {
            currentTickets.add(ticket);
          }
        }
      }
      currentParkingLotAllotmentNotifier.value = currentTickets;
      totalCustomersNotifier.value = currentTickets.length;
      for (final ticket in currentTickets) {
        totalRevenueNotifier.value += ticket.total;
      }
    } else if (success is GetTicketLoading) {
      getTicketStateNotifier.value = success;
    } else if (success is GetTicketEmpty) {
      getTicketStateNotifier.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => LiveOverviewView(controller: this);
}
