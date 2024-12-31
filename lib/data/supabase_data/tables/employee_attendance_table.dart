import 'package:ecoparking_management/data/supabase_data/tables/supabase_table.dart';

class EmployeeAttendanceTable extends SupabaseTable {
  const EmployeeAttendanceTable();

  @override
  String get tableName => 'employee_attendance';

  String get id => 'id';
  String get employeeId => 'employee_id';
  String get parkingId => 'parking_id';
  String get date => 'date';
  String get clockIn => 'clock_in';
  String get clockOut => 'clock_out';
}
