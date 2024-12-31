import 'package:ecoparking_management/config/app_config.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback? onNotificationPressed;
  final bool? showBackButton;
  final Widget? actionButton;
  final Widget? checkInButton;
  final Widget? checkOutButton;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.onNotificationPressed,
    this.showBackButton = false,
    this.actionButton,
    this.checkInButton,
    this.checkOutButton,
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
          if (checkInButton != null) ...[
            const SizedBox(width: 8.0),
            checkInButton!,
          ],
          if (checkOutButton != null) ...[
            const SizedBox(width: 8.0),
            checkOutButton!,
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
