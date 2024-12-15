import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'analysis_data.g.dart';

@JsonSerializable()
class AnalysisData with EquatableMixin {
  @JsonKey(name: 'value_x')
  final int valueX;
  final String name;
  @JsonKey(name: 'value_y')
  final double valueY;

  const AnalysisData({
    required this.valueX,
    required this.name,
    required this.valueY,
  });

  factory AnalysisData.fromJson(Map<String, dynamic> json) =>
      _$AnalysisDataFromJson(json);

  Map<String, dynamic> toJson() => _$AnalysisDataToJson(this);

  @override
  List<Object?> get props => [
        valueX,
        name,
        valueY,
      ];
}
