import 'package:ecoparking_management/data/supabase_data/tables/supabase_table.dart';

class ProfileTable implements SupabaseTable {
  const ProfileTable();

  @override
  String get tableName => 'profile';

  String get id => 'id';
  String get email => 'email';
  String get phone => 'phone';
  String get fullName => 'full_name';
  String get displayName => 'display_name';
  String get avatar => 'avatar';
  String get type => 'type';
  String get dob => 'dob';
  String get gender => 'gender';
  String get favoriteParkings => 'favorite_parking';
}
