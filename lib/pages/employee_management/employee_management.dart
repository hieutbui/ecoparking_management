import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/get_all_employee_state.dart';
import 'package:ecoparking_management/domain/state/employee/update_employee_working_time_state.dart';
import 'package:ecoparking_management/domain/usecase/employee/get_all_employee_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/update_employee_working_time_interactor.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management_view.dart';
import 'package:ecoparking_management/pages/employee_management/widgets/selectable_employee.dart';
import 'package:ecoparking_management/utils/dialog_utils.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({super.key});

  @override
  EmployeeManagementController createState() => EmployeeManagementController();
}

class EmployeeManagementController extends State<EmployeeManagement>
    with ControllerLoggy {
  final ProfileService _profileService = getIt.get<ProfileService>();

  final GetAllEmployeeInteractor _getAllEmployeeInteractor =
      getIt.get<GetAllEmployeeInteractor>();
  final UpdateEmployeeWorkingTimeInteractor
      _updateEmployeeWorkingTimeInteractor =
      getIt.get<UpdateEmployeeWorkingTimeInteractor>();

  final List<String> listEmployeesTableTitles = <String>[
    'Employee ID',
    'Name',
    'Email',
    'Phone',
  ];

  final ValueNotifier<GetAllEmployeeState> getAllEmployeeState =
      ValueNotifier<GetAllEmployeeState>(const GetAllEmployeeInitial());
  final ValueNotifier<UpdateEmployeeWorkingTimeState>
      updateEmployeeWorkingTimeState =
      ValueNotifier<UpdateEmployeeWorkingTimeState>(
          const UpdateEmployeeWorkingTimeInitial());

  final ValueNotifier<int> rowPerPage =
      ValueNotifier<int>(PaginatedDataTable.defaultRowsPerPage);
  final ValueNotifier<int> totalEmployees = ValueNotifier<int>(0);
  final ValueNotifier<int> onDutyEmployees = ValueNotifier<int>(0);
  final ValueNotifier<List<SelectableEmployee>> listEmployees =
      ValueNotifier<List<SelectableEmployee>>(<SelectableEmployee>[]);

  bool get isOwner =>
      _profileService.userProfile?.accountType == AccountType.parkingOwner;

  StreamSubscription<Either<Failure, Success>>? _getAllEmployeeSubscription;
  StreamSubscription<Either<Failure, Success>>?
      _updateEmployeeWorkingTimeSubscription;

  @override
  void initState() {
    super.initState();
    _checkPositionIsEmpty();
    _getAllEmployees();
  }

  @override
  void dispose() {
    _disposeNotifiers();
    _cancelSubscriptions();
    super.dispose();
  }

  void _disposeNotifiers() {
    getAllEmployeeState.dispose();
    rowPerPage.dispose();
    totalEmployees.dispose();
    onDutyEmployees.dispose();
    listEmployees.dispose();
    updateEmployeeWorkingTimeState.dispose();
  }

  void _cancelSubscriptions() {
    _getAllEmployeeSubscription?.cancel();
    _updateEmployeeWorkingTimeSubscription?.cancel();
  }

  Future<void> _checkPositionIsEmpty() async {
    final profile = _profileService.userProfile;

    if (profile == null || !_profileService.isAuthenticated) {
      await DialogUtils.showRequiredLogin(context);
      _navigateToLogin();

      return;
    }

    if (profile.accountType == AccountType.employee &&
        _profileService.parkingEmployee == null) {
      await DialogUtils.showRequiredLogin(context);
      _navigateToLogin();

      return;
    }

    if (profile.accountType == AccountType.parkingOwner &&
        _profileService.parkingOwner == null) {
      await DialogUtils.showRequiredLogin(context);
      _navigateToLogin();

      return;
    }

    return;
  }

  void _navigateToLogin() {
    if (mounted) {
      NavigationUtils.navigateTo(
        context: context,
        path: AppPaths.login,
      );
    }
  }

  void _getAllEmployees() {
    final owner = _profileService.parkingOwner;

    if (owner == null) return;

    _getAllEmployeeSubscription =
        _getAllEmployeeInteractor.execute(parkingId: owner.parkingId).listen(
              (result) => result.fold(
                _handleGetAllEmployeeFailure,
                _handleGetAllEmployeeSuccess,
              ),
            );
  }

  void onEmployeeSelected({
    required SelectableEmployee employee,
    bool? selected,
  }) {
    if (selected == null) return;

    if (selected == true) {
      final employees = listEmployees.value;
      final index = employees.indexWhere((e) => e == employee);

      if (index != -1) {
        employees[index] = employee.copyWith(isSelected: true);
        listEmployees.value = List.from(employees);
      }
    } else {
      final employees = listEmployees.value;
      final index = employees.indexWhere((e) => e == employee);

      if (index != -1) {
        employees[index] = employee.copyWith(isSelected: false);
        listEmployees.value = List.from(employees);
      }
    }
  }

  void onEmployeeLongPressed(SelectableEmployee employee) async {
    TimeOfDay? startShift = employee.employeeNestedInfo.workingStartTime;
    TimeOfDay? endShift = employee.employeeNestedInfo.workingEndTime;

    final ConfirmAction? action = await DialogUtils.showEmployeeInfoDialog(
        context: context,
        employeeNestedInfo: employee.employeeNestedInfo,
        onStartShiftSelected: (selectedTime) {
          startShift = selectedTime;
        },
        onEndShiftSelected: (selectedTime) {
          endShift = selectedTime;
        });

    switch (action) {
      case ConfirmAction.ok:
        loggy.info('Update Employee Working Time');
        if (startShift != null && endShift != null) {
          _updateEmployeeWorkingTime(
            employeeId: employee.employeeNestedInfo.id,
            startTime: '${startShift!.hour}:${startShift!.minute}',
            endTime: '${endShift!.hour}:${endShift!.minute}',
          );
        }
        return;
      case ConfirmAction.cancel:
      default:
        return;
    }
  }

  void _updateEmployeeWorkingTime({
    required String employeeId,
    required String startTime,
    required String endTime,
  }) {
    _updateEmployeeWorkingTimeSubscription =
        _updateEmployeeWorkingTimeInteractor
            .execute(
              employeeId: employeeId,
              startTime: startTime,
              endTime: endTime,
            )
            .listen(
              (result) => result.fold(
                _handleUpdateEmployeeWorkingTimeFailure,
                _handleUpdateEmployeeWorkingTimeSuccess,
              ),
            );
  }

  void onRowsPerPageChanged(int? value) {
    if (value != null) {
      rowPerPage.value = value;
    }
  }

  void onAddEmployeePressed() {
    loggy.info('Add Employee Pressed');
    //TODO: Add employee
  }

  void onRemoveEmployeePressed() {
    loggy.info('Remove Employee Pressed');
    //TODO: Remove employee
  }

  void onExportEmployeePressed() {
    loggy.info('Export Employee Pressed');
    //TODO: Export employee
  }

  void onSearchEmployee(String value) {
    loggy.info('Search Employee: $value');
    //TODO: Search employee
  }

  void _updateOnDutyEmployees(List<EmployeeNestedInfo> employees) {
    final now = DateTime.now();
    final onDuty = employees.where((e) {
      final startTime = e.workingStartTime;
      final endTime = e.workingEndTime;

      if (startTime == null || endTime == null) return false;

      final startDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        startTime.hour,
        startTime.minute,
      );
      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        endTime.hour,
        endTime.minute,
      );

      return now.isAfter(startDateTime) && now.isBefore(endDateTime);
    });

    onDutyEmployees.value = onDuty.length;
  }

  void _handleGetAllEmployeeFailure(Failure failure) {
    loggy.error('Get All Employee Failure: $failure');
    if (failure is GetAllEmployeeEmpty) {
      getAllEmployeeState.value = failure;
    } else if (failure is GetAllEmployeeFailure) {
      getAllEmployeeState.value = failure;
    } else {
      getAllEmployeeState.value = GetAllEmployeeFailure(exception: failure);
    }
  }

  void _handleGetAllEmployeeSuccess(Success success) {
    loggy.info('Get All Employee Success: $success');
    if (success is GetAllEmployeeSuccess) {
      getAllEmployeeState.value = success;
      totalEmployees.value = success.listEmployeeInfo.length;
      listEmployees.value = success.listEmployeeInfo
          .map(
            (e) => SelectableEmployee(employeeNestedInfo: e),
          )
          .toList();
      _updateOnDutyEmployees(success.listEmployeeInfo);
    } else if (success is GetAllEmployeeLoading) {
      getAllEmployeeState.value = success;
    }
  }

  void _handleUpdateEmployeeWorkingTimeFailure(Failure failure) {
    loggy.error('Update Employee Working Time Failure: $failure');
    if (failure is UpdateEmployeeWorkingTimeEmpty) {
      updateEmployeeWorkingTimeState.value = failure;
    } else if (failure is UpdateEmployeeWorkingTimeFailure) {
      updateEmployeeWorkingTimeState.value = failure;
    } else {
      updateEmployeeWorkingTimeState.value =
          UpdateEmployeeWorkingTimeFailure(exception: failure);
    }
  }

  void _handleUpdateEmployeeWorkingTimeSuccess(Success success) {
    loggy.info('Update Employee Working Time Success: $success');
    if (success is UpdateEmployeeWorkingTimeSuccess) {
      updateEmployeeWorkingTimeState.value = success;
      _getAllEmployees();
    } else if (success is UpdateEmployeeWorkingTimeLoading) {
      updateEmployeeWorkingTimeState.value = success;
    }
  }

  @override
  Widget build(BuildContext context) =>
      EmployeeManagementView(controller: this);
}
