import 'package:ecoparking_management/data/datasource/ticket_datasource.dart';
import 'package:ecoparking_management/data/models/qr_data.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/ticket_repository.dart';

class TicketRepositoryImpl extends TicketRepository {
  final TicketDataSource _dataSource = getIt.get<TicketDataSource>();

  @override
  Future<Map<String, dynamic>> scanTicket({
    required String ticketId,
    required QrTimeType timeType,
    required String parkingId,
  }) {
    return _dataSource.scanTicket(
      ticketId: ticketId,
      timeType: timeType,
      parkingId: parkingId,
    );
  }
}
