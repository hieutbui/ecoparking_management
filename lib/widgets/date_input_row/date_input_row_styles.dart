import 'package:flutter/material.dart';

class DateInputRowStyles {
  static const double suffixIconSize = 16.0;

  static const InputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    borderSide: BorderSide.none,
  );

  static TextStyle hintTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          );
  static TextStyle inputtedTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.inversePrimary,
          );
}
