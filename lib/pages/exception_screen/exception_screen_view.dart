import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/pages/exception_screen/exception_screen.dart';
import 'package:ecoparking_management/pages/exception_screen/exception_screen_view_styles.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class ExceptionScreenView extends StatelessWidget with ViewLoggy {
  final ExceptionScreenController controller;

  const ExceptionScreenView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.exceptionScreen.label,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Something went wrong!',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
            const SizedBox(
              height: ExceptionScreenViewStyles.spacing,
            ),
            TextButton(
              onPressed: controller.navigateToLogin,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: Text(
                'Go back to login',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
