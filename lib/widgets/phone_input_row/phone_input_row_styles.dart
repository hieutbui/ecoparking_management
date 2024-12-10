import 'package:flutter/material.dart';

class PhoneInputRowStyles {
  static const double borderWidth = 1.0;

  static TextStyle hintStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          );
  static TextStyle inputtedTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.inversePrimary,
          );
  static TextStyle errorTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.error,
          );

  static const BorderRadius borderRadius =
      BorderRadius.all(Radius.circular(15.0));
}
