import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/domain/state/analysis/export_data_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_last_12_months_ticket_count_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_last_12_months_total_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_last_month_ticket_count_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_last_month_total_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_last_year_ticket_count_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_last_year_total_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_yesterday_ticket_count_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_yesterday_total_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/usecase/analysis/export_data_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_12_months_ticket_count_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_12_months_total_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_month_ticket_count_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_month_total_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_year_ticket_count_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_year_total_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_yesterday_ticket_count_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_yesterday_total_interactor.dart';
import 'package:ecoparking_management/pages/previous_analysis/dropdown_area.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis_view.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis_view_type.dart';
import 'package:ecoparking_management/pages/previous_analysis/widgets/bar_chart_info/bar_chart_info_args.dart';
import 'package:ecoparking_management/utils/dialog_utils.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PreviousAnalysis extends StatefulWidget {
  const PreviousAnalysis({super.key});

  @override
  PreviousAnalysisController createState() => PreviousAnalysisController();
}

class PreviousAnalysisController extends State<PreviousAnalysis>
    with ControllerLoggy {
  final ProfileService _profileService = getIt.get<ProfileService>();

  final GetLast12MonthsTotalInteractor _getLast12MonthsTotalInteractor =
      getIt.get<GetLast12MonthsTotalInteractor>();
  final GetLastYearTotalInteractor _getLastYearTotalInteractor =
      getIt.get<GetLastYearTotalInteractor>();
  final GetLastMonthTotalInteractor _getLastMonthTotalInteractor =
      getIt.get<GetLastMonthTotalInteractor>();
  final GetYesterdayTotalInteractor _getYesterdayTotalInteractor =
      getIt.get<GetYesterdayTotalInteractor>();
  final GetLast12MonthsTicketCountInteractor
      _getLast12MonthsTicketCountInteractor =
      getIt.get<GetLast12MonthsTicketCountInteractor>();
  final GetLastYearTicketCountInteractor _getLastYearTicketCountInteractor =
      getIt.get<GetLastYearTicketCountInteractor>();
  final GetLastMonthTicketCountInteractor _getLastMonthTicketCountInteractor =
      getIt.get<GetLastMonthTicketCountInteractor>();
  final GetYesterdayTicketCountInteractor _getYesterdayTicketCountInteractor =
      getIt.get<GetYesterdayTicketCountInteractor>();
  final ExportDataInteractor _exportDataInteractor =
      getIt.get<ExportDataInteractor>();

  final ValueNotifier<GetLast12MonthsTotalState> getLast12MonthsTotalState =
      ValueNotifier<GetLast12MonthsTotalState>(
    const GetLast12MonthsTotalInitial(),
  );
  final ValueNotifier<GetLastMonthTotalState> getLastMonthTotalState =
      ValueNotifier<GetLastMonthTotalState>(
    const GetLastMonthTotalInitial(),
  );
  final ValueNotifier<GetLastYearTotalState> getLastYearTotalState =
      ValueNotifier<GetLastYearTotalState>(
    const GetLastYearTotalInitial(),
  );
  final ValueNotifier<GetYesterdayTotalState> getYesterdayTotalState =
      ValueNotifier<GetYesterdayTotalState>(
    const GetYesterdayTotalInitial(),
  );
  final ValueNotifier<GetLast12MonthsTicketCountState>
      getLast12MonthsTicketCountState =
      ValueNotifier<GetLast12MonthsTicketCountState>(
    const GetLast12MonthsTicketCountInitial(),
  );
  final ValueNotifier<GetLastYearTicketCountState> getLastYearTicketCountState =
      ValueNotifier<GetLastYearTicketCountState>(
    const GetLastYearTicketCountInitial(),
  );
  final ValueNotifier<GetLastMonthTicketCountState>
      getLastMonthTicketCountState =
      ValueNotifier<GetLastMonthTicketCountState>(
    const GetLastMonthTicketCountInitial(),
  );
  final ValueNotifier<GetYesterdayTicketCountState>
      getYesterdayTicketCountState =
      ValueNotifier<GetYesterdayTicketCountState>(
    const GetYesterdayTicketCountInitial(),
  );
  final ValueNotifier<ExportDataState> exportRevenueState =
      ValueNotifier<ExportDataState>(
    const ExportDataInitial(),
  );
  final ValueNotifier<ExportDataState> exportVehicleCountState =
      ValueNotifier<ExportDataState>(
    const ExportDataInitial(),
  );

  final ValueNotifier<List<BarValue>> revenueChartValues =
      ValueNotifier<List<BarValue>>(<BarValue>[]);
  final ValueNotifier<List<BarValue>> vehicleCountChartValues =
      ValueNotifier<List<BarValue>>(<BarValue>[]);
  final ValueNotifier<num> totalRevenue = ValueNotifier<num>(0);
  final ValueNotifier<int> totalVehicleCount = ValueNotifier<int>(0);

  // TODO: Remove
  final ValueNotifier<PreviousAnalysisViewType> viewTypeRevenue =
      ValueNotifier<PreviousAnalysisViewType>(
    PreviousAnalysisViewType.last12months,
  );

  final ValueNotifier<PreviousAnalysisViewType> viewTypeVehicleCount =
      ValueNotifier<PreviousAnalysisViewType>(
    PreviousAnalysisViewType.last12months,
  );

  final ValueNotifier<PreviousAnalysisViewType> viewTypeTotalRevenue =
      ValueNotifier<PreviousAnalysisViewType>(
    PreviousAnalysisViewType.last12months,
  );

  final ValueNotifier<PreviousAnalysisViewType> viewTypeTotalVehicleCount =
      ValueNotifier<PreviousAnalysisViewType>(
    PreviousAnalysisViewType.last12months,
  );

  StreamSubscription<Either<Failure, Success>>? _last12MonthsTotalSubscription;
  StreamSubscription<Either<Failure, Success>>? _lastYearTotalSubscription;
  StreamSubscription<Either<Failure, Success>>? _lastMonthTotalSubscription;
  StreamSubscription<Either<Failure, Success>>? _yesterdayTotalSubscription;
  StreamSubscription<Either<Failure, Success>>?
      _last12MonthsTicketCountSubscription;
  StreamSubscription<Either<Failure, Success>>?
      _lastYearTicketCountSubscription;
  StreamSubscription<Either<Failure, Success>>?
      _lastMonthTicketCountSubscription;
  StreamSubscription<Either<Failure, Success>>?
      _yesterdayTicketCountSubscription;
  StreamSubscription<Either<Failure, Success>>? _exportRevenueSubscription;
  StreamSubscription<Either<Failure, Success>>? _exportVehicleCountSubscription;

  @override
  void initState() {
    super.initState();
    _getLast12MonthsTotal(
      dropdownArea: DropdownArea.chart,
    );
    _getLast12MonthsTotal(
      dropdownArea: DropdownArea.total,
    );
    _getLast12MonthsTicketCount(
      dropdownArea: DropdownArea.chart,
    );
    _getLast12MonthsTicketCount(
      dropdownArea: DropdownArea.total,
    );
  }

  @override
  void dispose() {
    _cancelSubscriptions();
    _disposeNotifiers();
    super.dispose();
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

  void _disposeNotifiers() {
    viewTypeRevenue.dispose();
    viewTypeVehicleCount.dispose();
    viewTypeTotalRevenue.dispose();
    viewTypeTotalVehicleCount.dispose();

    getLast12MonthsTotalState.dispose();
    getLastYearTotalState.dispose();
    getLastMonthTotalState.dispose();
    getYesterdayTotalState.dispose();
    revenueChartValues.dispose();
    vehicleCountChartValues.dispose();
    getLast12MonthsTicketCountState.dispose();
    getLastYearTicketCountState.dispose();
    getLastMonthTicketCountState.dispose();
    getYesterdayTicketCountState.dispose();
    totalRevenue.dispose();
    totalVehicleCount.dispose();
    exportRevenueState.dispose();
    exportVehicleCountState.dispose();
  }

  void _cancelSubscriptions() {
    _last12MonthsTotalSubscription?.cancel();
    _lastYearTotalSubscription?.cancel();
    _lastMonthTotalSubscription?.cancel();
    _yesterdayTotalSubscription?.cancel();
    _last12MonthsTicketCountSubscription?.cancel();
    _lastYearTicketCountSubscription?.cancel();
    _lastMonthTicketCountSubscription?.cancel();
    _yesterdayTicketCountSubscription?.cancel();
    _exportRevenueSubscription?.cancel();
    _exportVehicleCountSubscription?.cancel();
    _last12MonthsTotalSubscription = null;
    _lastYearTotalSubscription = null;
    _lastMonthTotalSubscription = null;
    _yesterdayTotalSubscription = null;
    _last12MonthsTicketCountSubscription = null;
    _lastYearTicketCountSubscription = null;
    _lastMonthTicketCountSubscription = null;
    _yesterdayTicketCountSubscription = null;
    _exportRevenueSubscription = null;
    _exportVehicleCountSubscription = null;
  }

  String getFormattedCurrency(num value, String locale) {
    final format = NumberFormat.simpleCurrency(locale: locale);

    return format.format(value);
  }

  String getFormattedNumber(num value, String locale) {
    final format = NumberFormat.compact(locale: locale);

    return format.format(value);
  }

  void onSelectViewTypeRevenue(PreviousAnalysisViewType selectedViewType) {
    viewTypeRevenue.value = selectedViewType;
    switch (selectedViewType) {
      case PreviousAnalysisViewType.last12months:
        _getLast12MonthsTotal(
          dropdownArea: DropdownArea.chart,
        );
        break;
      case PreviousAnalysisViewType.lastYear:
        _getLastYearTotal(
          dropdownArea: DropdownArea.chart,
        );
        break;
      case PreviousAnalysisViewType.lastMonth:
        _getLastMonthTotal(
          dropdownArea: DropdownArea.chart,
        );
        break;
      case PreviousAnalysisViewType.yesterday:
        _getYesterdayTotal(
          dropdownArea: DropdownArea.chart,
        );
        break;
    }
  }

  void onSelectViewTypeVehicleCount(PreviousAnalysisViewType selectedViewType) {
    viewTypeVehicleCount.value = selectedViewType;
    switch (selectedViewType) {
      case PreviousAnalysisViewType.last12months:
        _getLast12MonthsTicketCount(
          dropdownArea: DropdownArea.chart,
        );
        break;
      case PreviousAnalysisViewType.lastYear:
        _getLastYearTicketCount(
          dropdownArea: DropdownArea.chart,
        );
        break;
      case PreviousAnalysisViewType.lastMonth:
        _getLastMonthTicketCount(
          dropdownArea: DropdownArea.chart,
        );
        break;
      case PreviousAnalysisViewType.yesterday:
        _getYesterdayTicketCount(
          dropdownArea: DropdownArea.chart,
        );
        break;
    }
  }

  void onSelectViewTypeTotalRevenue(PreviousAnalysisViewType selectedViewType) {
    viewTypeTotalRevenue.value = selectedViewType;
    switch (selectedViewType) {
      case PreviousAnalysisViewType.last12months:
        _getLast12MonthsTotal(
          dropdownArea: DropdownArea.total,
        );
        break;
      case PreviousAnalysisViewType.lastYear:
        _getLastYearTotal(
          dropdownArea: DropdownArea.total,
        );
        break;
      case PreviousAnalysisViewType.lastMonth:
        _getLastMonthTotal(
          dropdownArea: DropdownArea.total,
        );
        break;
      case PreviousAnalysisViewType.yesterday:
        _getYesterdayTotal(
          dropdownArea: DropdownArea.total,
        );
        break;
    }
  }

  void onSelectViewTypeTotalVehicleCount(
    PreviousAnalysisViewType selectedViewType,
  ) {
    viewTypeTotalVehicleCount.value = selectedViewType;
    switch (selectedViewType) {
      case PreviousAnalysisViewType.last12months:
        _getLast12MonthsTicketCount(
          dropdownArea: DropdownArea.total,
        );
        break;
      case PreviousAnalysisViewType.lastYear:
        _getLastYearTicketCount(
          dropdownArea: DropdownArea.total,
        );
        break;
      case PreviousAnalysisViewType.lastMonth:
        _getLastMonthTicketCount(
          dropdownArea: DropdownArea.total,
        );
        break;
      case PreviousAnalysisViewType.yesterday:
        _getYesterdayTicketCount(
          dropdownArea: DropdownArea.total,
        );
        break;
    }
  }

  void onExportRevenue() async {
    loggy.info('Export revenue');
    List<String> listTitles;

    switch (viewTypeRevenue.value) {
      case PreviousAnalysisViewType.last12months:
        listTitles = <String>[
          'Tháng',
          'Doanh thu',
        ];
        break;
      case PreviousAnalysisViewType.lastYear:
        listTitles = <String>[
          'Tháng',
          'Doanh thu',
        ];
        break;
      case PreviousAnalysisViewType.lastMonth:
        listTitles = <String>[
          'Ngày',
          'Doanh thu',
        ];
        break;
      case PreviousAnalysisViewType.yesterday:
        listTitles = <String>[
          'Giờ',
          'Doanh thu',
        ];
        break;
    }

    final listDatas = revenueChartValues.value
        .map(
          (e) => AnalysisData(
            valueX: e.valueX,
            name: e.name,
            valueY: e.valueY,
          ),
        )
        .toList();

    final action = await DialogUtils.showExportDataDialog(
      context: context,
      onExportData: () => _exportRevenue(
        listTitles: listTitles,
        listDatas: listDatas,
      ),
      notifier: exportRevenueState,
    );

    switch (action) {
      case ConfirmAction.ok:
      case ConfirmAction.cancel:
      default:
        return;
    }
  }

  void onExportVehicleCount() async {
    loggy.info('Export vehicle count');
    List<String> listTitles;

    switch (viewTypeVehicleCount.value) {
      case PreviousAnalysisViewType.last12months:
        listTitles = <String>[
          'Tháng',
          'Số lượng xe',
        ];
        break;
      case PreviousAnalysisViewType.lastYear:
        listTitles = <String>[
          'Tháng',
          'Số lượng xe',
        ];
        break;
      case PreviousAnalysisViewType.lastMonth:
        listTitles = <String>[
          'Ngày',
          'Số lượng xe',
        ];
        break;
      case PreviousAnalysisViewType.yesterday:
        listTitles = <String>[
          'Giờ',
          'Số lượng xe',
        ];
        break;
    }

    final listDatas = vehicleCountChartValues.value
        .map(
          (e) => AnalysisData(
            valueX: e.valueX,
            name: e.name,
            valueY: e.valueY,
          ),
        )
        .toList();

    final action = await DialogUtils.showExportDataDialog(
      context: context,
      onExportData: () => _exportVehicleCount(
        listTitles: listTitles,
        listDatas: listDatas,
      ),
      notifier: exportVehicleCountState,
    );

    switch (action) {
      case ConfirmAction.ok:
      case ConfirmAction.cancel:
      default:
        return;
    }
  }

  void _exportRevenue({
    required List<String> listTitles,
    required List<AnalysisData> listDatas,
  }) {
    _exportRevenueSubscription = _exportDataInteractor
        .execute(listTitles: listTitles, listDatas: listDatas)
        .listen(
          (result) => result.fold(
            _handleExportRevenueFailure,
            _handleExportRevenueSuccess,
          ),
        );
  }

  void _exportVehicleCount({
    required List<String> listTitles,
    required List<AnalysisData> listDatas,
  }) {
    _exportVehicleCountSubscription = _exportDataInteractor
        .execute(listTitles: listTitles, listDatas: listDatas)
        .listen(
          (result) => result.fold(
            _handleExportVehicleCountFailure,
            _handleExportVehicleCountSuccess,
          ),
        );
  }

  Future<void> _getLast12MonthsTotal({
    required DropdownArea dropdownArea,
  }) async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      await _showRequiredLogin();

      return;
    }

    _last12MonthsTotalSubscription =
        _getLast12MonthsTotalInteractor.execute(parkingId: parkingId).listen(
              (result) => result.fold(
                _handleGetLast12MonthsTotalFailure,
                (success) => _handleGetLast12MonthsTotalSuccess(
                  success,
                  dropdownArea: dropdownArea,
                ),
              ),
            );
  }

  Future<void> _getLastYearTotal({
    required DropdownArea dropdownArea,
  }) async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      await _showRequiredLogin();

      return;
    }

    _lastYearTotalSubscription =
        _getLastYearTotalInteractor.execute(parkingId: parkingId).listen(
              (result) => result.fold(
                _handleGetLastYearTotalFailure,
                (success) => _handleGetLastYearTotalSuccess(
                  success,
                  dropdownArea: dropdownArea,
                ),
              ),
            );
  }

  Future<void> _getLastMonthTotal({
    required DropdownArea dropdownArea,
  }) async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      await _showRequiredLogin();

      return;
    }

    _lastMonthTotalSubscription =
        _getLastMonthTotalInteractor.execute(parkingId: parkingId).listen(
              (result) => result.fold(
                _handleGetLastMonthTotalFailure,
                (success) => _handleGetLastMonthTotalSuccess(
                  success,
                  dropdownArea: dropdownArea,
                ),
              ),
            );
  }

  Future<void> _getYesterdayTotal({
    required DropdownArea dropdownArea,
  }) async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      await _showRequiredLogin();

      return;
    }

    _yesterdayTotalSubscription =
        _getYesterdayTotalInteractor.execute(parkingId: parkingId).listen(
              (result) => result.fold(
                _handleGetYesterdayTotalFailure,
                (success) => _handleGetYesterdayTotalSuccess(
                  success,
                  dropdownArea: dropdownArea,
                ),
              ),
            );
  }

  Future<void> _getLast12MonthsTicketCount({
    required DropdownArea dropdownArea,
  }) async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      await _showRequiredLogin();

      return;
    }

    _last12MonthsTicketCountSubscription = _getLast12MonthsTicketCountInteractor
        .execute(parkingId: parkingId)
        .listen(
          (result) => result.fold(
            _handleGetLast12MonthsTicketCountFailure,
            (success) => _handleGetLast12MonthsTicketCountSuccess(
              success,
              dropdownArea: dropdownArea,
            ),
          ),
        );
  }

  Future<void> _getLastYearTicketCount({
    required DropdownArea dropdownArea,
  }) async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      await _showRequiredLogin();

      return;
    }

    _lastYearTicketCountSubscription =
        _getLastYearTicketCountInteractor.execute(parkingId: parkingId).listen(
              (result) => result.fold(
                _handleGetLastYearTicketCountFailure,
                (success) => _handleGetLastYearTicketCountSuccess(
                  success,
                  dropdownArea: dropdownArea,
                ),
              ),
            );
  }

  Future<void> _getLastMonthTicketCount({
    required DropdownArea dropdownArea,
  }) async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      await _showRequiredLogin();

      return;
    }

    _lastMonthTicketCountSubscription =
        _getLastMonthTicketCountInteractor.execute(parkingId: parkingId).listen(
              (result) => result.fold(
                _handleGetLastMonthTicketCountFailure,
                (success) => _handleGetLastMonthTicketCountSuccess(
                  success,
                  dropdownArea: dropdownArea,
                ),
              ),
            );
  }

  Future<void> _getYesterdayTicketCount({
    required DropdownArea dropdownArea,
  }) async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      await _showRequiredLogin();

      return;
    }

    _yesterdayTicketCountSubscription =
        _getYesterdayTicketCountInteractor.execute(parkingId: parkingId).listen(
              (result) => result.fold(
                _handleGetYesterdayTicketCountFailure,
                (success) => _handleGetYesterdayTicketCountSuccess(
                  success,
                  dropdownArea: dropdownArea,
                ),
              ),
            );
  }

  String getCurrencyLocale() {
    const defaultLocale = 'vi_VN';

    String locale = defaultLocale;

    final profile = _profileService.userProfile;

    if (profile == null || !_profileService.isAuthenticated) {
      return locale;
    }

    if (profile.accountType == AccountType.employee) {
      final parkingEmployee = _profileService.parkingEmployee;

      if (parkingEmployee == null) {
        return locale;
      } else {
        return parkingEmployee.currencyLocale;
      }
    } else if (profile.accountType == AccountType.parkingOwner) {
      final parkingOwner = _profileService.parkingOwner;

      if (parkingOwner == null) {
        return locale;
      } else {
        return parkingOwner.currencyLocale;
      }
    }

    return locale;
  }

  void _handleGetLast12MonthsTotalFailure(Failure failure) {
    loggy.error('Get last 12 months total failure: $failure');
    if (failure is GetLast12MonthsTotalFailure) {
      getLast12MonthsTotalState.value = failure;
    } else {
      getLast12MonthsTotalState.value =
          GetLast12MonthsTotalFailure(exception: failure);
    }
  }

  void _handleGetLast12MonthsTotalSuccess(
    Success success, {
    required DropdownArea dropdownArea,
  }) {
    loggy.info('Get last 12 months total success: $success');
    if (success is GetLast12MonthsTotalEmpty) {
      getLast12MonthsTotalState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        revenueChartValues.value = <BarValue>[];
      } else {
        totalRevenue.value = 0;
      }
    } else if (success is GetLast12MonthsTotalLoading) {
      getLast12MonthsTotalState.value = success;
    } else if (success is GetLast12MonthsTotalSuccess) {
      getLast12MonthsTotalState.value = success;

      if (dropdownArea == DropdownArea.chart) {
        revenueChartValues.value = success.data
            .map(
              (e) => BarValue(
                valueX: e.valueX,
                name: e.name,
                valueY: e.valueY,
              ),
            )
            .toList();
      } else {
        for (final item in success.data) {
          totalRevenue.value += item.valueY;
        }
      }
    }
  }

  void _handleGetLastYearTotalFailure(Failure failure) {
    loggy.error('Get last year total failure: $failure');
    if (failure is GetLastYearTotalFailure) {
      getLastYearTotalState.value = failure;
    } else {
      getLastYearTotalState.value = GetLastYearTotalFailure(exception: failure);
    }
  }

  void _handleGetLastYearTotalSuccess(
    Success success, {
    required DropdownArea dropdownArea,
  }) {
    loggy.info('Get last year total success: $success');
    if (success is GetLastYearTotalEmpty) {
      getLastYearTotalState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        revenueChartValues.value = <BarValue>[];
      } else {
        totalRevenue.value = 0;
      }
    } else if (success is GetLastYearTotalLoading) {
      getLastYearTotalState.value = success;
    } else if (success is GetLastYearTotalSuccess) {
      getLastYearTotalState.value = success;

      if (dropdownArea == DropdownArea.chart) {
        revenueChartValues.value = success.data
            .map(
              (e) => BarValue(
                valueX: e.valueX,
                name: e.name,
                valueY: e.valueY,
              ),
            )
            .toList();
      } else {
        for (final item in success.data) {
          totalRevenue.value += item.valueY;
        }
      }
    }
  }

  void _handleGetLastMonthTotalFailure(Failure failure) {
    loggy.error('Get last month total failure: $failure');
    if (failure is GetLastMonthTotalFailure) {
      getLastMonthTotalState.value = failure;
    } else {
      getLastMonthTotalState.value =
          GetLastMonthTotalFailure(exception: failure);
    }
  }

  void _handleGetLastMonthTotalSuccess(
    Success success, {
    required DropdownArea dropdownArea,
  }) {
    loggy.info('Get last month total success: $success');
    if (success is GetLastMonthTotalEmpty) {
      getLastMonthTotalState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        revenueChartValues.value = <BarValue>[];
      } else {
        totalRevenue.value = 0;
      }
    } else if (success is GetLastMonthTotalLoading) {
      getLastMonthTotalState.value = success;
    } else if (success is GetLastMonthTotalSuccess) {
      getLastMonthTotalState.value = success;

      if (dropdownArea == DropdownArea.chart) {
        revenueChartValues.value = success.data
            .map(
              (e) => BarValue(
                valueX: e.valueX,
                name: e.name,
                valueY: e.valueY,
              ),
            )
            .toList();
      } else {
        for (final item in success.data) {
          totalRevenue.value += item.valueY;
        }
      }
    }
  }

  void _handleGetYesterdayTotalFailure(Failure failure) {
    loggy.error('Get yesterday total failure: $failure');
    if (failure is GetYesterdayTotalFailure) {
      getYesterdayTotalState.value = failure;
    } else {
      getYesterdayTotalState.value =
          GetYesterdayTotalFailure(exception: failure);
    }
  }

  void _handleGetYesterdayTotalSuccess(
    Success success, {
    required DropdownArea dropdownArea,
  }) {
    loggy.info('Get yesterday total success: $success');
    if (success is GetYesterdayTotalEmpty) {
      getYesterdayTotalState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        revenueChartValues.value = <BarValue>[];
      } else {
        totalRevenue.value = 0;
      }
    } else if (success is GetYesterdayTotalLoading) {
      getYesterdayTotalState.value = success;
    } else if (success is GetYesterdayTotalSuccess) {
      getYesterdayTotalState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        revenueChartValues.value = success.data
            .map(
              (e) => BarValue(
                valueX: e.valueX,
                name: e.name,
                valueY: e.valueY,
              ),
            )
            .toList();
      } else {
        for (final item in success.data) {
          totalRevenue.value += item.valueY;
        }
      }
    }
  }

  void _handleGetLast12MonthsTicketCountFailure(Failure failure) {
    loggy.error('Get last 12 months ticket count failure: $failure');
    if (failure is GetLast12MonthsTicketCountFailure) {
      getLast12MonthsTicketCountState.value = failure;
    } else {
      getLast12MonthsTicketCountState.value =
          GetLast12MonthsTicketCountFailure(exception: failure);
    }
  }

  void _handleGetLast12MonthsTicketCountSuccess(
    Success success, {
    required DropdownArea dropdownArea,
  }) {
    loggy.info('Get last 12 months ticket count success: $success');
    if (success is GetLast12MonthsTicketCountEmpty) {
      getLast12MonthsTicketCountState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        vehicleCountChartValues.value = <BarValue>[];
      } else {
        totalVehicleCount.value = 0;
      }
    } else if (success is GetLast12MonthsTicketCountLoading) {
      getLast12MonthsTicketCountState.value = success;
    } else if (success is GetLast12MonthsTicketCountSuccess) {
      getLast12MonthsTicketCountState.value = success;

      if (dropdownArea == DropdownArea.chart) {
        vehicleCountChartValues.value = success.data
            .map(
              (e) => BarValue(
                valueX: e.valueX,
                name: e.name,
                valueY: e.valueY,
              ),
            )
            .toList();
      } else {
        for (final item in success.data) {
          totalVehicleCount.value += item.valueY.toInt();
        }
      }
    }
  }

  void _handleGetLastYearTicketCountFailure(Failure failure) {
    loggy.error('Get last year ticket count failure: $failure');
    if (failure is GetLastYearTicketCountFailure) {
      getLastYearTicketCountState.value = failure;
    } else {
      getLastYearTicketCountState.value =
          GetLastYearTicketCountFailure(exception: failure);
    }
  }

  void _handleGetLastYearTicketCountSuccess(
    Success success, {
    required DropdownArea dropdownArea,
  }) {
    loggy.info('Get last year ticket count success: $success');
    if (success is GetLastYearTicketCountEmpty) {
      getLastYearTicketCountState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        vehicleCountChartValues.value = <BarValue>[];
      } else {
        totalVehicleCount.value = 0;
      }
    } else if (success is GetLastYearTicketCountLoading) {
      getLastYearTicketCountState.value = success;
    } else if (success is GetLastYearTicketCountSuccess) {
      getLastYearTicketCountState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        vehicleCountChartValues.value = success.data
            .map(
              (e) => BarValue(
                valueX: e.valueX,
                name: e.name,
                valueY: e.valueY,
              ),
            )
            .toList();
      } else {
        for (final item in success.data) {
          totalVehicleCount.value += item.valueY.toInt();
        }
      }
    }
  }

  void _handleGetLastMonthTicketCountFailure(Failure failure) {
    loggy.error('Get last month ticket count failure: $failure');
    if (failure is GetLastMonthTicketCountFailure) {
      getLastMonthTicketCountState.value = failure;
    } else {
      getLastMonthTicketCountState.value =
          GetLastMonthTicketCountFailure(exception: failure);
    }
  }

  void _handleGetLastMonthTicketCountSuccess(
    Success success, {
    required DropdownArea dropdownArea,
  }) {
    loggy.info('Get last month ticket count success: $success');
    if (success is GetLastMonthTicketCountEmpty) {
      getLastMonthTicketCountState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        vehicleCountChartValues.value = <BarValue>[];
      } else {
        totalVehicleCount.value = 0;
      }
    } else if (success is GetLastMonthTicketCountLoading) {
      getLastMonthTicketCountState.value = success;
    } else if (success is GetLastMonthTicketCountSuccess) {
      getLastMonthTicketCountState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        vehicleCountChartValues.value = success.data
            .map(
              (e) => BarValue(
                valueX: e.valueX,
                name: e.name,
                valueY: e.valueY,
              ),
            )
            .toList();
      } else {
        for (final item in success.data) {
          totalVehicleCount.value += item.valueY.toInt();
        }
      }
    }
  }

  void _handleGetYesterdayTicketCountFailure(Failure failure) {
    loggy.error('Get yesterday ticket count failure: $failure');
    if (failure is GetYesterdayTicketCountFailure) {
      getYesterdayTicketCountState.value = failure;
    } else {
      getYesterdayTicketCountState.value =
          GetYesterdayTicketCountFailure(exception: failure);
    }
  }

  void _handleGetYesterdayTicketCountSuccess(
    Success success, {
    required DropdownArea dropdownArea,
  }) {
    loggy.info('Get yesterday ticket count success: $success');
    if (success is GetYesterdayTicketCountEmpty) {
      getYesterdayTicketCountState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        vehicleCountChartValues.value = <BarValue>[];
      } else {
        totalVehicleCount.value = 0;
      }
    } else if (success is GetYesterdayTicketCountLoading) {
      getYesterdayTicketCountState.value = success;
    } else if (success is GetYesterdayTicketCountSuccess) {
      getYesterdayTicketCountState.value = success;
      if (dropdownArea == DropdownArea.chart) {
        vehicleCountChartValues.value = success.data
            .map(
              (e) => BarValue(
                valueX: e.valueX,
                name: e.name,
                valueY: e.valueY,
              ),
            )
            .toList();
      } else {
        for (final item in success.data) {
          totalVehicleCount.value += item.valueY.toInt();
        }
      }
    }
  }

  void _handleExportRevenueFailure(Failure failure) {
    loggy.error('Export data failure: $failure');
    if (failure is ExportDataFailure) {
      exportRevenueState.value = failure;
    } else {
      exportRevenueState.value = ExportDataFailure(exception: failure);
    }
  }

  void _handleExportRevenueSuccess(Success success) {
    loggy.info('Export data success: $success');
    if (success is ExportDataSuccess) {
      exportRevenueState.value = success;
    } else if (success is ExportDataLoading) {
      exportRevenueState.value = success;
    }
  }

  void _handleExportVehicleCountFailure(Failure failure) {
    loggy.error('Export data failure: $failure');
    if (failure is ExportDataFailure) {
      exportVehicleCountState.value = failure;
    } else {
      exportVehicleCountState.value = ExportDataFailure(exception: failure);
    }
  }

  void _handleExportVehicleCountSuccess(Success success) {
    loggy.info('Export data success: $success');
    if (success is ExportDataSuccess) {
      exportVehicleCountState.value = success;
    } else if (success is ExportDataLoading) {
      exportVehicleCountState.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => PreviousAnalysisView(controller: this);
}
