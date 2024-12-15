import 'package:ecoparking_management/data/datasource/analysis_datasource.dart';
import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/analysis_repository.dart';

class AnalysisRepositoryImpl implements AnalysisRepository {
  final AnalysisDataSource _dataSource = getIt.get<AnalysisDataSource>();

  @override
  Future<List<Map<String, dynamic>>> getLast12MonthsTotal({
    required String parkingId,
  }) {
    return _dataSource.getLast12MonthsTotal(parkingId: parkingId);
  }

  @override
  Future<List<Map<String, dynamic>>> getLastMonthTotal({
    required String parkingId,
  }) {
    return _dataSource.getLastMonthTotal(parkingId: parkingId);
  }

  @override
  Future<List<Map<String, dynamic>>> getLastYearTotal({
    required String parkingId,
  }) {
    return _dataSource.getLastYearTotal(parkingId: parkingId);
  }

  @override
  Future<List<Map<String, dynamic>>> getYesterdayTotal({
    required String parkingId,
  }) {
    return _dataSource.getYesterdayTotal(parkingId: parkingId);
  }

  @override
  Future<List<Map<String, dynamic>>> getLast12MonthsTicketCount({
    required String parkingId,
  }) {
    return _dataSource.getLast12MonthsTicketCount(parkingId: parkingId);
  }

  @override
  Future<List<Map<String, dynamic>>> getLastMonthTicketCount({
    required String parkingId,
  }) {
    return _dataSource.getLastMonthTicketCount(parkingId: parkingId);
  }

  @override
  Future<List<Map<String, dynamic>>> getLastYearTicketCount({
    required String parkingId,
  }) {
    return _dataSource.getLastYearTicketCount(parkingId: parkingId);
  }

  @override
  Future<List<Map<String, dynamic>>> getYesterdayTicketCount({
    required String parkingId,
  }) {
    return _dataSource.getYesterdayTicketCount(parkingId: parkingId);
  }

  @override
  Future<Map<String, dynamic>> exportData({
    required List<String> listTitles,
    required List<AnalysisData> listDatas,
  }) {
    return _dataSource.exportData(listTitles: listTitles, listDatas: listDatas);
  }
}
