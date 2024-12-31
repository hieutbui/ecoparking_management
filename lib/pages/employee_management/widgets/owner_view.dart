import 'package:ecoparking_management/config/app_config.dart';
import 'package:ecoparking_management/domain/state/employee/get_employee_attendance_state.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management_view_styles.dart';
import 'package:ecoparking_management/pages/employee_management/widgets/selectable_attendance.dart';
import 'package:ecoparking_management/pages/employee_management/widgets/selectable_employee.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/info_multi_columns.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/table_info.dart';
import 'package:ecoparking_management/widgets/info_card_with_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnerView extends StatelessWidget {
  final EmployeeManagementController controller;

  const OwnerView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: EmployeeManagementViewStyles.padding,
        child: Column(
          children: <Widget>[
            InfoMultiColumns(
              columns: <ColumnArguments>[
                ColumnArguments(
                  highlightedChild: ValueListenableBuilder(
                    valueListenable: controller.totalEmployees,
                    builder: (context, total, child) {
                      return Text(
                        total.toString(),
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      );
                    },
                  ),
                  secondaryChild: Text(
                    'Tổng số nhân viên',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                        ),
                  ),
                ),
                ColumnArguments(
                  highlightedChild: ValueListenableBuilder(
                    valueListenable: controller.onDutyEmployees,
                    builder: (context, onDuty, child) {
                      return Text(
                        onDuty.toString(),
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      );
                    },
                  ),
                  secondaryChild: Text(
                    'Số nhân viên đang làm việc',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: EmployeeManagementViewStyles.spacing,
            ),
            InfoCardWithTitle(
              title: 'Danh sách nhân viên',
              child: ValueListenableBuilder(
                valueListenable: controller.listEmployees,
                builder: (context, employees, child) {
                  final List<DataRow> dataRows = _employeeRow(
                    context: context,
                    employees: employees,
                    onEmployeeSelected: controller.onEmployeeSelected,
                    onLongPress: controller.onEmployeeLongPressed,
                  );

                  return ValueListenableBuilder(
                    valueListenable: controller.rowPerPage,
                    builder: (context, rowsPerPage, child) {
                      return TableInfo(
                        titles: controller.listEmployeesTableTitles,
                        data: dataRows,
                        emptyData: _emptyEmployeeRow(context: context),
                        rowPerPage: _getRowPerPage(
                          dataRows,
                          rowsPerPage,
                        ),
                        onRowsPerPageChanged: controller.onRowsPerPageChanged,
                        header: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                onChanged: controller.onSearchEmployee,
                                decoration: InputDecoration(
                                  hintText: 'Tìm kiếm nhân viên',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                  filled: true,
                                  fillColor: AppConfig.baseBackgroundColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton.icon(
                            onPressed: controller.onAddEmployeePressed,
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            label: Text(
                              'Thêm',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                Theme.of(context).colorScheme.secondary,
                              ),
                              shape:
                                  const WidgetStatePropertyAll<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: controller.onExportEmployeePressed,
                            icon: Icon(
                              Icons.download_rounded,
                              color: Theme.of(context).colorScheme.onTertiary,
                            ),
                            label: Text(
                              'Xuất',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary,
                                  ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                Theme.of(context).colorScheme.tertiary,
                              ),
                              shape:
                                  const WidgetStatePropertyAll<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: controller.onRemoveEmployeePressed,
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Xóa',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                Theme.of(context).colorScheme.error,
                              ),
                              shape:
                                  const WidgetStatePropertyAll<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: EmployeeManagementViewStyles.spacing,
            ),
            InfoCardWithTitle(
              title: 'Danh sách chấm công',
              child: ValueListenableBuilder(
                valueListenable: controller.getEmployeeAttendanceState,
                builder: (context, state, child) {
                  if (state is GetEmployeeAttendanceLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is GetEmployeeAttendanceFailure) {
                    return Center(
                      child: Text(
                        'Có lỗi xảy ra!',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                      ),
                    );
                  }

                  if (state is GetEmployeeAttendanceSuccess) {
                    final List<SelectableAttendance> attendances =
                        state.listAttendances
                            .map(
                              (e) => SelectableAttendance(
                                employeeAttendance: e,
                                isSelected: false,
                              ),
                            )
                            .toList();

                    final List<DataRow> data = _attendanceRow(
                      context: context,
                      attendances: attendances,
                      onAttendanceSelected: controller.onAttendanceSelected,
                      onLongPress: controller.onAttendanceLongPressed,
                    );

                    return ValueListenableBuilder(
                      valueListenable: controller.rowPerPageAttendance,
                      builder: (context, rowsPerPage, child) {
                        return TableInfo(
                          titles: controller.listAttendanceTableTitles,
                          data: data,
                          rowPerPage: _getRowPerPage(
                            data,
                            rowsPerPage,
                          ),
                          emptyData: _emptyAttendanceRow(context: context),
                          onRowsPerPageChanged:
                              controller.onRowsPerPageAttendanceChanged,
                          header: ValueListenableBuilder(
                            valueListenable: controller.attendanceStartDate,
                            builder: (context, date, child) {
                              final dateFormatter = DateFormat('dd/MM/yyyy');

                              return Row(
                                children: <Widget>[
                                  TextButton(
                                    onPressed: controller
                                        .onOpenAttendanceStartDatePicker,
                                    child: Text(
                                      dateFormatter.format(date),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    '-',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable:
                                        controller.attendanceEndDate,
                                    builder: (context, date, child) {
                                      return TextButton(
                                        onPressed: controller
                                            .onOpenAttendanceEndDatePicker,
                                        child: Text(
                                          dateFormatter.format(date),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  TextButton.icon(
                                    onPressed: controller.onFilterAttendance,
                                    icon: Icon(
                                      Icons.filter_alt_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    label: Text(
                                      'Lọc',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  }

                  if (state is GetEmployeeAttendanceEmpty) {
                    return const Center(
                      child: Text(
                        'Không có dữ liệu',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  return child!;
                },
                child: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int _getRowPerPage(List<DataRow> dataRow, int rowPerPage) {
  if (dataRow.length > rowPerPage) {
    return rowPerPage;
  }
  return dataRow.length;
}

List<DataRow> _employeeRow({
  required BuildContext context,
  required List<SelectableEmployee> employees,
  required void Function({
    required bool? selected,
    required SelectableEmployee employee,
  }) onEmployeeSelected,
  required void Function(SelectableEmployee employee) onLongPress,
}) {
  return employees
      .map(
        (e) => DataRow(
          selected: e.isSelected,
          onLongPress: () => onLongPress(e),
          onSelectChanged: (selected) => onEmployeeSelected(
            selected: selected,
            employee: e,
          ),
          cells: <DataCell>[
            DataCell(
              Text(
                e.employeeNestedInfo.id,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            DataCell(
              Text(
                e.employeeNestedInfo.profile.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            DataCell(
              Text(
                e.employeeNestedInfo.profile.email,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            DataCell(
              Text(
                e.employeeNestedInfo.profile.phone ?? '',
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

List<DataRow> _emptyEmployeeRow({
  required BuildContext context,
}) {
  return [
    DataRow(
      cells: <DataCell>[
        DataCell(
          Text(
            'Không có dữ liệu',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        DataCell(
          Text(
            'Không có dữ liệu',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        DataCell(
          Text(
            'Không có dữ liệu',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        DataCell(
          Text(
            'Không có dữ liệu',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ],
    )
  ];
}

List<DataRow> _attendanceRow({
  required BuildContext context,
  required List<SelectableAttendance> attendances,
  required void Function({
    required bool? selected,
    required SelectableAttendance attendance,
  }) onAttendanceSelected,
  required void Function(SelectableAttendance attendance) onLongPress,
}) {
  final dateFormatter = DateFormat('dd/MM/yyyy');

  return attendances
      .map(
        (e) => DataRow(
          selected: e.isSelected,
          onLongPress: () => onLongPress(e),
          onSelectChanged: (selected) => onAttendanceSelected(
            selected: selected,
            attendance: e,
          ),
          cells: <DataCell>[
            DataCell(
              Text(
                e.employeeAttendance.employeeId,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            DataCell(
              Text(
                dateFormatter.format(e.employeeAttendance.date),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            DataCell(
              Text(
                '${e.employeeAttendance.clockIn?.hour}:${e.employeeAttendance.clockIn?.minute}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            DataCell(
              Text(
                '${e.employeeAttendance.clockOut?.hour}:${e.employeeAttendance.clockOut?.minute}',
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

List<DataRow> _emptyAttendanceRow({
  required BuildContext context,
}) {
  return [
    DataRow(
      cells: <DataCell>[
        DataCell(
          Text(
            'Không có dữ liệu',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        DataCell(
          Text(
            'Không có dữ liệu',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        DataCell(
          Text(
            'Không có dữ liệu',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        DataCell(
          Text(
            'Không có dữ liệu',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ],
    )
  ];
}
