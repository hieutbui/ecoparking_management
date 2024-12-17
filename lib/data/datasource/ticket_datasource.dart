import 'package:ecoparking_management/data/models/qr_data.dart';

abstract class TicketDataSource {
  Future<Map<String, dynamic>> scanTicket({
    required String ticketId,
    required QrTimeType timeType,
    required String parkingId,
  });
}
