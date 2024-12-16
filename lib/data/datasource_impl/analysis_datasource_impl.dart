import 'dart:io';
import 'package:ecoparking_management/data/datasource/analysis_datasource.dart';
import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/data/supabase_data/database_function_name.dart';
import 'package:ecoparking_management/data/supabase_data/tables/parking_employee_table.dart';
import 'package:ecoparking_management/data/supabase_data/tables/parking_table.dart';
import 'package:ecoparking_management/data/supabase_data/tables/profile_table.dart';
import 'package:ecoparking_management/data/supabase_data/tables/ticket_table.dart';
import 'package:ecoparking_management/utils/platform_infos.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnalysisDataSourceImpl extends AnalysisDataSource {
  @override
  Future<List<Map<String, dynamic>>> getLast12MonthsTotal({
    required String parkingId,
  }) {
    return Supabase.instance.client.rpc(
      DatabaseFunctionName.getLast12MonthsTotal.functionName,
      params: {
        'parkingid': parkingId,
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getLastMonthTotal({
    required String parkingId,
  }) {
    return Supabase.instance.client.rpc(
      DatabaseFunctionName.getLastMonthTotal.functionName,
      params: {
        'parkingid': parkingId,
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getLastYearTotal({
    required String parkingId,
  }) {
    return Supabase.instance.client.rpc(
      DatabaseFunctionName.getLastYearTotal.functionName,
      params: {
        'parkingid': parkingId,
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getYesterdayTotal({
    required String parkingId,
  }) {
    return Supabase.instance.client.rpc(
      DatabaseFunctionName.getYesterDayTotal.functionName,
      params: {
        'parkingid': parkingId,
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getLast12MonthsTicketCount({
    required String parkingId,
  }) {
    return Supabase.instance.client.rpc(
      DatabaseFunctionName.getLast12MonthsTicketCount.functionName,
      params: {
        'parkingid': parkingId,
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getLastYearTicketCount({
    required String parkingId,
  }) {
    return Supabase.instance.client.rpc(
      DatabaseFunctionName.getLastYearTicketCount.functionName,
      params: {
        'parkingid': parkingId,
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getLastMonthTicketCount({
    required String parkingId,
  }) {
    return Supabase.instance.client.rpc(
      DatabaseFunctionName.getLastMonthTicketCount.functionName,
      params: {
        'parkingid': parkingId,
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getYesterdayTicketCount({
    required String parkingId,
  }) {
    return Supabase.instance.client.rpc(
      DatabaseFunctionName.getYesterDayTicketCount.functionName,
      params: {
        'parkingid': parkingId,
      },
    );
  }

  @override
  Future<Map<String, dynamic>> exportData({
    required List<String> listTitles,
    required List<AnalysisData> listDatas,
  }) async {
    try {
      // Create an excel file
      Excel excel = Excel.createExcel();

      // Create a sheet
      excel.rename('Sheet1', 'data');
      excel.setDefaultSheet('data');

      // Get the sheet
      Sheet sheet = excel['data'];

      // Adding the titles
      sheet.appendRow(
        listTitles.map((e) => TextCellValue(e)).toList(),
      );

      // Insert the data
      for (var data in listDatas) {
        sheet.appendRow([
          TextCellValue(data.name),
          DoubleCellValue(data.valueY),
        ]);
      }

      // Save the file

      if (PlatformInfos.isWeb) {
        excel.save(fileName: 'data.xlsx');
      } else {
        var fileBytes = excel.save();
        var directory = await getApplicationDocumentsDirectory();

        if (fileBytes != null) {
          File(join('$directory/data.xlsx'))
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
  Future<Map<String, dynamic>> getParkingInfo({
    required String parkingId,
  }) {
    const table = ParkingTable();

    return Supabase.instance.client
        .from(table.tableName)
        .select()
        .eq(table.id, parkingId)
        .single();
  }

  @override
  Future<List<Map<String, dynamic>>> getCurrentEmployee({
    required String parkingId,
  }) {
    const table = ParkingEmployeeTable();
    const profileTable = ProfileTable();

    final queryString =
        '*, profile(${profileTable.fullName}, ${profileTable.email}, ${profileTable.phone})';

    final now = TimeOfDay.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final timeZoneOffset = DateTime.now().timeZoneOffset;
    final offsetSign = timeZoneOffset.isNegative ? '-' : '+';
    final offsetHours = timeZoneOffset.inHours.toString().padLeft(2, '0');
    final currentTime = '$hour:$minute$offsetSign$offsetHours';

    return Supabase.instance.client
        .from(table.tableName)
        .select(queryString)
        .eq(table.parkingId, parkingId)
        .lte(table.workingStartTime, currentTime)
        .gte(table.workingEndTime, currentTime);
  }

  @override
  Future<List<Map<String, dynamic>>> getTicket({
    required String parkingId,
  }) {
    const table = TicketTable();
    const queryString = ('*, vehicle(license_plate)');

    return Supabase.instance.client
        .from(table.tableName)
        .select(queryString)
        .eq(table.parkingId, parkingId);
  }
}
