import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/data/models/ticket_info.dart';
import 'package:ecoparking_management/domain/state/analysis/get_current_employee_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_parking_info_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_ticket_state.dart';
import 'package:ecoparking_management/pages/live_overview/live_overview.dart';
import 'package:ecoparking_management/pages/live_overview/live_overview_view_styles.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/info_multi_columns.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/table_info.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:ecoparking_management/widgets/info_card_with_title.dart';
import 'package:flutter/material.dart';

class LiveOverviewView extends StatelessWidget with ViewLoggy {
  final LiveOverviewController controller;

  const LiveOverviewView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.liveOverview.label,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: LiveOverviewViewStyles.padding,
          child: Column(
            children: <Widget>[
              InfoMultiColumns(
                columns: <ColumnArguments>[
                  ColumnArguments(
                    highlightedChild: ValueListenableBuilder(
                      valueListenable: controller.getParkingInfoStateNotifier,
                      builder: (context, state, child) {
                        if (state is GetParkingInfoLoading ||
                            state is GetParkingInfoInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is GetParkingInfoSuccess) {
                          return ValueListenableBuilder(
                            valueListenable: controller.parkingOccupied,
                            builder: (context, occupied, child) {
                              return RichText(
                                text: TextSpan(
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: occupied.occupied.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                          ),
                                    ),
                                    TextSpan(
                                      text: ' / ${occupied.total}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }

                        return child!;
                      },
                      child: RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'N/A',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                            TextSpan(
                              text: ' / N/A',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    secondaryChild: Text(
                      'Parking Lots Occupied',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                    ),
                  ),
                  ColumnArguments(
                    highlightedChild: ValueListenableBuilder(
                      valueListenable:
                          controller.getCurrentEmployeeStateNotifier,
                      builder: (context, state, child) {
                        if (state is GetCurrentEmployeeSuccess) {
                          return ValueListenableBuilder(
                            valueListenable: controller.countCurrentEmployee,
                            builder: (context, count, child) {
                              return Text(
                                count.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              );
                            },
                          );
                        }

                        if (state is GetCurrentEmployeeInitial ||
                            state is GetCurrentEmployeeLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is GetCurrentEmployeeEmpty) {
                          return Text(
                            '0',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          );
                        }

                        return child!;
                      },
                      child: Text(
                        'N/A',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ),
                    secondaryChild: Text(
                      'Current Employees',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                    ),
                  ),
                  ColumnArguments(
                    highlightedChild: ValueListenableBuilder(
                      valueListenable: controller.getTicketStateNotifier,
                      builder: (context, state, child) {
                        if (state is GetTicketSuccess) {
                          return ValueListenableBuilder(
                            valueListenable: controller.totalCustomersNotifier,
                            builder: (context, total, child) {
                              return Text(
                                total.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              );
                            },
                          );
                        }

                        if (state is GetTicketLoading ||
                            state is GetTicketInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is GetTicketEmpty) {
                          return Text(
                            '0',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          );
                        }

                        return child!;
                      },
                      child: Text(
                        'N/A',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ),
                    secondaryChild: Text(
                      'Total Customers today',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LiveOverviewViewStyles.spacing),
              InfoMultiColumns(
                columns: <ColumnArguments>[
                  ColumnArguments(
                    highlightedChild: ValueListenableBuilder(
                      valueListenable: controller.getTicketStateNotifier,
                      builder: (context, state, child) {
                        if (state is GetTicketSuccess) {
                          return ValueListenableBuilder(
                            valueListenable: controller.totalRevenueNotifier,
                            builder: (context, total, child) {
                              return Text(
                                controller.getFormattedCurrency(total),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              );
                            },
                          );
                        }

                        if (state is GetTicketLoading ||
                            state is GetTicketInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is GetTicketEmpty) {
                          return Text(
                            '0',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          );
                        }

                        return child!;
                      },
                    ),
                    secondaryChild: Text(
                      'Today\'s Revenue',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LiveOverviewViewStyles.spacing),
              InfoCardWithTitle(
                title: 'Current Parking lot allotment',
                child: ValueListenableBuilder(
                  valueListenable: controller.getTicketStateNotifier,
                  builder: (context, state, child) {
                    if (state is GetTicketSuccess) {
                      return ValueListenableBuilder(
                        valueListenable:
                            controller.currentParkingLotAllotmentNotifier,
                        builder: (context, currentParkingLotAllotment, child) {
                          final data = controller
                              .currentTicketRow(currentParkingLotAllotment);

                          return TableInfo(
                            titles: controller
                                .currentParkingLotAllotmentTableTitles,
                            data: data,
                            rowPerPage: data.length >
                                    controller
                                        .rowPerPageCurrentTicketsNotifier.value
                                ? controller
                                    .rowPerPageCurrentTicketsNotifier.value
                                : data.length,
                            onRowsPerPageChanged:
                                controller.onCurrentTicketRowsPerPageChanged,
                          );
                        },
                      );
                    }

                    if (state is GetTicketLoading ||
                        state is GetTicketInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is GetTicketEmpty) {
                      final listInfo = <TicketInfo>[];

                      final data = controller.currentTicketRow(listInfo);

                      return TableInfo(
                        titles:
                            controller.currentParkingLotAllotmentTableTitles,
                        data: data,
                        rowPerPage: data.length >
                                controller
                                    .rowPerPageCurrentTicketsNotifier.value
                            ? controller.rowPerPageCurrentTicketsNotifier.value
                            : data.length,
                        onRowsPerPageChanged:
                            controller.onCurrentTicketRowsPerPageChanged,
                      );
                    }

                    return child!;
                  },
                  child: Text(
                    'N/A',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: LiveOverviewViewStyles.spacing),
              InfoCardWithTitle(
                title: 'Current Employees',
                child: ValueListenableBuilder(
                  valueListenable: controller.getCurrentEmployeeStateNotifier,
                  builder: (context, state, child) {
                    if (state is GetCurrentEmployeeSuccess) {
                      return ValueListenableBuilder(
                        valueListenable: controller.currentEmployeesNotifier,
                        builder: (context, employees, child) {
                          final currentEmployeeRow =
                              controller.currentEmployeeRow(employees);

                          return TableInfo(
                            titles: controller.currentEmployeesTableTitles,
                            data: currentEmployeeRow,
                            rowPerPage: currentEmployeeRow.length >
                                    controller
                                        .rowPerPageCurrentEmployeesNotifier
                                        .value
                                ? controller
                                    .rowPerPageCurrentEmployeesNotifier.value
                                : currentEmployeeRow.length,
                            onRowsPerPageChanged:
                                controller.onCurrentEmployeesRowsPerPageChanged,
                          );
                        },
                      );
                    }

                    if (state is GetCurrentEmployeeEmpty) {
                      final listInfo = <EmployeeNestedInfo>[];

                      final currentEmployeeRow =
                          controller.currentEmployeeRow(listInfo);

                      return TableInfo(
                        titles: controller.currentEmployeesTableTitles,
                        data: currentEmployeeRow,
                        rowPerPage: currentEmployeeRow.length >
                                controller
                                    .rowPerPageCurrentEmployeesNotifier.value
                            ? controller
                                .rowPerPageCurrentEmployeesNotifier.value
                            : currentEmployeeRow.length,
                        onRowsPerPageChanged:
                            controller.onCurrentEmployeesRowsPerPageChanged,
                      );
                    }

                    if (state is GetCurrentEmployeeInitial ||
                        state is GetCurrentEmployeeLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return child!;
                  },
                  child: Text(
                    'N/A',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: LiveOverviewViewStyles.spacing),
              InfoCardWithTitle(
                title: 'All Tickets',
                child: ValueListenableBuilder(
                  valueListenable: controller.getTicketStateNotifier,
                  builder: (context, state, child) {
                    if (state is GetTicketSuccess) {
                      final data = controller.allTicketRow(state.tickets);

                      return TableInfo(
                        titles:
                            controller.currentParkingLotAllotmentTableTitles,
                        data: data,
                        rowPerPage: data.length >
                                controller
                                    .rowPerPageCurrentTicketsNotifier.value
                            ? controller.rowPerPageCurrentTicketsNotifier.value
                            : data.length,
                        onRowsPerPageChanged:
                            controller.onCurrentTicketRowsPerPageChanged,
                      );
                    }

                    if (state is GetTicketLoading ||
                        state is GetTicketInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is GetTicketEmpty) {
                      final listInfo = <TicketInfo>[];

                      final data = controller.currentTicketRow(listInfo);

                      return TableInfo(
                        titles:
                            controller.currentParkingLotAllotmentTableTitles,
                        data: data,
                        rowPerPage: data.length >
                                controller
                                    .rowPerPageCurrentTicketsNotifier.value
                            ? controller.rowPerPageCurrentTicketsNotifier.value
                            : data.length,
                        onRowsPerPageChanged:
                            controller.onCurrentTicketRowsPerPageChanged,
                      );
                    }

                    return child!;
                  },
                  child: Text(
                    'N/A',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
