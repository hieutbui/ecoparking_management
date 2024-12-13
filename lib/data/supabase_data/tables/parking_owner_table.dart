import 'package:ecoparking_management/data/supabase_data/tables/supabase_table.dart';

class ParkingOwnerTable implements SupabaseTable {
  const ParkingOwnerTable();

  @override
  String get tableName => 'parking_owner';

  String get id => 'id';
  String get profileId => 'profile_id';
  String get parkingId => 'parking_id';
  String get createdAt => 'created_at';
  String get currencyLocale => 'currency_locale';
}
