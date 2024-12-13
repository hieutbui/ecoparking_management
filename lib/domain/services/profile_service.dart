import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/data/models/parking_owner.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  Session? session;
  User? user;
  UserProfile? userProfile;
  ParkingEmployee? parkingEmployee;
  ParkingOwner? parkingOwner;

  bool get isAuthenticated => session != null && user != null;

  void setSession(Session session) {
    this.session = session;
  }

  void setUser(User user) {
    this.user = user;
  }

  void setUserProfile(UserProfile userProfile) {
    this.userProfile = userProfile;
  }

  void setParkingEmployee(ParkingEmployee parkingEmployee) {
    this.parkingEmployee = parkingEmployee;
  }

  void setParkingOwner(ParkingOwner parkingOwner) {
    this.parkingOwner = parkingOwner;
  }

  void clear() {
    session = null;
    user = null;
    userProfile = null;
    parkingEmployee = null;
    parkingOwner = null;
  }
}
