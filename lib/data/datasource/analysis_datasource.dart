abstract class AnalysisDataSource {
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
}
