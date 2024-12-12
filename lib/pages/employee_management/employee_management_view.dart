import 'package:ecoparking_management/config/app_config.dart';
import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management_view_styles.dart';
import 'package:ecoparking_management/pages/employee_management/widgets/employee_view.dart';
import 'package:ecoparking_management/pages/employee_management/widgets/owner_view.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/info_multi_columns.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/table_info.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:ecoparking_management/widgets/info_card_with_title.dart';
import 'package:flutter/material.dart';

class EmployeeManagementView extends StatelessWidget with ViewLoggy {
  final EmployeeManagementController controller;

  const EmployeeManagementView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.employee.label,
      body: controller.isOwner
          ? OwnerView(controller: controller)
          : EmployeeView(controller: controller),
    );
  }
}
