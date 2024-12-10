enum DatabaseFunctionName {
  getParkingRolesByUser;

  String get functionName {
    switch (this) {
      case getParkingRolesByUser:
        return 'get_parking_roles_by_user';
    }
  }
}
