import 'package:ecoparking_management/data/datasource/employee_datasource.dart';
import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/data/supabase_data/tables/parking_employee_table.dart';
import 'package:ecoparking_management/data/supabase_data/tables/profile_table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeDataSourceImpl extends EmployeeDataSource {
  @override
  Future<List<Map<String, dynamic>>> getAllEmployees({
    required String parkingId,
  }) async {
    const table = ParkingEmployeeTable();
    const profileTable = ProfileTable();

    final queryString =
        '*, profile(${profileTable.fullName}, ${profileTable.email}, ${profileTable.phone})';

    return Supabase.instance.client
        .from(table.tableName)
        .select(queryString)
        .eq(table.parkingId, parkingId);
  }

  @override
  Future<Map<String, dynamic>> updateEmployeeWorkingTime({
    required String employeeId,
    required String startTime,
    required String endTime,
  }) async {
    const table = ParkingEmployeeTable();

    return Supabase.instance.client
        .from(table.tableName)
        .update({
          table.workingStartTime: startTime,
          table.workingEndTime: endTime,
        })
        .eq(table.id, employeeId)
        .select()
        .single();
  }

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return Supabase.instance.client.auth.signUp(
      password: password,
      email: email,
      data: {
        'full_name': fullName,
      },
    );
  }

  @override
  Future<Map<String, dynamic>> createEmployee({
    required ParkingEmployee employee,
  }) async {
    const table = ParkingEmployeeTable();

    return Supabase.instance.client
        .from(table.tableName)
        .insert(employee)
        .select()
        .single();
  }

  @override
  Future<List<Map<String, dynamic>>> deleteEmployee({
    required List<String> employeeId,
  }) async {
    const table = ParkingEmployeeTable();

    return Supabase.instance.client
        .from(table.tableName)
        .delete()
        .inFilter(table.id, employeeId)
        .select();
  }
}
