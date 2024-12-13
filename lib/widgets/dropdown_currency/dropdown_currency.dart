import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecoparking_management/widgets/dropdown_currency/dropdown_currency_styles.dart';
import 'package:ecoparking_management/widgets/dropdown_currency/supported_currencies.dart';
import 'package:flutter/material.dart';

class DropdownCurrency extends StatefulWidget {
  final SupportedCurrency? initialCurrency;
  final ValueChanged<SupportedCurrency>? onSelectCurrency;

  const DropdownCurrency({
    super.key,
    this.initialCurrency,
    this.onSelectCurrency,
  });

  @override
  State<DropdownCurrency> createState() => _DropdownCurrencyState();
}

class _DropdownCurrencyState extends State<DropdownCurrency> {
  late FocusNode _focusNode;
  bool _isFocus = false;
  SupportedCurrency? _selectedCurrency;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });

    if (widget.initialCurrency != null) {
      _selectedCurrency = widget.initialCurrency;
    }
  }

  @override
  void didUpdateWidget(covariant DropdownCurrency oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialCurrency != oldWidget.initialCurrency) {
      setState(() {
        _selectedCurrency = widget.initialCurrency;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        focusNode: _focusNode,
        value: _selectedCurrency,
        isExpanded: true,
        hint: Text(
          'Currency',
          style: DropdownCurrencyStyles.hintStyle(context),
        ),
        items: supportedCurrencies
            .map(
              (SupportedCurrency currency) => DropdownMenuItem(
                value: currency,
                child: Text(
                  currency.currencyCode,
                  style: DropdownCurrencyStyles.itemsTextStyle(context),
                ),
              ),
            )
            .toList(),
        onChanged: _onSelectCurrency,
        buttonStyleData: DropdownCurrencyStyles.buttonStyleData,
        iconStyleData: DropdownCurrencyStyles.iconStyleData(
          context,
          _isFocus,
          _selectedCurrency,
        ),
        dropdownStyleData: DropdownCurrencyStyles.dropdownStyleData(context),
      ),
    );
  }

  void _onSelectCurrency(SupportedCurrency? currency) {
    if (currency != null) {
      setState(() {
        _selectedCurrency = currency;
      });

      if (widget.onSelectCurrency != null) {
        widget.onSelectCurrency!(currency);
      }
    }
  }
}
