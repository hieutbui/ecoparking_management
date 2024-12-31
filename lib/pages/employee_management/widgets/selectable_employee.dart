import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:equatable/equatable.dart';

class SelectableEmployee with EquatableMixin {
  final EmployeeNestedInfo employeeNestedInfo;
  final bool isSelected;

  const SelectableEmployee({
    required this.employeeNestedInfo,
    this.isSelected = false,
  });

  SelectableEmployee copyWith({
    EmployeeNestedInfo? employeeNestedInfo,
    bool? isSelected,
  }) {
    return SelectableEmployee(
      employeeNestedInfo: employeeNestedInfo ?? this.employeeNestedInfo,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [employeeNestedInfo, isSelected];
}
