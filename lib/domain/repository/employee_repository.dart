abstract class EmployeeRepository {
  Future<List<Map<String, dynamic>>> getAllEmployees({
    required String parkingId,
  });

  Future<Map<String, dynamic>> updateEmployeeWorkingTime({
    required String employeeId,
    required String startTime,
    required String endTime,
  });
}
