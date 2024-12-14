import 'package:ecoparking_management/data/datasource/employee_datasource.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeDataSource _dataSource = getIt.get<EmployeeDataSource>();

  @override
  Future<List<Map<String, dynamic>>> getAllEmployees({
    required String parkingId,
  }) {
    return _dataSource.getAllEmployees(parkingId: parkingId);
  }

  @override
  Future<Map<String, dynamic>> updateEmployeeWorkingTime({
    required String employeeId,
    required String startTime,
    required String endTime,
  }) {
    return _dataSource.updateEmployeeWorkingTime(
      employeeId: employeeId,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) {
    return _dataSource.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
  }

  @override
  Future<Map<String, dynamic>> createEmployee({
    required ParkingEmployee employee,
  }) {
    return _dataSource.createEmployee(employee: employee);
  }

  @override
  Future<List<Map<String, dynamic>>> deleteEmployee({
    required List<String> employeeId,
  }) {
    return _dataSource.deleteEmployee(employeeId: employeeId);
  }

  @override
  Future<Map<String, dynamic>> saveEmployeeToXlsx({
    required List<String> listTitles,
    required List<EmployeeNestedInfo> employees,
  }) {
    return _dataSource.saveEmployeeToXlsx(
      listTitles: listTitles,
      employees: employees,
    );
  }
}
