import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  Session? session;
  User? user;
  UserProfile? userProfile;

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

  void clear() {
    session = null;
    user = null;
    userProfile = null;
  }
}
