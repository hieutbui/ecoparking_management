import 'package:ecoparking_management/pages/previous_analysis/previous_analysis_view.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis_view_type.dart';
import 'package:ecoparking_management/pages/previous_analysis/widgets/bar_chart_info/bar_chart_info_args.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PreviousAnalysis extends StatefulWidget {
  const PreviousAnalysis({super.key});

  @override
  PreviousAnalysisController createState() => PreviousAnalysisController();
}

class PreviousAnalysisController extends State<PreviousAnalysis>
    with ControllerLoggy {
  //TODO: Implement fetch data from API
  final String dummyLocale = 'vi_VN';
  final List<BarValue> dummyLast12MonthValues = <BarValue>[
    const BarValue(
      valueX: 0,
      name: 'Jan',
      valueY: 2000000000,
    ),
    const BarValue(
      valueX: 1,
      name: 'Feb',
      valueY: 11000000000,
    ),
    const BarValue(
      valueX: 2,
      name: 'Mar',
      valueY: 6000000000,
    ),
    const BarValue(
      valueX: 3,
      name: 'Apr',
      valueY: 1000000000,
    ),
    const BarValue(
      valueX: 4,
      name: 'May',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 5,
      name: 'Jun',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 6,
      name: 'Jul',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 7,
      name: 'Aug',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 8,
      name: 'Sep',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 9,
      name: 'Oct',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 10,
      name: 'Nov',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 11,
      name: 'Dec',
      valueY: 5000000000,
    ),
  ];

  final List<BarValue> dummyLastYearValues = <BarValue>[
    const BarValue(
      valueX: 0,
      name: 'Jan',
      valueY: 2000000000,
    ),
    const BarValue(
      valueX: 1,
      name: 'Feb',
      valueY: 11000000000,
    ),
    const BarValue(
      valueX: 2,
      name: 'Mar',
      valueY: 6000000000,
    ),
    const BarValue(
      valueX: 3,
      name: 'Apr',
      valueY: 1000000000,
    ),
    const BarValue(
      valueX: 4,
      name: 'May',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 5,
      name: 'Jun',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 6,
      name: 'Jul',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 7,
      name: 'Aug',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 8,
      name: 'Sep',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 9,
      name: 'Oct',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 10,
      name: 'Nov',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 11,
      name: 'Dec',
      valueY: 5000000000,
    ),
  ];

  final List<BarValue> dummyLastMonthValues = <BarValue>[
    const BarValue(
      valueX: 0,
      name: '1',
      valueY: 2000000000,
    ),
    const BarValue(
      valueX: 1,
      name: '2',
      valueY: 11000000000,
    ),
    const BarValue(
      valueX: 2,
      name: '3',
      valueY: 6000000000,
    ),
    const BarValue(
      valueX: 3,
      name: '4',
      valueY: 1000000000,
    ),
    const BarValue(
      valueX: 4,
      name: '5',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 5,
      name: '6',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 6,
      name: '7',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 7,
      name: '8',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 8,
      name: '9',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 9,
      name: '10',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 10,
      name: '11',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 11,
      name: '12',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 12,
      name: '13',
      valueY: 2000000000,
    ),
    const BarValue(
      valueX: 13,
      name: '14',
      valueY: 11000000000,
    ),
    const BarValue(
      valueX: 14,
      name: '15',
      valueY: 6000000000,
    ),
    const BarValue(
      valueX: 15,
      name: '16',
      valueY: 1000000000,
    ),
    const BarValue(
      valueX: 16,
      name: '17',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 17,
      name: '18',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 18,
      name: '19',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 19,
      name: '20',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 20,
      name: '21',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 21,
      name: '22',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 22,
      name: '23',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 23,
      name: '24',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 24,
      name: '25',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 25,
      name: '26',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 26,
      name: '27',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 27,
      name: '28',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 28,
      name: '29',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 29,
      name: '30',
      valueY: 5000000000,
    ),
  ];
  final List<BarValue> dummyYesterdayValues = <BarValue>[
    const BarValue(
      valueX: 0,
      name: '1',
      valueY: 2000000000,
    ),
    const BarValue(
      valueX: 1,
      name: '2',
      valueY: 11000000000,
    ),
    const BarValue(
      valueX: 2,
      name: '3',
      valueY: 6000000000,
    ),
    const BarValue(
      valueX: 3,
      name: '4',
      valueY: 1000000000,
    ),
    const BarValue(
      valueX: 4,
      name: '5',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 5,
      name: '6',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 6,
      name: '7',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 7,
      name: '8',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 8,
      name: '9',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 9,
      name: '10',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 10,
      name: '11',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 11,
      name: '12',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 12,
      name: '13',
      valueY: 2000000000,
    ),
    const BarValue(
      valueX: 13,
      name: '14',
      valueY: 11000000000,
    ),
    const BarValue(
      valueX: 14,
      name: '15',
      valueY: 6000000000,
    ),
    const BarValue(
      valueX: 15,
      name: '16',
      valueY: 1000000000,
    ),
    const BarValue(
      valueX: 16,
      name: '17',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 17,
      name: '18',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 18,
      name: '19',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 19,
      name: '20',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 20,
      name: '21',
      valueY: 5000000000,
    ),
    const BarValue(
      valueX: 21,
      name: '22',
      valueY: 7000000000,
    ),
    const BarValue(
      valueX: 22,
      name: '23',
      valueY: 3000000000,
    ),
    const BarValue(
      valueX: 23,
      name: '24',
      valueY: 5000000000,
    ),
  ];

  final List<BarValue> dummyVehicleCount12MonthValues = <BarValue>[
    const BarValue(
      valueX: 0,
      name: 'Jan',
      valueY: 200,
    ),
    const BarValue(
      valueX: 1,
      name: 'Feb',
      valueY: 1100,
    ),
    const BarValue(
      valueX: 2,
      name: 'Mar',
      valueY: 600,
    ),
    const BarValue(
      valueX: 3,
      name: 'Apr',
      valueY: 100,
    ),
    const BarValue(
      valueX: 4,
      name: 'May',
      valueY: 300,
    ),
    const BarValue(
      valueX: 5,
      name: 'Jun',
      valueY: 500,
    ),
    const BarValue(
      valueX: 6,
      name: 'Jul',
      valueY: 700,
    ),
    const BarValue(
      valueX: 7,
      name: 'Aug',
      valueY: 300,
    ),
    const BarValue(
      valueX: 8,
      name: 'Sep',
      valueY: 500,
    ),
    const BarValue(
      valueX: 9,
      name: 'Oct',
      valueY: 700,
    ),
    const BarValue(
      valueX: 10,
      name: 'Nov',
      valueY: 300,
    ),
    const BarValue(
      valueX: 11,
      name: 'Dec',
      valueY: 500,
    ),
  ];
  final List<BarValue> dummyVehicleCountLastYearValues = <BarValue>[
    const BarValue(
      valueX: 0,
      name: 'Jan',
      valueY: 200,
    ),
    const BarValue(
      valueX: 1,
      name: 'Feb',
      valueY: 1100,
    ),
    const BarValue(
      valueX: 2,
      name: 'Mar',
      valueY: 600,
    ),
    const BarValue(
      valueX: 3,
      name: 'Apr',
      valueY: 100,
    ),
    const BarValue(
      valueX: 4,
      name: 'May',
      valueY: 300,
    ),
    const BarValue(
      valueX: 5,
      name: 'Jun',
      valueY: 500,
    ),
    const BarValue(
      valueX: 6,
      name: 'Jul',
      valueY: 700,
    ),
    const BarValue(
      valueX: 7,
      name: 'Aug',
      valueY: 300,
    ),
    const BarValue(
      valueX: 8,
      name: 'Sep',
      valueY: 500,
    ),
    const BarValue(
      valueX: 9,
      name: 'Oct',
      valueY: 700,
    ),
    const BarValue(
      valueX: 10,
      name: 'Nov',
      valueY: 300,
    ),
    const BarValue(
      valueX: 11,
      name: 'Dec',
      valueY: 500,
    ),
  ];
  final List<BarValue> dummyVehicleCountLastMonthValues = <BarValue>[
    const BarValue(
      valueX: 0,
      name: '1',
      valueY: 200,
    ),
    const BarValue(
      valueX: 1,
      name: '2',
      valueY: 1100,
    ),
    const BarValue(
      valueX: 2,
      name: '3',
      valueY: 600,
    ),
    const BarValue(
      valueX: 3,
      name: '4',
      valueY: 100,
    ),
    const BarValue(
      valueX: 4,
      name: '5',
      valueY: 300,
    ),
    const BarValue(
      valueX: 5,
      name: '6',
      valueY: 500,
    ),
    const BarValue(
      valueX: 6,
      name: '7',
      valueY: 700,
    ),
    const BarValue(
      valueX: 7,
      name: '8',
      valueY: 300,
    ),
    const BarValue(
      valueX: 8,
      name: '9',
      valueY: 500,
    ),
    const BarValue(
      valueX: 9,
      name: '10',
      valueY: 700,
    ),
    const BarValue(
      valueX: 10,
      name: '11',
      valueY: 300,
    ),
    const BarValue(
      valueX: 11,
      name: '12',
      valueY: 500,
    ),
    const BarValue(
      valueX: 12,
      name: '13',
      valueY: 200,
    ),
    const BarValue(
      valueX: 13,
      name: '14',
      valueY: 1100,
    ),
    const BarValue(
      valueX: 14,
      name: '15',
      valueY: 600,
    ),
    const BarValue(
      valueX: 15,
      name: '16',
      valueY: 100,
    ),
    const BarValue(
      valueX: 16,
      name: '17',
      valueY: 300,
    ),
    const BarValue(
      valueX: 17,
      name: '18',
      valueY: 500,
    ),
    const BarValue(
      valueX: 18,
      name: '19',
      valueY: 700,
    ),
    const BarValue(
      valueX: 19,
      name: '20',
      valueY: 300,
    ),
    const BarValue(
      valueX: 20,
      name: '21',
      valueY: 500,
    ),
    const BarValue(
      valueX: 21,
      name: '22',
      valueY: 700,
    ),
    const BarValue(
      valueX: 22,
      name: '23',
      valueY: 300,
    ),
    const BarValue(
      valueX: 23,
      name: '24',
      valueY: 500,
    ),
    const BarValue(
      valueX: 24,
      name: '25',
      valueY: 700,
    ),
    const BarValue(
      valueX: 25,
      name: '26',
      valueY: 300,
    ),
    const BarValue(
      valueX: 26,
      name: '27',
      valueY: 500,
    ),
    const BarValue(
      valueX: 27,
      name: '28',
      valueY: 700,
    ),
    const BarValue(
      valueX: 28,
      name: '29',
      valueY: 300,
    ),
    const BarValue(
      valueX: 29,
      name: '30',
      valueY: 500,
    ),
  ];
  final List<BarValue> dummyVehicleCountYesterdayValues = <BarValue>[
    const BarValue(
      valueX: 0,
      name: '1',
      valueY: 200,
    ),
    const BarValue(
      valueX: 1,
      name: '2',
      valueY: 1100,
    ),
    const BarValue(
      valueX: 2,
      name: '3',
      valueY: 600,
    ),
    const BarValue(
      valueX: 3,
      name: '4',
      valueY: 100,
    ),
    const BarValue(
      valueX: 4,
      name: '5',
      valueY: 300,
    ),
    const BarValue(
      valueX: 5,
      name: '6',
      valueY: 500,
    ),
    const BarValue(
      valueX: 6,
      name: '7',
      valueY: 700,
    ),
    const BarValue(
      valueX: 7,
      name: '8',
      valueY: 300,
    ),
    const BarValue(
      valueX: 8,
      name: '9',
      valueY: 500,
    ),
    const BarValue(
      valueX: 9,
      name: '10',
      valueY: 700,
    ),
    const BarValue(
      valueX: 10,
      name: '11',
      valueY: 300,
    ),
    const BarValue(
      valueX: 11,
      name: '12',
      valueY: 500,
    ),
    const BarValue(
      valueX: 12,
      name: '13',
      valueY: 200,
    ),
    const BarValue(
      valueX: 13,
      name: '14',
      valueY: 1100,
    ),
    const BarValue(
      valueX: 14,
      name: '15',
      valueY: 600,
    ),
    const BarValue(
      valueX: 15,
      name: '16',
      valueY: 100,
    ),
    const BarValue(
      valueX: 16,
      name: '17',
      valueY: 300,
    ),
    const BarValue(
      valueX: 17,
      name: '18',
      valueY: 500,
    ),
    const BarValue(
      valueX: 18,
      name: '19',
      valueY: 700,
    ),
    const BarValue(
      valueX: 19,
      name: '20',
      valueY: 300,
    ),
    const BarValue(
      valueX: 20,
      name: '21',
      valueY: 500,
    ),
    const BarValue(
      valueX: 21,
      name: '22',
      valueY: 700,
    ),
    const BarValue(
      valueX: 22,
      name: '23',
      valueY: 300,
    ),
    const BarValue(
      valueX: 23,
      name: '24',
      valueY: 500,
    ),
  ];

  final num totalRevenueLast12Month = 50000000000;
  final num totalRevenueLastYear = 60000000000;
  final num totalRevenueLastMonth = 7000000000;
  final num totalRevenueYesterday = 8000000000;
  final int totalVehicleCountLast12Month = 5000;
  final int totalVehicleCountLastYear = 6000;
  final int totalVehicleCountLastMonth = 700;
  final int totalVehicleCountYesterday = 800;

  final ValueNotifier<PreviousAnalysisViewType> viewTypeRevenue =
      ValueNotifier<PreviousAnalysisViewType>(
    PreviousAnalysisViewType.last12months,
  );

  final ValueNotifier<PreviousAnalysisViewType> viewTypeVehicleCount =
      ValueNotifier<PreviousAnalysisViewType>(
    PreviousAnalysisViewType.last12months,
  );

  final ValueNotifier<PreviousAnalysisViewType> viewTypeTotalRevenue =
      ValueNotifier<PreviousAnalysisViewType>(
    PreviousAnalysisViewType.last12months,
  );

  final ValueNotifier<PreviousAnalysisViewType> viewTypeTotalVehicleCount =
      ValueNotifier<PreviousAnalysisViewType>(
    PreviousAnalysisViewType.last12months,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _disposeNotifiers();
    super.dispose();
  }

  void _disposeNotifiers() {
    viewTypeRevenue.dispose();
    viewTypeVehicleCount.dispose();
    viewTypeTotalRevenue.dispose();
    viewTypeTotalVehicleCount.dispose();
  }

  String getFormattedCurrency(num value, String locale) {
    final format = NumberFormat.simpleCurrency(locale: locale);

    return format.format(value);
  }

  String getFormattedNumber(num value, String locale) {
    final format = NumberFormat.compact(locale: locale);

    return format.format(value);
  }

  void onSelectViewTypeRevenue(PreviousAnalysisViewType selectedViewType) {
    viewTypeRevenue.value = selectedViewType;
    //TODO: Implement fetch data from API
  }

  void onSelectViewTypeVehicleCount(PreviousAnalysisViewType selectedViewType) {
    viewTypeVehicleCount.value = selectedViewType;
    //TODO: Implement fetch data from API
  }

  void onSelectViewTypeTotalRevenue(PreviousAnalysisViewType selectedViewType) {
    viewTypeTotalRevenue.value = selectedViewType;
    //TODO: Implement fetch data from API
  }

  void onSelectViewTypeTotalVehicleCount(
      PreviousAnalysisViewType selectedViewType) {
    viewTypeTotalVehicleCount.value = selectedViewType;
    //TODO: Implement fetch data from API
  }

  void onExportRevenue() {
    loggy.info('Export revenue');
    //TODO: Implement export revenue
  }

  void onExportVehicleCount() {
    loggy.info('Export vehicle count');
    //TODO: Implement export vehicle count
  }

  @override
  Widget build(BuildContext context) => PreviousAnalysisView(controller: this);
}
