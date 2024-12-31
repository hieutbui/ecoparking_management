import 'package:ecoparking_management/data/models/employee_attendance.dart';
import 'package:equatable/equatable.dart';

class SelectableAttendance with EquatableMixin {
  final EmployeeAttendance employeeAttendance;
  final bool isSelected;

  const SelectableAttendance({
    required this.employeeAttendance,
    this.isSelected = false,
  });

  SelectableAttendance copyWith({
    EmployeeAttendance? employeeAttendance,
    bool? isSelected,
  }) {
    return SelectableAttendance(
      employeeAttendance: employeeAttendance ?? this.employeeAttendance,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [employeeAttendance, isSelected];
}
