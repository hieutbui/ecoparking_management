import 'package:ecoparking_management/config/app_paths.dart';
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
      onCheckInPressed:
          controller.isEmployee ? controller.onCheckInPressed : null,
      onCheckOutPressed:
          controller.isEmployee ? controller.onCheckOutPressed : null,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: LiveOverviewViewStyles.padding,
          child: Column(
            children: <Widget>[
              InfoMultiColumns(
                columns: <ColumnArguments>[
                  ColumnArguments(
                    highlightedChild: RichText(
                      text: TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: controller
                                .dummyLiveOverview.parkingLotsOccupied
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                          TextSpan(
                            text:
                                ' / ${controller.dummyLiveOverview.parkingLotsTotal}',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
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
                    highlightedChild: Text(
                      controller.dummyLiveOverview.currentEmployees.toString(),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
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
                    highlightedChild: Text(
                      controller.dummyLiveOverview.totalCustomers.toString(),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
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
                    highlightedChild: Text(
                      controller.getFormattedCurrency(
                        controller.dummyLiveOverview.totalRevenue,
                        controller.dummyLiveOverview.currencyLocale,
                      ),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
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
                child: TableInfo(
                  titles: controller.currentParkingLotAllotmentTableTitles,
                  data: controller.currentTicketRow(
                    controller.dummyLiveOverview.currentParkingLotAllotment,
                  ),
                  rowPerPage: controller
                              .currentTicketRow(
                                controller.dummyLiveOverview
                                    .currentParkingLotAllotment,
                              )
                              .length >
                          controller.rowPerPageCurrentTicketsNotifier.value
                      ? controller.rowPerPageCurrentTicketsNotifier.value
                      : controller
                          .currentTicketRow(
                            controller
                                .dummyLiveOverview.currentParkingLotAllotment,
                          )
                          .length,
                  onRowsPerPageChanged:
                      controller.onCurrentTicketRowsPerPageChanged,
                ),
              ),
              const SizedBox(height: LiveOverviewViewStyles.spacing),
              InfoCardWithTitle(
                title: 'Current Employees',
                child: TableInfo(
                  titles: controller.currentEmployeesTableTitles,
                  data: controller.currentEmployeeRow(
                    controller.dummyLiveOverview.currentEmployeesInfo,
                  ),
                  rowPerPage: controller
                              .currentEmployeeRow(
                                controller
                                    .dummyLiveOverview.currentEmployeesInfo,
                              )
                              .length >
                          controller.rowPerPageCurrentEmployeesNotifier.value
                      ? controller.rowPerPageCurrentEmployeesNotifier.value
                      : controller
                          .currentEmployeeRow(
                            controller.dummyLiveOverview.currentEmployeesInfo,
                          )
                          .length,
                  onRowsPerPageChanged:
                      controller.onCurrentEmployeesRowsPerPageChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
