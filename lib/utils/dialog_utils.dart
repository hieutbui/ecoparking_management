import 'package:ecoparking_management/config/app_config.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/widgets/time_imput_row/time_input_row.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static final GlobalKey<ScaffoldState> dialogScaffoldKey =
      GlobalKey<ScaffoldState>();

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = false,
    bool useRootNavigator = true,
  }) async {
    return showAdaptiveDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      useRootNavigator: useRootNavigator,
      builder: builder,
    );
  }

  static Future<bool?> showRequiredLogin<bool>(BuildContext context) async {
    return show<bool>(
      context: context,
      builder: _buildRequiredLoginDialog,
    );
  }

  static Future<void> showLoginError(BuildContext context) async {
    return show(
      context: context,
      builder: _buildLoginErrorDialog,
    );
  }

  static Future<void> showSomethingWentWrong(BuildContext context) async {
    return show(
      context: context,
      builder: _buildSomethingWentWrongDialog,
    );
  }

  static Future<void> showNotAllowedAccount(BuildContext context) async {
    return show(
      context: context,
      builder: _buildNotAllowedAccountDialog,
    );
  }

  static Future<void> showFillAllLoginFields(BuildContext context) async {
    return show(
      context: context,
      builder: _buildFillAllLoginFieldsDialog,
    );
  }

  static Future<ConfirmAction?> showEmployeeInfoDialog({
    required BuildContext context,
    required EmployeeNestedInfo employeeNestedInfo,
    required void Function(TimeOfDay) onStartShiftSelected,
    required void Function(TimeOfDay) onEndShiftSelected,
  }) async {
    return show<ConfirmAction>(
      context: context,
      builder: _buildEmployeeInfoDialog(
        employeeNestedInfo: employeeNestedInfo,
        onStartShiftSelected: onStartShiftSelected,
        onEndShiftSelected: onEndShiftSelected,
      ),
    );
  }

  static WidgetBuilder get _buildRequiredLoginDialog => (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Login Required',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'You need to login to access this feature.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.white,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppConfig.negativeTextColor,
                    ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      };

  static WidgetBuilder get _buildLoginErrorDialog => (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Login Error',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'An error occurred while trying to login. Please try again.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      };

  static WidgetBuilder get _buildSomethingWentWrongDialog =>
      (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Something Went Wrong',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'An error occurred while trying to process your request. Please try again.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      };

  static WidgetBuilder get _buildNotAllowedAccountDialog =>
      (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Account Not Allowed',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'Your account is not allowed to access this feature. Please contact the administrator.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      };

  static WidgetBuilder get _buildFillAllLoginFieldsDialog =>
      (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Fill All Fields',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'Please fill all fields to login.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      };

  static WidgetBuilder _buildEmployeeInfoDialog({
    required EmployeeNestedInfo employeeNestedInfo,
    required void Function(TimeOfDay) onStartShiftSelected,
    required void Function(TimeOfDay) onEndShiftSelected,
  }) =>
      (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Account Not Allowed',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name:',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Text(
                      employeeNestedInfo.profile.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email:',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Text(
                      employeeNestedInfo.profile.email,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phone:',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Text(
                      employeeNestedInfo.profile.phone ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Working start time: ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(width: 24.0),
                    TimeInputRow(
                      initialTime: employeeNestedInfo.workingStartTime,
                      onSelectTime: onStartShiftSelected,
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Working end time: ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(width: 24.0),
                    TimeInputRow(
                      initialTime: employeeNestedInfo.workingEndTime,
                      onSelectTime: onEndShiftSelected,
                    )
                  ],
                ),
              ],
            ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ConfirmAction.cancel),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.outline,
                ),
                shape: const WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              label: Text(
                'Cancel',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppConfig.negativeTextColor,
                    ),
              ),
              icon: const Icon(
                Icons.cancel,
                color: AppConfig.negativeTextColor,
              ),
            ),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ConfirmAction.ok),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
                shape: const WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              label: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              icon: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        );
      };
}

enum ConfirmAction {
  cancel,
  ok;

  String get title {
    switch (this) {
      case ConfirmAction.cancel:
        return 'Cancel';
      case ConfirmAction.ok:
        return 'OK';
    }
  }
}
