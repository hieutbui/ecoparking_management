import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:flutter/material.dart';

class DropdownGenderStyles {
  static const double buttonHeight = 56.0;

  static ButtonStyleData buttonStyleData(
    BuildContext context,
    bool isFocus,
  ) =>
      ButtonStyleData(
        padding: buttonPadding,
        height: buttonHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isFocus
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outlineVariant,
              width: 1.0,
            ),
          ),
        ),
      );
  static IconStyleData iconStyleData(
    BuildContext context,
    bool isFocus,
    Gender? selectedGender,
  ) =>
      IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: isFocus
              ? Theme.of(context).colorScheme.primary
              : selectedGender != null
                  ? Colors.black
                  : Theme.of(context).colorScheme.outlineVariant,
        ),
      );
  static DropdownStyleData dropdownStyleData(
    BuildContext context,
    bool isFocus,
  ) =>
      DropdownStyleData(
        elevation: 1,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(15.0),
        ),
      );

  static const EdgeInsetsGeometry buttonPadding = EdgeInsets.only(
    left: 10.0,
    right: 8.0,
  );

  static TextStyle hintStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          );
  static TextStyle itemsTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.inversePrimary,
          );
}
