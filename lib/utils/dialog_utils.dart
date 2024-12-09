import 'package:ecoparking_management/config/app_config.dart';
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
                      Radius.circular(12.0),
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
}
