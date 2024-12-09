import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/pages/login/login.dart';
import 'package:ecoparking_management/utils/dialog_utils.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget with ViewLoggy {
  final LoginController controller;

  const LoginView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.login.label,
      onNotificationPressed: () {},
      onExportDataPressed: () {},
      body: const Center(
        child: Text('test'),
      ),
    );
  }
}
