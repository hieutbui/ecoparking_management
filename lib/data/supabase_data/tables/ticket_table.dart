import 'package:ecoparking_management/data/supabase_data/tables/supabase_table.dart';

class TicketTable extends SupabaseTable {
  const TicketTable();

  @override
  String get tableName => 'ticket';

  String get id => 'id';
  String get parkingId => 'parking_id';
  String get userId => 'user_id';
  String get vehicleId => 'vehicle_id';
  String get startTime => 'start_time';
  String get endTime => 'end_time';
  String get days => 'days';
  String get hours => 'hours';
  String get total => 'total';
  String get status => 'status';
  String get createdAt => 'created_at';
  String get paymentIntentId => 'payment_intent_id';
  String get entryTime => 'entry_time';
  String get exitTime => 'exit_time';
}
