import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class EmployeeRepository {
  Future<List<Map<String, dynamic>>> getAllEmployees({
    required String parkingId,
  });

  Future<Map<String, dynamic>> updateEmployeeWorkingTime({
    required String employeeId,
    required String startTime,
    required String endTime,
  });

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<Map<String, dynamic>> createEmployee({
    required ParkingEmployee employee,
  });

  Future<List<Map<String, dynamic>>> deleteEmployee({
    required List<String> employeeId,
  });
}
