import 'package:ecoparking_management/pages/employee_management/employee_management.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';

class EmployeeManagementView extends StatelessWidget with ViewLoggy {
  final EmployeeManagementController controller;

  const EmployeeManagementView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Employee Management',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
