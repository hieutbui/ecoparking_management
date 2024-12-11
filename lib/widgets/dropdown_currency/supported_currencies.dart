import 'package:equatable/equatable.dart';

class SupportedCurrency with EquatableMixin {
  final String currencyCode;
  final String currencyName;
  final String locale;
  final String namePlural;

  const SupportedCurrency({
    required this.currencyCode,
    required this.currencyName,
    required this.locale,
    required this.namePlural,
  });

  @override
  List<Object?> get props => [
        currencyCode,
        currencyName,
        locale,
        namePlural,
      ];
}

const List<SupportedCurrency> supportedCurrencies = [
  SupportedCurrency(
    currencyCode: 'VND',
    currencyName: 'Vietnamese Dong',
    locale: 'vi_VN',
    namePlural: 'Vietnamese',
  ),
  SupportedCurrency(
    currencyCode: 'USD',
    currencyName: 'US Dollar',
    locale: 'en_US',
    namePlural: 'US dollars',
  ),
  SupportedCurrency(
    currencyCode: 'EUR',
    currencyName: 'Euro',
    locale: 'de_DE',
    namePlural: 'euros',
  ),
];
