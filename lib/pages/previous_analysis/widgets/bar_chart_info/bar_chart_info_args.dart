import 'package:equatable/equatable.dart';

class BarChartInfoArgs with EquatableMixin {
  final List<BarValue> values;
  final String chartKey;
  final String locale;
  final LeftTitlesFormatType leftTitlesFormatType;

  const BarChartInfoArgs({
    required this.values,
    required this.chartKey,
    required this.locale,
    this.leftTitlesFormatType = LeftTitlesFormatType.currency,
  });

  @override
  List<Object?> get props => [
        values,
      ];
}

class BarValue with EquatableMixin {
  // start from 0
  final int valueX;
  final double valueY;
  final String name;

  const BarValue({
    required this.valueX,
    required this.valueY,
    required this.name,
  });

  @override
  List<Object?> get props => [
        valueX,
        valueY,
        name,
      ];
}

enum LeftTitlesFormatType { currency, number }
