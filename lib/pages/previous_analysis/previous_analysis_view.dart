import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/info_multi_columns.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis_view_styles.dart';
import 'package:ecoparking_management/pages/previous_analysis/widgets/chart_card/revenue_chart_card.dart';
import 'package:ecoparking_management/pages/previous_analysis/widgets/chart_card/vehicle_count_chart_card.dart';
import 'package:ecoparking_management/pages/previous_analysis/widgets/highlighted_child/revenue_highlighted_child.dart';
import 'package:ecoparking_management/pages/previous_analysis/widgets/highlighted_child/vehicle_highlighted_child.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/utils/platform_infos.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:ecoparking_management/widgets/dropdown_previous_view_type/dropdown_previous_view_type.dart';
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
      actionButton: IconButton(
        icon: const Icon(
          Icons.qr_code_rounded,
          size: PreviousAnalysisViewStyles.scannerIconSize,
        ),
        onPressed: controller.openScanner,
      ),
      body: PlatformInfos.isMobile
          ? Center(
              child: Text(
                'Trang này không hỗ trợ trên thiết bị di động!',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
              ),
            )
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: PreviousAnalysisViewStyles.padding,
                child: Column(
                  children: <Widget>[
                    InfoMultiColumns(
                      columns: <ColumnArguments>[
                        ColumnArguments(
                          highlightedChild:
                              RevenueHighlightedChild(controller: controller),
                          secondaryChild: Row(
                            children: <Widget>[
                              Text(
                                'Tổng doanh thu ',
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
                          highlightedChild:
                              VehicleHighlightedChild(controller: controller),
                          secondaryChild: Row(
                            children: <Widget>[
                              Text(
                                'Tổng số xe ',
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
                                onSelectViewType: controller
                                    .onSelectViewTypeTotalVehicleCount,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: PreviousAnalysisViewStyles.spacing,
                    ),
                    RevenueChartCard(controller: controller),
                    const SizedBox(
                      height: PreviousAnalysisViewStyles.spacing,
                    ),
                    VehicleCountChartCard(controller: controller),
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
