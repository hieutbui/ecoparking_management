import 'package:ecoparking_management/pages/employee_management/employee_management_view.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({super.key});

  @override
  EmployeeManagementController createState() => EmployeeManagementController();
}

class EmployeeManagementController extends State<EmployeeManagement>
    with ControllerLoggy {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      EmployeeManagementView(controller: this);
}
