import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownPreviousViewTypeStyles {
  static const double buttonHeight = 56.0;
  static const double buttonWidth = 175.0;

  static ButtonStyleData get buttonStyleData => const ButtonStyleData(
      padding: buttonPadding,
      height: buttonHeight,
      width: buttonWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ));
  static IconStyleData iconStyleData(
    BuildContext context,
    bool isFocus,
  ) =>
      IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: isFocus
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outlineVariant,
        ),
      );
  static DropdownStyleData dropdownStyleData(
    BuildContext context,
  ) =>
      DropdownStyleData(
        elevation: 1,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(16.0),
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
