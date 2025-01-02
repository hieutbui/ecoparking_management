import 'dart:io';
import 'package:ecoparking_management/data/datasource/employee_datasource.dart';
import 'package:ecoparking_management/data/models/employee_attendance.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/data/supabase_data/database_function_name.dart';
import 'package:ecoparking_management/data/supabase_data/tables/employee_attendance_table.dart';
import 'package:ecoparking_management/data/supabase_data/tables/parking_employee_table.dart';
import 'package:ecoparking_management/data/supabase_data/tables/profile_table.dart';
import 'package:ecoparking_management/utils/platform_infos.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
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

  @override
  Future<List<Map<String, dynamic>>?> getAttendance({
    required String parkingId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    const table = EmployeeAttendanceTable();

    final now = DateTime.now();

    String start =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    String end =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    if (startDate != null) {
      start =
          '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    }

    if (endDate != null) {
      end =
          '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
    }

    return Supabase.instance.client
        .from(table.tableName)
        .select()
        .eq(table.parkingId, parkingId)
        .gte(table.date, start)
        .lte(table.date, end);
  }

  @override
  Future<Map<String, dynamic>> checkIn({
    required String employeeId,
    required String parkingId,
    required String clockIn,
    required String date,
  }) async {
    final function = DatabaseFunctionName.upsertEmployeeAttendance.functionName;

    return Supabase.instance.client.rpc(
      function,
      params: {
        'p_employee_id': employeeId,
        'p_parking_id': parkingId,
        'p_clock_in': clockIn,
        'p_date': date,
      },
    );
  }

  @override
  Future<Map<String, dynamic>> checkOut({
    required String employeeId,
    required String parkingId,
    required String clockOut,
    required String date,
  }) async {
    final function = DatabaseFunctionName.upsertEmployeeAttendance.functionName;

    return Supabase.instance.client.rpc(
      function,
      params: {
        'p_employee_id': employeeId,
        'p_parking_id': parkingId,
        'p_clock_out': clockOut,
        'p_date': date,
      },
    );
  }

  @override
  Future<Map<String, dynamic>?> getEmployeeAttendance({
    required String employeeId,
  }) async {
    const table = EmployeeAttendanceTable();

    final now = DateTime.now();
    final dateFormatter = DateFormat('yyyy/MM/dd');

    return Supabase.instance.client
        .from(table.tableName)
        .select()
        .eq(table.employeeId, employeeId)
        .eq(table.date, dateFormatter.format(now))
        .maybeSingle();
  }

  @override
  Future<Map<String, dynamic>> saveAttendanceToXlsx({
    required List<EmployeeAttendance> attendances,
  }) async {
    try {
      // Create an excel file
      Excel excel = Excel.createExcel();

      // Create a sheet
      excel.rename('Sheet1', 'attendance');
      excel.setDefaultSheet('attendance');

      // Get the sheet
      Sheet sheet = excel['attendance'];

      // Adding the titles
      final listTitles = [
        'Mã nhân viên',
        'Thời gian vào',
        'Thời gian ra',
        'Ngày',
      ];

      sheet.appendRow(
        listTitles.map((title) => TextCellValue(title)).toList(),
      );

      // Adding the data
      final dateFormatter = DateFormat('dd/MM/yyyy');

      for (var attendance in attendances) {
        final clockInTime = attendance.clockIn;
        final clockOutTime = attendance.clockOut;

        final listData = [
          attendance.employeeId,
          clockInTime != null
              ? '${clockInTime.hour.toString().padLeft(2, '0')}:${clockInTime.minute.toString().padLeft(2, '0')}'
              : 'N/A',
          clockOutTime != null
              ? '${clockOutTime.hour.toString().padLeft(2, '0')}:${clockOutTime.minute.toString().padLeft(2, '0')}'
              : 'N/A',
          dateFormatter.format(attendance.date),
        ];

        sheet.appendRow(
          listData.map((data) => TextCellValue(data)).toList(),
        );
      }

      // Saving the file

      if (PlatformInfos.isWeb) {
        excel.save(fileName: 'attendance.xlsx');
      } else {
        var fileBytes = excel.save();
        var directory = await getApplicationDocumentsDirectory();

        if (fileBytes != null) {
          File(join('$directory/attendance.xlsx'))
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
}
