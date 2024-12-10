import 'package:ecoparking_management/data/supabase_data/tables/supabase_table.dart';

class ParkingTable implements SupabaseTable {
  const ParkingTable();

  @override
  String get tableName => 'parking';

  String get id => 'id';
  String get name => 'parking_name';
  String get address => 'address';
  String get totalSlot => 'total_slot';
  String get availableSlot => 'available_slot';
  String get image => 'image';
  String get phone => 'phone';
  String get pricePerHour => 'price_per_hour';
  String get pricePerDay => 'price_per_day';
  String get pricePerMonth => 'price_per_month';
  String get pricePerYear => 'price_per_year';
  String get geolocation => 'geolocation';
}
