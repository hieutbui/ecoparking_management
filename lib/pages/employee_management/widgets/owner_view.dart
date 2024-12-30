import 'package:ecoparking_management/config/app_config.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management_view_styles.dart';
import 'package:ecoparking_management/pages/employee_management/widgets/selectable_employee.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/info_multi_columns.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/table_info.dart';
import 'package:ecoparking_management/widgets/info_card_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    AppLocalizations.of(context)!.totalEmployees,
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
                    AppLocalizations.of(context)!.onTimeEmployees,
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
              title: AppLocalizations.of(context)!.employeeList,
              child: ValueListenableBuilder(
                valueListenable: controller.listEmployees,
                builder: (context, employees, child) {
                  final List<DataRow> dataRows = _employeeRow(
                    context: context,
                    employees: employees,
                    onEmployeeSelected: controller.onEmployeeSelected,
                    onLongPress: controller.onEmployeeLongPressed,
                  );

                  return TableInfo(
                    titles: controller.listEmployeesTableTitles,
                    data: dataRows,
                    emptyData: _emptyEmployeeRow(context: context),
                    rowPerPage: _getRowPerPage(
                      dataRows,
                      controller.rowPerPage.value,
                    ),
                    onRowsPerPageChanged: controller.onRowsPerPageChanged,
                    header: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            onChanged: controller.onSearchEmployee,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.search,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).colorScheme.onSurface,
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
                          AppLocalizations.of(context)!.add,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            Theme.of(context).colorScheme.secondary,
                          ),
                          shape: const WidgetStatePropertyAll<OutlinedBorder>(
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
                          AppLocalizations.of(context)!.export,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            Theme.of(context).colorScheme.tertiary,
                          ),
                          shape: const WidgetStatePropertyAll<OutlinedBorder>(
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
                          AppLocalizations.of(context)!.remove,
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
                          shape: const WidgetStatePropertyAll<OutlinedBorder>(
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
            AppLocalizations.of(context)!.noData,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        DataCell(
          Text(
            AppLocalizations.of(context)!.noData,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        DataCell(
          Text(
            AppLocalizations.of(context)!.noData,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        DataCell(
          Text(
            AppLocalizations.of(context)!.noData,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ],
    )
  ];
}
