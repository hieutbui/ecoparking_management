import 'package:ecoparking_management/data/models/analysis_data.dart';

abstract class AnalysisRepository {
  Future<List<Map<String, dynamic>>> getLast12MonthsTotal({
    required String parkingId,
  });
  Future<List<Map<String, dynamic>>> getLastYearTotal({
    required String parkingId,
  });
  Future<List<Map<String, dynamic>>> getLastMonthTotal({
    required String parkingId,
  });
  Future<List<Map<String, dynamic>>> getYesterdayTotal({
    required String parkingId,
  });
  Future<List<Map<String, dynamic>>> getLast12MonthsTicketCount({
    required String parkingId,
  });
  Future<List<Map<String, dynamic>>> getLastYearTicketCount({
    required String parkingId,
  });
  Future<List<Map<String, dynamic>>> getLastMonthTicketCount({
    required String parkingId,
  });
  Future<List<Map<String, dynamic>>> getYesterdayTicketCount({
    required String parkingId,
  });
  Future<Map<String, dynamic>> exportData({
    required List<String> listTitles,
    required List<AnalysisData> listDatas,
  });
}
