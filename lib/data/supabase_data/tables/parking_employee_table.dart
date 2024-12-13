import 'package:ecoparking_management/data/supabase_data/tables/supabase_table.dart';

class ParkingEmployeeTable implements SupabaseTable {
  const ParkingEmployeeTable();

  @override
  String get tableName => 'parking_employee';

  String get id => 'id';
  String get parkingId => 'parking_id';
  String get profileId => 'profile_id';
  String get currencyLocale => 'currency_locale';
  String get createdAt => 'created_at';
  String get workingStartTime => 'working_start_time';
  String get workingEndTime => 'working_end_time';
}
