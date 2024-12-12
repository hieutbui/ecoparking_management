import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class ExceptionScreen extends StatefulWidget {
  const ExceptionScreen({super.key});

  @override
  ExceptionScreenController createState() => ExceptionScreenController();
}

class ExceptionScreenController extends State<ExceptionScreen>
    with ControllerLoggy {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void navigateToLogin() {
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
