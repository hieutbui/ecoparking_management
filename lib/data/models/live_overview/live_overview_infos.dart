import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'live_overview_infos.g.dart';

@JsonSerializable()
class LiveOverviewInfos with EquatableMixin {
  @JsonKey(name: 'currency_locale')
  final String currencyLocale;

  const LiveOverviewInfos({
    required this.currencyLocale,
  });

  factory LiveOverviewInfos.fromJson(Map<String, dynamic> json) =>
      _$LiveOverviewInfosFromJson(json);

  Map<String, dynamic> toJson() => _$LiveOverviewInfosToJson(this);

  @override
  List<Object?> get props => [
        currencyLocale,
      ];
}
