import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/info_multi_columns.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis_view_styles.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis_view_type.dart';
import 'package:ecoparking_management/pages/previous_analysis/widgets/bar_chart_info/bar_chart_info.dart';
import 'package:ecoparking_management/pages/previous_analysis/widgets/bar_chart_info/bar_chart_info_args.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:ecoparking_management/widgets/dropdown_previous_view_type/dropdown_previous_view_type.dart';
import 'package:ecoparking_management/widgets/info_card_with_title.dart';
import 'package:flutter/material.dart';

class PreviousAnalysisView extends StatelessWidget with ViewLoggy {
  final PreviousAnalysisController controller;

  const PreviousAnalysisView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.previousAnalysis.label,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: PreviousAnalysisViewStyles.padding,
          child: Column(
            children: <Widget>[
              InfoMultiColumns(
                columns: <ColumnArguments>[
                  ColumnArguments(
                    highlightedChild: ValueListenableBuilder(
                      valueListenable: controller.viewTypeTotalRevenue,
                      builder: (context, viewType, chile) {
                        num totalRevenue;

                        switch (viewType) {
                          case PreviousAnalysisViewType.last12months:
                            totalRevenue = controller.totalRevenueLast12Month;
                            break;
                          case PreviousAnalysisViewType.lastMonth:
                            totalRevenue = controller.totalRevenueLastMonth;
                            break;
                          case PreviousAnalysisViewType.lastYear:
                            totalRevenue = controller.totalRevenueLastYear;
                            break;
                          case PreviousAnalysisViewType.yesterday:
                            totalRevenue = controller.totalRevenueYesterday;
                            break;
                        }

                        return Text(
                          controller.getFormattedCurrency(
                            totalRevenue,
                            controller.dummyLocale,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        );
                      },
                    ),
                    secondaryChild: Row(
                      children: <Widget>[
                        Text(
                          'Total Revenue ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                        ),
                        DropdownPreviousViewType(
                          initialViewType:
                              controller.viewTypeTotalRevenue.value,
                          onSelectViewType:
                              controller.onSelectViewTypeTotalRevenue,
                        ),
                      ],
                    ),
                  ),
                  ColumnArguments(
                    highlightedChild: ValueListenableBuilder(
                      valueListenable: controller.viewTypeTotalVehicleCount,
                      builder: (context, viewType, chile) {
                        num totalVehicleCount;

                        switch (viewType) {
                          case PreviousAnalysisViewType.last12months:
                            totalVehicleCount =
                                controller.totalVehicleCountLast12Month;
                            break;
                          case PreviousAnalysisViewType.lastMonth:
                            totalVehicleCount =
                                controller.totalVehicleCountLastMonth;
                            break;
                          case PreviousAnalysisViewType.lastYear:
                            totalVehicleCount =
                                controller.totalVehicleCountLastYear;
                            break;
                          case PreviousAnalysisViewType.yesterday:
                            totalVehicleCount =
                                controller.totalVehicleCountYesterday;
                            break;
                        }

                        return Text(
                          controller.getFormattedNumber(
                            totalVehicleCount,
                            controller.dummyLocale,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        );
                      },
                    ),
                    secondaryChild: Row(
                      children: <Widget>[
                        Text(
                          'Total Vehicle ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                        ),
                        DropdownPreviousViewType(
                          initialViewType:
                              controller.viewTypeTotalVehicleCount.value,
                          onSelectViewType:
                              controller.onSelectViewTypeTotalVehicleCount,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: PreviousAnalysisViewStyles.spacing,
              ),
              ValueListenableBuilder(
                valueListenable: controller.viewTypeRevenue,
                builder: (context, type, child) {
                  List<BarValue> values;

                  switch (type) {
                    case PreviousAnalysisViewType.last12months:
                      values = controller.dummyLast12MonthValues;
                      break;
                    case PreviousAnalysisViewType.lastMonth:
                      values = controller.dummyLastMonthValues;
                      break;
                    case PreviousAnalysisViewType.lastYear:
                      values = controller.dummyLastYearValues;
                      break;
                    case PreviousAnalysisViewType.yesterday:
                      values = controller.dummyYesterdayValues;
                      break;
                  }

                  return InfoCardWithTitle(
                    title: 'Revenues ${type.title}',
                    functionButton: Row(
                      children: <Widget>[
                        DropdownPreviousViewType(
                          initialViewType: controller.viewTypeRevenue.value,
                          onSelectViewType: controller.onSelectViewTypeRevenue,
                        ),
                        const SizedBox(
                          width: PreviousAnalysisViewStyles.cardButtonsSpacing,
                        ),
                        TextButton.icon(
                          onPressed: controller.onExportRevenue,
                          label: Text(
                            'Export',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                          ),
                          icon: Icon(
                            Icons.download_rounded,
                            color: Theme.of(context).colorScheme.onSecondary,
                            size: 20.0,
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
                      ],
                    ),
                    child: BarChartInfo(
                      args: BarChartInfoArgs(
                        chartKey: type.chartKey,
                        values: values,
                        locale: controller.dummyLocale,
                        leftTitlesFormatType: LeftTitlesFormatType.currency,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: PreviousAnalysisViewStyles.spacing,
              ),
              ValueListenableBuilder(
                valueListenable: controller.viewTypeVehicleCount,
                builder: (context, type, child) {
                  List<BarValue> values;

                  switch (type) {
                    case PreviousAnalysisViewType.last12months:
                      values = controller.dummyVehicleCount12MonthValues;
                      break;
                    case PreviousAnalysisViewType.lastMonth:
                      values = controller.dummyVehicleCountLastMonthValues;
                      break;
                    case PreviousAnalysisViewType.lastYear:
                      values = controller.dummyVehicleCountLastYearValues;
                      break;
                    case PreviousAnalysisViewType.yesterday:
                      values = controller.dummyVehicleCountYesterdayValues;
                      break;
                  }

                  return InfoCardWithTitle(
                    title: 'Vehicle Count ${type.title}',
                    functionButton: Row(
                      children: <Widget>[
                        DropdownPreviousViewType(
                          initialViewType:
                              controller.viewTypeVehicleCount.value,
                          onSelectViewType:
                              controller.onSelectViewTypeVehicleCount,
                        ),
                        const SizedBox(
                          width: PreviousAnalysisViewStyles.cardButtonsSpacing,
                        ),
                        TextButton.icon(
                          onPressed: controller.onExportVehicleCount,
                          label: Text(
                            'Export',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                          ),
                          icon: Icon(
                            Icons.download_rounded,
                            color: Theme.of(context).colorScheme.onSecondary,
                            size: 20.0,
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
                      ],
                    ),
                    child: BarChartInfo(
                      args: BarChartInfoArgs(
                        chartKey: type.chartKey,
                        values: values,
                        locale: controller.dummyLocale,
                        leftTitlesFormatType: LeftTitlesFormatType.number,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: PreviousAnalysisViewStyles.spacing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
