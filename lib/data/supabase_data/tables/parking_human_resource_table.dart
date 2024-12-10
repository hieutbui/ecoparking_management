import 'package:ecoparking_management/data/supabase_data/tables/supabase_table.dart';

class ParkingHumanResourceTable implements SupabaseTable {
  const ParkingHumanResourceTable();

  @override
  String get tableName => 'parking_human_resource';

  String get id => 'id';
  String get parkingId => 'parking_id';
  String get ownerId => 'owner_id';
  String get employeeIds => 'employee_ids';
  String get createdAt => 'created_at';
}
