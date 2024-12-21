import 'dart:io';
import 'package:ecoparking_management/data/datasource/employee_datasource.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/data/supabase_data/tables/parking_employee_table.dart';
import 'package:ecoparking_management/data/supabase_data/tables/profile_table.dart';
import 'package:ecoparking_management/utils/platform_infos.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart';

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

  @override
  Future<Map<String, dynamic>> saveEmployeeToXlsx({
    required List<String> listTitles,
    required List<EmployeeNestedInfo> employees,
  }) async {
    try {
      // Create an excel file
      Excel excel = Excel.createExcel();

      // Create a sheet
      excel.rename('Sheet1', 'employee');
      excel.setDefaultSheet('employee');

      // Get the sheet
      Sheet sheet = excel['employee'];

      // Adding the titles
      sheet.appendRow(
        listTitles.map((title) => TextCellValue(title)).toList(),
      );

      // Adding the data
      for (var employee in employees) {
        final profile = employee.profile;
        final workingStartTime = employee.workingStartTime;
        final workingEndTime = employee.workingEndTime;

        final listData = [
          employee.id,
          profile.name,
          profile.email,
          profile.phone,
          workingStartTime != null
              ? '${workingStartTime.hour}:${workingStartTime.minute}'
              : 'N/A',
          workingEndTime != null
              ? '${workingEndTime.hour}:${workingEndTime.minute}'
              : 'N/A',
        ];

        sheet.appendRow(
          listData.map((data) => TextCellValue(data ?? 'N/A')).toList(),
        );
      }

      // Saving the file

      if (PlatformInfos.isWeb) {
        excel.save(fileName: 'employee.xlsx');
      } else {
        var fileBytes = excel.save();
        var directory = await getApplicationDocumentsDirectory();

        if (fileBytes != null) {
          File(join('$directory/employee.xlsx'))
            ..createSync(recursive: true)
            ..writeAsBytesSync(fileBytes);
        }
      }

      return <String, dynamic>{
        'status': 'success',
      };
    } catch (e) {
      return <String, dynamic>{
        'status': 'error',
      };
    }
  }

  @override
  Future<List<Map<String, dynamic>?>?> searchEmployee({
    required String parkingId,
    required String searchKey,
  }) async {
    const table = ParkingEmployeeTable();
    const profileTable = ProfileTable();

    final selectQueryString =
        '*, profile(${profileTable.fullName}, ${profileTable.email}, ${profileTable.phone})';
    final parsingSearchKey = '%${searchKey.trim()}%';
    final orQueryString =
        '${profileTable.email}.ilike.$parsingSearchKey,${profileTable.phone}.ilike.$parsingSearchKey,${profileTable.fullName}.ilike.$parsingSearchKey';

    return Supabase.instance.client
        .from(table.tableName)
        .select(selectQueryString)
        .eq(table.parkingId, parkingId)
        .or(
          orQueryString,
          referencedTable: profileTable.tableName,
        );
  }
}