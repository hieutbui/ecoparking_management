import 'package:ecoparking_management/pages/previous_analysis/widgets/bar_chart_info/bar_chart_info_args.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarChartInfo extends StatelessWidget {
  final BarChartInfoArgs args;

  const BarChartInfo({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final barSpace = 20.0 * constraints.maxWidth / 400;
            final barWidth = 8.0 * constraints.maxWidth / 400;

            return BarChart(
              key: ValueKey(args.chartKey),
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: BarTouchData(
                  enabled: true,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) => _bottomTitles(
                        context: context,
                        value: value,
                        meta: meta,
                        infos: args.values,
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 90,
                      getTitlesWidget: (value, meta) => _leftTitles(
                        context: context,
                        value: value,
                        meta: meta,
                        locale: args.locale,
                        leftTitlesFormatType: args.leftTitlesFormatType,
                      ),
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 10 == 0,
                  getDrawingHorizontalLine: (value) => const FlLine(
                    color: Color(0xFFCCCCCC),
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                groupsSpace: barSpace,
                barGroups: _getData(
                  barsWidth: barWidth,
                  infos: args.values,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _bottomTitles({
  required BuildContext context,
  required double value,
  required TitleMeta meta,
  required List<BarValue> infos,
}) {
  final String text =
      infos.firstWhere((info) => info.valueX == value.toInt()).name;

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      text,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Colors.black,
          ),
    ),
  );
}

Widget _leftTitles({
  required BuildContext context,
  required double value,
  required TitleMeta meta,
  required String locale,
  required LeftTitlesFormatType leftTitlesFormatType,
}) {
  final style = Theme.of(context).textTheme.labelMedium!.copyWith(
        color: Colors.black,
      );

  final NumberFormat formatterCurrency =
      NumberFormat.compactSimpleCurrency(locale: locale);
  final NumberFormat formatterNumber = NumberFormat.compact(locale: locale);

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      leftTitlesFormatType == LeftTitlesFormatType.currency
          ? formatterCurrency.format(value)
          : formatterNumber.format(value),
      style: style,
    ),
  );
}

List<BarChartGroupData> _getData({
  required double barsWidth,
  required List<BarValue> infos,
}) {
  const Color color = Color(0xFF11e9a2);

  return infos
      .map(
        (info) => BarChartGroupData(
          x: info.valueX,
          groupVertically: true,
          barRods: [
            BarChartRodData(
              toY: info.valueY,
              color: color,
              borderRadius: BorderRadius.zero,
              width: barsWidth,
            ),
          ],
        ),
      )
      .toList();
}
