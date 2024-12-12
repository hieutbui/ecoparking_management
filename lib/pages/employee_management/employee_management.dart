import 'package:ecoparking_management/data/models/live_overview/current_employee_info.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management_view.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({super.key});

  @override
  EmployeeManagementController createState() => EmployeeManagementController();
}

class EmployeeManagementController extends State<EmployeeManagement>
    with ControllerLoggy {
  //TODO: Implement fetch data from API
  final int totalEmployees = 10;
  final int onDutyEmployees = 5;

  final List<String> listEmployeesTableTitles = <String>[
    'Employee ID',
    'Name',
    'Email',
    'Phone',
  ];

  final List<CurrentEmployeeInfo> listEmployees = <CurrentEmployeeInfo>[
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
    const CurrentEmployeeInfo(
      id: '3',
      employeeId: '3',
      name: 'Employee 3',
      email: 'employ3@example.com',
      phone: '0123456789',
    ),
    const CurrentEmployeeInfo(
      id: '4',
      employeeId: '4',
      name: 'Employee 4',
      email: 'employ4@example.com',
      phone: '0123456789',
    ),
    const CurrentEmployeeInfo(
      id: '5',
      employeeId: '5',
      name: 'Employee 5',
      email: 'employ5@example.com',
      phone: '0123456789',
    ),
    const CurrentEmployeeInfo(
      id: '6',
      employeeId: '6',
      name: 'Employee 6',
      email: 'employ6@example.com',
      phone: '0123456789',
    ),
    const CurrentEmployeeInfo(
      id: '7',
      employeeId: '7',
      name: 'Employee 7',
      email: 'employ7@example.com',
      phone: '0123456789',
    ),
    const CurrentEmployeeInfo(
      id: '8',
      employeeId: '8',
      name: 'Employee 8',
      email: 'employ8@example.com',
      phone: '0123456789',
    ),
    const CurrentEmployeeInfo(
      id: '9',
      employeeId: '9',
      name: 'Employee 9',
      email: 'employ9@example.com',
      phone: '0123456789',
    ),
    const CurrentEmployeeInfo(
      id: '10',
      employeeId: '10',
      name: 'Employee 10',
      email: 'employ10@example.com',
      phone: '0123456789',
    ),
  ];

  final ValueNotifier<int> rowPerPage =
      ValueNotifier<int>(PaginatedDataTable.defaultRowsPerPage);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DataRow> currentEmployeeRow(List<CurrentEmployeeInfo> employees) {
    return employees
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

  @override
  Widget build(BuildContext context) =>
      EmployeeManagementView(controller: this);
}
