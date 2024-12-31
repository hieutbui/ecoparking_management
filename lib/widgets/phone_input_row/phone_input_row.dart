import 'package:ecoparking_management/widgets/phone_input_row/phone_input_row_styles.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneInputRow extends StatelessWidget {
  final String? initialPhoneNumber;
  final void Function(PhoneNumber?)? onChanged;

  const PhoneInputRow({
    super.key,
    this.initialPhoneNumber,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      controller: PhoneController(
        initialValue: PhoneNumber(
          isoCode: IsoCode.VN,
          nsn: initialPhoneNumber ?? '',
        ),
      ),
      style: PhoneInputRowStyles.inputtedTextStyle(context),
      onChanged: onChanged,
      countrySelectorNavigator: const CountrySelectorNavigator.page(),
      validator: PhoneValidator.compose([
        PhoneValidator.required(context, errorText: 'SĐT không được để trống'),
        PhoneValidator.valid(context),
      ]),
      countryButtonStyle: CountryButtonStyle(
        textStyle: PhoneInputRowStyles.inputtedTextStyle(context),
      ),
      decoration: InputDecoration(
        hintText: 'Số điện thoại',
        hintStyle: PhoneInputRowStyles.hintStyle(context),
        errorStyle: PhoneInputRowStyles.errorTextStyle(context),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
