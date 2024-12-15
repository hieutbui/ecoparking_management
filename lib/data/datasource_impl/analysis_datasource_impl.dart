import 'dart:io';

import 'package:ecoparking_management/data/datasource/analysis_datasource.dart';
import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/data/supabase_data/database_function_name.dart';
import 'package:ecoparking_management/utils/platform_infos.dart';
import 'package:excel/excel.dart';
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
}
