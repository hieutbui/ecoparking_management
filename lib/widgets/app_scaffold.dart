import 'package:ecoparking_management/config/app_config.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onExportDataPressed;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.onNotificationPressed,
    this.onExportDataPressed,
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
          if (onExportDataPressed != null) ...[
            const SizedBox(width: 8.0),
            IconButton(
              onPressed: onExportDataPressed,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
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
              icon: const Icon(
                Icons.download_rounded,
                color: Colors.white,
                size: 20.0,
              ),
            )
          ],
          const SizedBox(width: 16.0),
        ],
      ),
      body: body,
    );
  }
}
