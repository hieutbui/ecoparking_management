import 'package:ecoparking_management/data/datasource/employee_datasource.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';

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
}
