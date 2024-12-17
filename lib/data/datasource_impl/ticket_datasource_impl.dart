import 'package:ecoparking_management/data/datasource/ticket_datasource.dart';
import 'package:ecoparking_management/data/models/qr_data.dart';
import 'package:ecoparking_management/data/supabase_data/database_function_name.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TicketDataSourceImpl extends TicketDataSource {
  @override
  Future<Map<String, dynamic>> scanTicket({
    required String ticketId,
    required QrTimeType timeType,
    required String parkingId,
  }) {
    return Supabase.instance.client.rpc(
      DatabaseFunctionName.updateTicketTimes.functionName,
      params: {
        'ticket_id': ticketId,
        'time_type': timeType.toString(),
        'parkingid': parkingId,
      },
    );
  }
}
