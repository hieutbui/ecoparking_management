import 'package:ecoparking_management/config/app_config.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onCheckInPressed;
  final VoidCallback? onCheckOutPressed;
  final bool? showBackButton;
  final Widget? actionButton;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.onNotificationPressed,
    this.onCheckInPressed,
    this.onCheckOutPressed,
    this.showBackButton = false,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.baseBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: AppConfig.appBarTitleTextColor,
              ),
        ),
        leading: (showBackButton ?? false)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => NavigationUtils.goBack(context),
              )
            : null,
        actions: <Widget>[
          if (onNotificationPressed != null) ...[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Theme.of(context).colorScheme.primary,
                size: 20.0,
              ),
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll<Color>(
                  Colors.transparent,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.0,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              onPressed: onNotificationPressed,
            ),
          ],
          if (onCheckInPressed != null) ...[
            const SizedBox(width: 8.0),
            TextButton.icon(
              onPressed: onCheckInPressed,
              label: Text(
                'Check In',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              icon: Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.onSecondary,
                size: 20.0,
              ),
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
            ),
          ],
          if (onCheckOutPressed != null) ...[
            const SizedBox(width: 8.0),
            TextButton.icon(
              onPressed: onCheckOutPressed,
              label: Text(
                'Check Out',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              icon: Icon(
                Icons.check_circle_outline,
                color: Theme.of(context).colorScheme.onSecondary,
                size: 20.0,
              ),
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
            ),
          ],
          if (actionButton != null) ...[
            const SizedBox(width: 8.0),
            actionButton!,
          ],
          const SizedBox(width: 16.0),
        ],
      ),
      body: body,
    );
  }
}
