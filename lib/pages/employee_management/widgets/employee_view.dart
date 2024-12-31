import 'package:ecoparking_management/pages/employee_management/employee_management.dart';
import 'package:flutter/material.dart';

class EmployeeView extends StatelessWidget {
  final EmployeeManagementController controller;

  const EmployeeView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Chỉ chủ sở hữu bãi đỗ xe mới có thể truy cập trang này!',
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
      ),
    );
  }
}
