import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/ticket_info.dart';
import 'package:ecoparking_management/domain/state/analysis/get_parking_info_state.dart';
import 'package:ecoparking_management/domain/state/analysis/get_ticket_state.dart';
import 'package:ecoparking_management/domain/state/employee/check_in_state.dart';
import 'package:ecoparking_management/domain/state/employee/check_out_state.dart';
import 'package:ecoparking_management/domain/state/employee/get_employee_attendance_status_state.dart';
import 'package:ecoparking_management/pages/live_overview/live_overview.dart';
import 'package:ecoparking_management/pages/live_overview/live_overview_view_styles.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/info_multi_columns.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/table_info.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:ecoparking_management/widgets/info_card_with_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      checkInButton: _buildCheckInButton(context, controller),
      checkOutButton: _buildCheckOutButton(context, controller),
      actionButton: IconButton(
        icon: const Icon(
          Icons.qr_code_rounded,
          size: LiveOverviewViewStyles.scannerIconSize,
        ),
        onPressed: controller.openScanner,
      ),
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
                      'Chỗ đỗ xe đã sử dụng',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                    ),
                  ),
                  // ColumnArguments(
                  //   highlightedChild: ValueListenableBuilder(
                  //     valueListenable:
                  //         controller.getCurrentEmployeeStateNotifier,
                  //     builder: (context, state, child) {
                  //       if (state is GetCurrentEmployeeSuccess) {
                  //         return ValueListenableBuilder(
                  //           valueListenable: controller.countCurrentEmployee,
                  //           builder: (context, count, child) {
                  //             return Text(
                  //               count.toString(),
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .displaySmall!
                  //                   .copyWith(
                  //                     color:
                  //                         Theme.of(context).colorScheme.primary,
                  //                   ),
                  //             );
                  //           },
                  //         );
                  //       }

                  //       if (state is GetCurrentEmployeeInitial ||
                  //           state is GetCurrentEmployeeLoading) {
                  //         return const Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }

                  //       if (state is GetCurrentEmployeeEmpty) {
                  //         return Text(
                  //           '0',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .displaySmall!
                  //               .copyWith(
                  //                 color: Theme.of(context).colorScheme.primary,
                  //               ),
                  //         );
                  //       }

                  //       return child!;
                  //     },
                  //     child: Text(
                  //       'N/A',
                  //       style:
                  //           Theme.of(context).textTheme.displaySmall!.copyWith(
                  //                 color: Theme.of(context).colorScheme.primary,
                  //               ),
                  //     ),
                  //   ),
                  //   secondaryChild: Text(
                  //     'Nhân viên đang làm việc',
                  //     style:
                  //         Theme.of(context).textTheme.headlineLarge!.copyWith(
                  //               color: Theme.of(context)
                  //                   .colorScheme
                  //                   .surfaceContainerHighest,
                  //             ),
                  //   ),
                  // ),
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
                      'Tổng số khách hàng hôm nay',
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
                      'Doanh thu hôm nay',
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
                title: 'Phân bổ bãi đỗ xe hiện tại',
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

                          return ValueListenableBuilder(
                            valueListenable:
                                controller.rowPerPageCurrentTicketsNotifier,
                            builder: (context, rowsPerPage, child) {
                              return TableInfo(
                                titles: controller
                                    .currentParkingLotAllotmentTableTitles,
                                data: data,
                                rowPerPage: data.length > rowsPerPage
                                    ? rowsPerPage
                                    : data.length,
                                onRowsPerPageChanged: controller
                                    .onCurrentTicketRowsPerPageChanged,
                              );
                            },
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
                        rowPerPage: 1,
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
              // const SizedBox(height: LiveOverviewViewStyles.spacing),
              // InfoCardWithTitle(
              //   title: 'Nhân viên hiện tại',
              //   child: ValueListenableBuilder(
              //     valueListenable: controller.getCurrentEmployeeStateNotifier,
              //     builder: (context, state, child) {
              //       if (state is GetCurrentEmployeeSuccess) {
              //         return ValueListenableBuilder(
              //           valueListenable: controller.currentEmployeesNotifier,
              //           builder: (context, employees, child) {
              //             final currentEmployeeRow =
              //                 controller.currentEmployeeRow(employees);

              //             return ValueListenableBuilder(
              //               valueListenable:
              //                   controller.rowPerPageCurrentEmployeesNotifier,
              //               builder: (context, rowsPerPage, child) {
              //                 return TableInfo(
              //                   titles: controller.currentEmployeesTableTitles,
              //                   data: currentEmployeeRow,
              //                   rowPerPage:
              //                       currentEmployeeRow.length > rowsPerPage
              //                           ? rowsPerPage
              //                           : currentEmployeeRow.length,
              //                   onRowsPerPageChanged: controller
              //                       .onCurrentEmployeesRowsPerPageChanged,
              //                 );
              //               },
              //             );
              //           },
              //         );
              //       }

              //       if (state is GetCurrentEmployeeEmpty) {
              //         final listInfo = <EmployeeNestedInfo>[];

              //         final currentEmployeeRow =
              //             controller.currentEmployeeRow(listInfo);

              //         return TableInfo(
              //           titles: controller.currentEmployeesTableTitles,
              //           data: currentEmployeeRow,
              //           rowPerPage: 1,
              //         );
              //       }

              //       if (state is GetCurrentEmployeeInitial ||
              //           state is GetCurrentEmployeeLoading) {
              //         return const Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       }

              //       return child!;
              //     },
              //     child: Text(
              //       'N/A',
              //       style: Theme.of(context).textTheme.displaySmall!.copyWith(
              //             color: Theme.of(context).colorScheme.primary,
              //           ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: LiveOverviewViewStyles.spacing),
              InfoCardWithTitle(
                title: 'Tất cả vé',
                child: ValueListenableBuilder(
                  valueListenable: controller.getTicketStateNotifier,
                  builder: (context, state, child) {
                    if (state is GetTicketSuccess) {
                      final data = controller.allTicketRow(state.tickets);

                      return ValueListenableBuilder(
                        valueListenable:
                            controller.rowPerPageAllTicketsNotifier,
                        builder: (context, rowsPerPage, child) {
                          return TableInfo(
                            titles: controller
                                .currentParkingLotAllotmentTableTitles,
                            data: data,
                            rowPerPage: data.length > rowsPerPage
                                ? rowsPerPage
                                : data.length,
                            onRowsPerPageChanged:
                                controller.onAllTicketRowsPerPageChanged,
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
                        rowPerPage: 1,
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

Widget? _buildCheckInButton(
  BuildContext context,
  LiveOverviewController controller,
) {
  if (!controller.isEmployee) return null;

  return ValueListenableBuilder(
    valueListenable: controller.getEmployeeAttendanceStatusStateNotifier,
    builder: (context, statusState, child) {
      if (statusState is GetEmployeeAttendanceStatusInitial) {
        return TextButton.icon(
          onPressed: controller.onCheckInPressed,
          label: const CircularProgressIndicator(),
          icon: Icon(
            Icons.input,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        );
      }

      if (statusState is GetEmployeeAttendanceStatusLoading) {
        return TextButton.icon(
          onPressed: controller.onCheckInPressed,
          label: const CircularProgressIndicator(),
          icon: Icon(
            Icons.input,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        );
      }

      if (statusState is GetEmployeeAttendanceStatusSuccess) {
        final date = statusState.employeeAttendance.date;
        final time = statusState.employeeAttendance.clockIn;
        final dateFormatter = DateFormat('dd/MM/yyyy');

        return TextButton.icon(
          onPressed: () {},
          label: Text(
            '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}, ${dateFormatter.format(date)}',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
          icon: Icon(
            Icons.input,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        );
      }

      if (statusState is GetEmployeeAttendanceStatusFailure) {
        return TextButton.icon(
          onPressed: controller.onCheckInPressed,
          label: Text(
            'Check in: Failed',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
          icon: Icon(
            Icons.input,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        );
      }

      if (statusState is GetEmployeeAttendanceStatusEmpty) {
        return ValueListenableBuilder(
          valueListenable: controller.checkInStateNotifier,
          builder: (context, state, child) {
            if (state is CheckInInitial) {
              return TextButton.icon(
                onPressed: () {},
                label: Text(
                  'Check in',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                icon: Icon(
                  Icons.input,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            }

            if (state is CheckInLoading) {
              return TextButton.icon(
                onPressed: () {},
                label: const CircularProgressIndicator(),
                icon: Icon(
                  Icons.input,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            }

            if (state is CheckInSuccess) {
              final date = state.employeeAttendance.date;
              final time = state.employeeAttendance.clockIn;
              final dateFormatter = DateFormat('dd/MM/yyyy');

              return TextButton.icon(
                onPressed: () {},
                label: Text(
                  '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}, ${dateFormatter.format(date)}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                icon: Icon(
                  Icons.input,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            }

            if (state is CheckInFailure) {
              return TextButton.icon(
                onPressed: () {},
                label: Text(
                  'Check in: Failed',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                icon: Icon(
                  Icons.input,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            }

            return child!;
          },
          child: const SizedBox.shrink(),
        );
      }

      return child!;
    },
    child: const SizedBox.shrink(),
  );
}

Widget? _buildCheckOutButton(
  BuildContext context,
  LiveOverviewController controller,
) {
  if (!controller.isEmployee) return null;

  return ValueListenableBuilder(
    valueListenable: controller.getEmployeeAttendanceStatusStateNotifier,
    builder: (context, statusState, child) {
      if (statusState is GetEmployeeAttendanceStatusInitial) {
        return TextButton.icon(
          onPressed: controller.onCheckOutPressed,
          label: const CircularProgressIndicator(),
          icon: Icon(
            Icons.output,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        );
      }

      if (statusState is GetEmployeeAttendanceStatusLoading) {
        return TextButton.icon(
          onPressed: () {},
          label: const CircularProgressIndicator(),
          icon: Icon(
            Icons.output,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        );
      }

      if (statusState is GetEmployeeAttendanceStatusSuccess) {
        final date = statusState.employeeAttendance.date;
        final time = statusState.employeeAttendance.clockOut;
        final dateFormatter = DateFormat('dd/MM/yyyy');

        return TextButton.icon(
          onPressed: () {},
          label: Text(
            '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}, ${dateFormatter.format(date)}',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
          icon: Icon(
            Icons.output,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        );
      }

      if (statusState is GetEmployeeAttendanceStatusFailure) {
        return TextButton.icon(
          onPressed: controller.onCheckOutPressed,
          label: Text(
            'Check out: Failed',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          icon: Icon(
            Icons.output,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        );
      }

      if (statusState is GetEmployeeAttendanceStatusEmpty) {
        return ValueListenableBuilder(
          valueListenable: controller.checkOutStateNotifier,
          builder: (context, state, child) {
            if (state is CheckOutInitial) {
              return TextButton.icon(
                onPressed: controller.onCheckOutPressed,
                label: Text(
                  'Check out',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                icon: Icon(
                  Icons.output,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            }

            if (state is CheckOutLoading) {
              return TextButton.icon(
                onPressed: () {},
                label: const CircularProgressIndicator(),
                icon: Icon(
                  Icons.output,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            }

            if (state is CheckOutSuccess) {
              final date = state.employeeAttendance.date;
              final time = state.employeeAttendance.clockOut;
              final dateFormatter = DateFormat('dd/MM/yyyy');

              return TextButton.icon(
                onPressed: () {},
                label: Text(
                  '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}, ${dateFormatter.format(date)}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                icon: Icon(
                  Icons.output,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            }

            if (state is CheckOutFailure) {
              return TextButton.icon(
                onPressed: controller.onCheckOutPressed,
                label: Text(
                  'Check out: Failed',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                icon: Icon(
                  Icons.output,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            }

            return child!;
          },
          child: const SizedBox.shrink(),
        );
      }

      return child!;
    },
  );
}
