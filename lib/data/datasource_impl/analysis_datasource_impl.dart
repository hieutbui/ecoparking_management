import 'package:ecoparking_management/data/datasource/analysis_datasource.dart';
import 'package:ecoparking_management/data/supabase_data/database_function_name.dart';
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
}
