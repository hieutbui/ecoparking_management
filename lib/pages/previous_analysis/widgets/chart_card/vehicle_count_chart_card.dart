import 'package:ecoparking_management/pages/previous_analysis/previous_analysis.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis_view_styles.dart';
import 'package:ecoparking_management/pages/previous_analysis/widgets/bar_chart_info/bar_chart_info.dart';
import 'package:ecoparking_management/pages/previous_analysis/widgets/bar_chart_info/bar_chart_info_args.dart';
import 'package:ecoparking_management/widgets/dropdown_previous_view_type/dropdown_previous_view_type.dart';
import 'package:ecoparking_management/widgets/info_card_with_title.dart';
import 'package:flutter/material.dart';

class VehicleCountChartCard extends StatelessWidget {
  final PreviousAnalysisController controller;

  const VehicleCountChartCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.viewTypeVehicleCount,
      builder: (context, type, child) {
        return InfoCardWithTitle(
          title: 'Vehicle Count ${type.title}',
          functionButton: Row(
            children: <Widget>[
              DropdownPreviousViewType(
                initialViewType: controller.viewTypeVehicleCount.value,
                onSelectViewType: controller.onSelectViewTypeVehicleCount,
              ),
              const SizedBox(
                width: PreviousAnalysisViewStyles.cardButtonsSpacing,
              ),
              TextButton.icon(
                onPressed: controller.onExportVehicleCount,
                label: Text(
                  'Export',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
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
          child: ValueListenableBuilder(
            valueListenable: controller.vehicleCountChartValues,
            builder: (context, values, child) {
              return BarChartInfo(
                args: BarChartInfoArgs(
                  values: values,
                  chartKey: type.chartKey,
                  locale: controller.dummyLocale,
                  leftTitlesFormatType: LeftTitlesFormatType.number,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
