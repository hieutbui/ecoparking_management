import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile with EquatableMixin {
  final String id;
  final String email;
  @JsonKey(name: 'type')
  final AccountType accountType;
  final String? phone;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'display_name')
  final String? displayName;
  final String? avatar;
  final DateTime? dob;
  final Gender? gender;

  UserProfile({
    required this.id,
    required this.email,
    required this.accountType,
    this.phone,
    this.fullName,
    this.displayName,
    this.avatar,
    this.dob,
    this.gender,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        accountType,
        phone,
        fullName,
        displayName,
        avatar,
        dob,
      ];
}

enum AccountType {
  user,
  employee,
  parkingOwner;

  @override
  String toString() {
    switch (this) {
      case user:
        return 'user';
      case employee:
        return 'employee';
      case parkingOwner:
        return 'parkingOwner';
    }
  }
}

enum Gender {
  male,
  female,
  other;

  @override
  String toString() {
    switch (this) {
      case male:
        return 'male';
      case female:
        return 'female';
      case other:
        return 'other';
    }
  }

  String toDisplayString() {
    switch (this) {
      case male:
        return 'Male';
      case female:
        return 'Female';
      case other:
        return 'Other';
    }
  }
}
