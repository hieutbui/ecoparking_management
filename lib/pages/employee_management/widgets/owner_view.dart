import 'package:ecoparking_management/config/app_config.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management_view_styles.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/info_multi_columns.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/table_info.dart';
import 'package:ecoparking_management/widgets/info_card_with_title.dart';
import 'package:flutter/material.dart';

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
                  highlightedChild: Text(
                    controller.totalEmployees.toString(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  secondaryChild: Text(
                    'Total Employees',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                        ),
                  ),
                ),
                ColumnArguments(
                  highlightedChild: Text(
                    controller.onDutyEmployees.toString(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  secondaryChild: Text(
                    'On Time Employees',
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
              title: 'Employee List',
              child: TableInfo(
                titles: controller.listEmployeesTableTitles,
                data: controller.currentEmployeeRow(controller.listEmployees),
                rowPerPage: controller
                            .currentEmployeeRow(controller.listEmployees)
                            .length >
                        controller.rowPerPage.value
                    ? controller.rowPerPage.value
                    : controller
                        .currentEmployeeRow(controller.listEmployees)
                        .length,
                onRowsPerPageChanged: controller.onRowsPerPageChanged,
                header: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: controller.onSearchEmployee,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
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
                      'Add',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
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
                      'Export',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.tertiary,
                      ),
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  //TODO: consier show remove button only when there is selected employee or always show and check if there is selected employee
                  TextButton.icon(
                    onPressed: controller.onRemoveEmployeePressed,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Remove',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                              ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.error,
                      ),
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
